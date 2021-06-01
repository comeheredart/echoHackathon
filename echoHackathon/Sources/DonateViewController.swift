//
//  DonateViewController.swift
//  echoHackathon
//
//  Created by JEN Lee on 2021/05/27.
//

import UIKit

class DonateViewController: UIViewController {

    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "기부하기"
        
        tableviewSetting()
        
    }
    
    
    func tableviewSetting() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
    
        tableview.register(DonateTVC.Nib, forCellReuseIdentifier: DonateTVC.identifier)
    }
    

    
}

extension DonateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "DonateTVC") as? DonateTVC else { return UITableViewCell() }
        
        switch indexPath.row {
        
        case 0:
            cell.imageview.image = UIImage(named: "coal")
            cell.title.text = "석탄 발전 멈춰!"
            cell.subtitle.text = "온실가스 주범 석탄발전소 건설중단"
            break
            
        case 1:
            cell.imageview.image = UIImage(named: "grand")
            cell.title.text = "연탄에서 보일러로"
            cell.subtitle.text = "국내 15만 가구 아직 '연탄 생활'"
            break
            
        case 2:
            cell.imageview.image = UIImage(named: "sun")
            cell.title.text = "태양에너지 발전 기부"
            cell.subtitle.text = "친환경 에너지에 기부하세요"
            break
        
        default:
            
            break
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    
    
    
    
    
}
