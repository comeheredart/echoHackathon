//
//  MapViewController.swift
//  echoHackathon
//
//  Created by JEN Lee on 2021/05/21.
//

import UIKit
import NMapsMap

class MapViewController: UIViewController, CLLocationManagerDelegate {

    //MARK: IBOutlet
    @IBOutlet var mapView: NMFMapView!
    @IBOutlet var tableView: UITableView!
    
    
    //MARK: Variables
    var locationManager: CLLocationManager!
    
    var sumValue: Int = 0
    var Co2Value: Double = 0
    var wonValue: Int = 0
    
    var titleArray = ["전력 사용량","절약된 전기세","탄소 배출량","나무 심기"]
    var valueArray : [Int] = []
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSetting()
        locationSetting()
        
        valueArray = [self.sumValue, self.wonValue, Int(self.Co2Value), 0]
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
    
    func locationSetting() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        let coor = locationManager.location?.coordinate
        var latitude = (coor?.latitude) ?? 0.0
        var longitude = coor?.longitude ?? 0.0
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude))
        mapView.moveCamera(cameraUpdate)
        mapView.zoomLevel = 8
    }
    
    

   

}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CompareTVC.identifier) as? CompareTVC else { return UITableViewCell() }
        
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.useLabel.text = "\(valueArray[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
}


