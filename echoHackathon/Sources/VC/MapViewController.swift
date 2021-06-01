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
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var segmentControl: UISegmentedControl!
    
    //MARK: Variables
    var locationManager: CLLocationManager!
    var picker: UIPickerView?
    
    var sumValue: Int = 0
    var Co2Value: Double = 0
    var wonValue: Int = 0
    
    var titleArray = ["전력 사용량","절약된 전기세","탄소 배출량"]
    var unitArray = ["kwh", "원", "kg"]
    var valueArray : [Int] = []
    var cityDic : [String: String] = ["Seoul":"서울특별시", "Gwangju":"광주광역시", "Incheon":"인천광역시", "Daegu":"대구광역시","Ulsan":"울산광역시","Daejeon":"대전광역시","Busan":"부산광역시","Gyeonggi-do":"경기도", "Gangwon-do":"강원도", "Chungcheongnam-do":"충청남도","Chung-cheong bukdo":"충청북도","Gyeongsangbuk-do":"경상북도","Gyeongsangnam-do":"경상남도","Jeollabuk-do":"전라북도", "Jeollanam-do":"전라남도", "Jeju-do":"제주도"]
    
    var cityAvg = ["Seoul":212, "Incheon": 198] //22439 //21449
    var goodEx = [170, 0000, 0000] //전기세랑 탄소 배출량 계산 ..
    var badEx = [250, 0000, 0000]
    var topGoodValArr = [5, 7, 4]
    var topBadValArr = [84, 75, 91]
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        
        tableViewSetting()
        locationSetting()
        
        addMarker()
        
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
    
    
    func addMarker() {
        
        guard let path = Bundle.main.path(forResource: "center", ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            guard let array = json as? [Any] else { return }
            for item in array {
                guard let dict = item as? [String: Any] else { return }
                guard let name = dict["name"] as? String else { return }
                guard let center = dict["center"] as? [Double] else { return }
                
                
                let marker = NMFMarker()
                marker.position = NMGLatLng(lat: center[0], lng: center[1])
                marker.mapView = mapView
                
                marker.touchHandler = { (overlay: NMFOverlay) -> Bool in
                    print("마커 터치")
                    return true
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    func locationSetting() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        if let coor = locationManager.location?.coordinate {
            let latitude = coor.latitude
            let longitude = coor.longitude
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude, lng: longitude))
            
            mapView.moveCamera(cameraUpdate)
            mapView.zoomLevel = 8
        }
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(locationManager.location!, completionHandler: {
            (placemarks, error) -> Void in
            
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            let name = placeMark.name!
            let country =  placeMark.country!
            let isoCountryCode =  placeMark.isoCountryCode!
            let locality =  placeMark.administrativeArea!
            
            
            print("name = \(name)")
            print("country = \(country)")
            print("isoCountryCode = \(isoCountryCode)")
            print("locality = \(locality)")
            
            self.cityLabel.text = self.cityDic[locality]
            
        })
    }
    
    @objc func segmentChanged() {
        tableView.reloadData()
    }
    
    
    //MARK: @IBAction
    @IBAction func otherCityBtnClicked(_ sender: UIButton) {
        //AlertView 띄우기
        makeAlert(title: "알림", message: "지도를 클릭하여 다른 지역과 비교해보세요!")
    }
    
    
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CompareTVC.identifier) as? CompareTVC else { return UITableViewCell() }
        
        cell.titleLabel.text = titleArray[indexPath.row]
        //cell.useLabel.text = "\(valueArray[indexPath.row])" //이걸 good 이나 bad 로 바꾸기
        
        let idx = indexPath.row
        
        switch segmentControl.selectedSegmentIndex {
        
        case 0:
            cell.topView.backgroundColor = .green
            cell.morelessLabel.text = "적게 소비"
            cell.useLabel.text = "\(goodEx[idx]) \(unitArray[idx])"
            cell.topValueLabel.text = "\(topGoodValArr[idx]) %"
            break
            
        case 1:
            cell.topView.backgroundColor = .red
            cell.morelessLabel.text = "많이 소비"
            cell.useLabel.text = "\(badEx[indexPath.row]) \(unitArray[idx])"
            cell.topValueLabel.text = "\(topBadValArr[indexPath.row]) %"
            break
            
        default:
            break
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    
}

