//
//  FindingDeviceViewController.swift
//  bluetoothAndArduino
//
//  Created by 박현준 on 10/12/23.
//

import UIKit
import CoreBluetooth

class FindingDeviceViewController: UITableViewController {

    var peripheralList : [(peripheral : CBPeripheral, RSSI : Float)] = [] {
        didSet {
            print("peripheralList count = \(peripheralList.count)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        configBluetooth()
        configTableView()
    }

    private func setUI() {
        view.backgroundColor = .white
        title = "블루투스 검색"
    }
    
    private func configTableView() {
        tableView.register(ScanBluetoothCell.self, forCellReuseIdentifier: ScanBluetoothCell.identifier)
    }
    
    // MARK: - TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripheralList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScanBluetoothCell.identifier, for: indexPath) as? ScanBluetoothCell else {
            return UITableViewCell()
        }
        // peripheral의 이름을 cell에 나타나도록 합니다.
        let peripheralName = peripheralList[indexPath.row].peripheral.name
        cell.titleLabel.text = peripheralName
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 테이블 뷰의 셀을 선택했을 때 UI에 나타나는 효과입니다.
        tableView.deselectRow(at: indexPath, animated: true)
        print("cell Tap")
        // 선택된 Pheripheral을 연결합니다. 검색을 중단하고, peripheralList에 저장된 peripheral 중 클릭된 것을 찾아 연결합니다.
        serial.stopScan()
        let selectedPeripheral = peripheralList[indexPath.row].peripheral
        // serial의 connectToPeripheral 함수에 선택된 peripheral을 연결하도록 요청합니다.
        serial.connectToPeripheral(selectedPeripheral)
    }
}

extension FindingDeviceViewController: BluetoothSerialDelegate {
    private func configBluetooth() {
        // scan 버튼을 눌러 기기 검색을 시작할 때마다 list를 초기화합니다.
        peripheralList = []
        // serial의 delegate를 ScanViewController로 설정합니다. serial에서 delegate의 메서드를 호출하면 이 클래스에서 정의된 메서드가 호출됩니다.
        serial.delegate = self
        // 뷰가 로드된 후 검색을 시작합니다.
        serial.startScan()
        print("scan start")
    }
    
    func serialDidDiscoverPeripheral(peripheral : CBPeripheral, RSSI : NSNumber?) {
        // 이미 저장되어 있는 기기라면 return합니다.
        for existing in peripheralList {
            if existing.peripheral.identifier == peripheral.identifier {return}
        }
        // MARK: 이름 없는 경우 return
        if peripheral.name == nil {
            return
        }
        // 신호의 세기에 따라 정렬하도록 합니다.
        let fRSSI = RSSI?.floatValue ?? 0.0
        peripheralList.append((peripheral : peripheral , RSSI : fRSSI))
        peripheralList.sort { $0.RSSI < $1.RSSI}
        // tableView를 다시 호출하여 검색된 기기가 반영되도록 합니다.
        tableView.reloadData()
    }
    
    func serialDidConnectPeripheral(peripheral : CBPeripheral) {
        print("블루투스 연결 성공")
        let connectSuccessAlert = UIAlertController(title: "블루투스 연결 성공", message: "\(peripheral.name ?? "알수없는기기")와 성공적으로 연결되었습니다.", preferredStyle: .actionSheet)
        let confirm = UIAlertAction(title: "확인", style: .default, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        })
        connectSuccessAlert.addAction(confirm)
        present(connectSuccessAlert, animated: true, completion: nil)
    }
}
