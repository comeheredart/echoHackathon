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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "DonateTVC") as? DonateTVC else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    
    
    
    
    
    
}
