//
//  MapViewController.swift
//  echoHackathon
//
//  Created by JEN Lee on 2021/05/21.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController {

    //MARK: IBOutlet
    @IBOutlet var mapView: NMFMapView!
    @IBOutlet var tableView: UITableView!
    
    //MARK: Variables
    var sumValue: Int = 0
    var Co2Value: Double = 0
    var wonValue: Int = 0
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(sumValue)
    }
    
    //MARK: Function
    
    func configure() {
        
    }
    
    func tableViewSetting() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(CompareTVC.Nib, forCellReuseIdentifier: CompareTVC.identifier)
    }
    
    

   

}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CompareTVC.identifier) as? CompareTVC else { return UITableViewCell() }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
