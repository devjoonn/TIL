//
//  HomeViewController.swift
//  bluetoothAndArduino
//
//  Created by 박현준 on 10/12/23.
//

import UIKit
import CoreBluetooth
import DGCharts
import SnapKit

class HomeViewController: UIViewController {
    
    var chartView = LineChartView()
    
    
    var serialMessageLabel: UILabel = {
        $0.text = "연결되지 않음"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 15)
        return $0
    }(UILabel())
    
    let startButton: UIButton = {
        $0.setTitle("시작", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 13
        $0.titleLabel?.font = .systemFont(ofSize: 16)
        $0.addTarget(self, action: #selector(startButtonTaped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    var dataEntries = [ChartDataEntry]()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configBluetooth()
        setUI()
        configNavBar()
        configChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        serial.delegate = self
    }

    private func setUI() {
        view.backgroundColor = .white
        title = "Bluetooth"
        
        [chartView, serialMessageLabel, startButton].forEach {
            view.addSubview($0)
        }
       
        chartView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(500)
        }
        serialMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
        }
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Bluetooth serial setting
    private func configBluetooth() {
        serial = BluetoothSerial.init()
        serial.delegate = self
    }
    
    private func configChart() {
        chartView.delegate = self
        chartView.noDataText = "Loading..."
        chartView.chartDescription.text = "chart"
        chartView.setVisibleXRangeMaximum(1000)
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        
        let leftAxis = chartView.leftAxis
        leftAxis.axisMinimum = 0
    }
    
    private func configNavBar() {
        let gearButton = UIBarButtonItem(image: UIImage(systemName: "gear")?.withTintColor(.black),
                                         style: .done,
                                         target: self,
                                         action: #selector(findingDeviceButtonTaped))
        self.navigationItem.rightBarButtonItem = gearButton
    }
    
    // MARK: - Helper Function
    @objc func findingDeviceButtonTaped() {
        let findingDeviceVC = FindingDeviceViewController()
        self.navigationController?.pushViewController(findingDeviceVC, animated: true)
    }
    
    @objc func startButtonTaped() {
        if !serial.bluetoothIsReady {
            print("시리얼이 준비되지 않음")
            return
        }
        print("Delegate 확인 = \(serial.delegate)")
        serialMessageLabel.text = "waiting for Peripheral's messege"
    }
    
    @objc func updateChartData(data: String) {
        guard let data = Float(data) else { return }
        // ChartDataEntry 객체 생성 후 dataEntries 배열에 추가
        let newEntry = ChartDataEntry(x: Double(dataEntries.count), y: Double(data))
        
        dataEntries.append(newEntry)
        
        if dataEntries.count > 250 {
            // 첫 번째 요소 제거
            dataEntries.removeFirst()
            
            // 인덱스 재조정 - x 값들을 다시 0부터 시작하도록 재설정
            for i in 0..<dataEntries.count {
                dataEntries[i].x = Double(i)
            }
        }
        
        let dataSet = LineChartDataSet(entries: dataEntries, label:"ECG")
        dataSet.colors = [UIColor.red]
        dataSet.drawValuesEnabled = false
        dataSet.drawCirclesEnabled = false
        
        let chartData = LineChartData(dataSet: dataSet)
        chartView.data = chartData
        chartView.notifyDataSetChanged()
    }
}

extension HomeViewController: BluetoothSerialDelegate {
    func serialDidReceiveMessage(valueA: String, valueB: String, valueC: String) {
        print("home에서 delegate로 받은 valueA = \(valueA), valueB = \(valueB), valueC = \(valueC)")
        
        if Int(valueB) ?? 0 >= 150 || Int(valueB) ?? 0 <= 30 {
//            showAlertViewController()
        }
        let attributedString = NSMutableAttributedString(string: "심박수 : \(valueB)       호흡수: \(valueC)", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.black])
        
        serialMessageLabel.attributedText = attributedString
        self.updateChartData(data: valueA)
    }
    
    private func showAlertViewController() {
        let connectSuccessAlert = UIAlertController(title: "위험", message: "의사에게 연락하세요.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default, handler: { _ in
        })
        connectSuccessAlert.addAction(confirm)
        present(connectSuccessAlert, animated: true, completion: nil)
    }
}

extension HomeViewController: ChartViewDelegate {
    
}
