//
//  ViewController.swift
//  echoHackathon
//
//  Created by JEN Lee on 2021/05/21.
//

import UIKit

class ViewController: UIViewController {

    
    //MARK:- IBOutlet Part
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!

    @IBOutlet var ElectricSumLabel: UILabel!
    @IBOutlet var Co2Label: UILabel!
    @IBOutlet var wonLabel: UILabel!

    @IBOutlet var sumView: UIView!
    @IBOutlet var co2View: UIView!
    @IBOutlet var priceView: UIView!
    
    
    //MARK:- Variable Part
    
    var electicModels = [ElectronicModel]()
    var modeModels = [ModeModel]()
    var kwhList: [Int] = [0, 0, 0, 0, 0]
    var offList = [Int]()

    
    //MARK:- Constraint Part
    
    
    
    
    //MARK:- Life Cycle Part
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        setData()
        viewSetting()
        tableViewSetting()
        collectionViewSetting()
        setTimer()
    }

    
    
    //MARK:- IBAction Part
    
    @IBAction func mapPageBtnClicked(_ sender: UIBarButtonItem) {
        guard let nextVC = self.storyboard?.instantiateViewController(identifier: "MapViewController") as? MapViewController else {
            return
        }
        
        nextVC.sumValue = Int(self.ElectricSumLabel.text!)!
        nextVC.Co2Value = Double(self.Co2Label.text!)!
        nextVC.wonValue = Int(self.wonLabel.text!)!
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    
    
    
    //MARK:- default Setting Function Part
    
    func viewSetting() {
        sumView.layer.cornerRadius = sumView.frame.width / 2
        sumView.backgroundColor = .echo_green1
        
        co2View.layer.cornerRadius = co2View.frame.width / 2
        co2View.backgroundColor = .echo_green2
        
        priceView.layer.cornerRadius = priceView.frame.width / 2
        priceView.backgroundColor = .echo_green3
        
        
    }
    
    
    func tableViewSetting() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ElectronicTVC.Nib, forCellReuseIdentifier: ElectronicTVC.identifier)
    }
    
    func collectionViewSetting() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ModeCVC.Nib, forCellWithReuseIdentifier: ModeCVC.identifier)
    }
    
    
    func setData() {
        
        electicModels.append(contentsOf: [
            
            ElectronicModel(name: "샘성 냉장고", perSecond: 30, isOn: false),
            ElectronicModel(name: "엘지 티비", perSecond: 40, isOn: false),
            ElectronicModel(name: "김치냉장고", perSecond: 50, isOn: true),
            ElectronicModel(name: "휘센 에어컨", perSecond: 80, isOn: false),
            ElectronicModel(name: "내 컴퓨터", perSecond: 30, isOn: false),

        
        ])
        
        modeModels.append(contentsOf: [
            
            ModeModel(modeName: "외출 모드", modeDescription: "외출할 때 불끄기!", deviceOff: [1, 3, 4]),
            ModeModel(modeName: "취침 모드", modeDescription: "잠자기 전 절전모드 온!", deviceOff: [1, 3, 4]),
            ModeModel(modeName: "절전 모드", modeDescription: "필요없는 가전은 끄자!", deviceOff: [1, 2, 3, 4]),
            ModeModel(modeName: "지구 사랑 모드", modeDescription: "사랑아 지구해~", deviceOff: [0, 1, 2, 3, 4])
        
        ])
        
        
    }
    
    
    //MARK:- Function Part
    
    func calcSum() {
        var sum = 0
        
        for item in kwhList {
            sum += item
        }
        
        ElectricSumLabel.text = "\(sum)"
        Co2Label.text = "\(round(Double(sum) / 0.45))"
        wonLabel.text = "\(sum * 100)"
        //1당 0.45 , 100원
    }
    
    
    func setTimer() {
        //1초에 한번씩 업뎃
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.calcSum()
        }
        timer.fire()
        
    }




}


//MARK:- extension 부분

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return electicModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElectronicTVC", for: indexPath) as? ElectronicTVC else { return UITableViewCell() }
        
        cell.configure(with: electicModels[indexPath.row])
        
        
        //각 셀의 kwh 값 배열 갱신 1초마다..
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in

            self.kwhList[indexPath.row] = cell.getEachSum()
        }
        
        
        //mode 꺼주기
        for item in offList {
            if indexPath.row == item {
                cell.turnOff()

            }
        }
        
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    
    
    
    
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modeModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModeCVC.identifier, for: indexPath) as? ModeCVC else { return UICollectionViewCell() }
        cell.configure(with: modeModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //mode 클릭했을 때..
        offList = modeModels[indexPath.row].deviceOff
        tableView.reloadData()
    
        // 그럼 이제 이 index.row 테이블 뷰 셀들 꺼줘야함
        //배열 놓고 그거 Observe 하고 바뀌면 테이블 뷰 reload 하는 식 -> cell 에서 저기 배열에 들어이쓰면 꺼줘야 함
    
        //이제 선택되었으면 색깔바꾸기
        
    }
    
    

    

}
