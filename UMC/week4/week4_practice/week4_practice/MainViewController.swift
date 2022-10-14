//
//  MainViewController.swift
//  week4_practice
//
//  Created by 박현준 on 2022/10/13.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var table: UITableView!
    
    // 시간 표시
//    let formatter: DateFormatter = {
//        let f = DateFormatter()
//        f.dateStyle = .long
//        f.timeStyle = .short
//        f.locale = Locale(identifier: "ko_kr")
//        return f
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        table.reloadData() // tableView 에게 목록 업데이트 하도록 알려줌
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Memo.dummyMemoList.count
    }
    
    //섹션을 나눔
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "myCell")
//        cell.textLabel?.text = "\(indexPath.row)"
//        cell.detailTextLabel?.text = "\(indexPath.description)"
//        return cell
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let target = Memo.dummyMemoList[indexPath.row]
        
        cell.titleLabel.text = target.title
        cell.contentLabel.text = target.content
//        cell.contentLabel.text = formatter.string(from: target.content)
        return cell
    }
    
    // cell을 클릭시 또는 선택시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
}

