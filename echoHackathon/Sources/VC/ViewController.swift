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
    var sumOfEnergy:Double = 0
    var baseTax:Int = 0

    
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
        
//        nextVC.sumValue = Int(self.ElectricSumLabel.text!)!
//        nextVC.Co2Value = Double(self.Co2Label.text!)!
//        nextVC.wonValue = Int(self.wonLabel.text!)!
//        
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
            
            ElectronicModel(name: "?????? ?????????", perSecond: 1, isOn: false),
            ElectronicModel(name: "?????? ??????", perSecond: 1, isOn: false),
            ElectronicModel(name: "???????????????", perSecond: 1, isOn: true),
            ElectronicModel(name: "?????? ?????????", perSecond: 1, isOn: false),
            ElectronicModel(name: "??? ?????????", perSecond: 1, isOn: false),

        ])
        
        modeModels.append(contentsOf: [
            
            ModeModel(modeName: "?????? ??????", modeDescription: "????????? ??? ?????????!", deviceOff: [1, 3, 4]),
            ModeModel(modeName: "?????? ??????", modeDescription: "????????? ??? ???????????? ???!", deviceOff: [1, 3, 4]),
            ModeModel(modeName: "?????? ??????", modeDescription: "???????????? ????????? ??????!", deviceOff: [1, 2, 3, 4]),
            ModeModel(modeName: "?????? ?????? ??????", modeDescription: "????????? ?????????~", deviceOff: [0, 1, 2, 3, 4])
        
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
        
        let wonVal = calcTax(eps: sum) + Double(baseTax)
        wonLabel.text = "\(Int(wonVal))"
        //1??? 0.45
    }
    
    func calcTax(eps:Int) -> Double{
        let date:Date = Date()
        let month: String
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        month = formatter.string(from: date)
        
        var standard1:Int = 0
        var standard2:Int = 0
        
        sumOfEnergy += Double(eps)
        
        if(month == "7" || month == "8"){
            standard1 = 300
            standard2 = 450
        }else{
            standard1 = 200
            standard2 = 400
        }
        if(Int(sumOfEnergy) <= standard1){
            baseTax = 910
            return Double(eps) * 93.3
        }else if(Int(sumOfEnergy) > standard1 && Int(sumOfEnergy) <= standard2){
            baseTax = 1600
            return Double(eps) * 187.9
        }else{
            baseTax = 7300
            return Double(eps) * 280.6
        }
    }
    
    
    func setTimer() {
        //1?????? ????????? ??????
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.calcSum()
        }
        timer.fire()
        
    }


    //MARK: IBAction
    @IBAction func donateBtnClicked(_ sender: UIButton) {
        
    }
    


}


//MARK:- extension ??????

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return electicModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElectronicTVC", for: indexPath) as? ElectronicTVC else { return UITableViewCell() }
        
        cell.configure(with: electicModels[indexPath.row])
        
        
        //??? ?????? kwh ??? ?????? ?????? 1?????????..
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in

            self.kwhList[indexPath.row] = cell.getEachSum()
        }
        
        
        //mode ?????????
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
        //mode ???????????? ???..
        offList = modeModels[indexPath.row].deviceOff
        tableView.reloadData()
    
        // ?????? ?????? ??? index.row ????????? ??? ?????? ????????????
        //?????? ?????? ?????? Observe ?????? ????????? ????????? ??? reload ?????? ??? -> cell ?????? ?????? ????????? ??????????????? ????????? ???
    
        //?????? ?????????????????? ???????????????
        
    }
    
    

    

}
