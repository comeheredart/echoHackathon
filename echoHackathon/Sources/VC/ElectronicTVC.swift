//
//  ElectronicTVC.swift
//  echoHackathon
//
//  Created by JEN Lee on 2021/05/21.
//

import UIKit

class ElectronicTVC: UITableViewCell {

    //MARK:- Variable Part
    static let identifier = "ElectronicTVC"
    static var Nib = UINib(nibName: "ElectronicTVC", bundle: nil)
    var perSecond: Int = 0
    var kwhValue: Int = 0
    
    
    //MARK:- IBOutlet Part
    @IBOutlet var view: UIView!
    @IBOutlet var ElectronicNameLabel: UILabel!
    @IBOutlet var alwaysButton: UIButton!
    @IBOutlet var blockButton: UIButton!
    @IBOutlet weak var kwhLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDisplay()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK:- default Setting Function Part
    
    func setDisplay() {
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        
    }
    
    func configure(with model: ElectronicModel) {
        
        ElectronicNameLabel.text = model.name
        perSecond = model.perSecond
        count(with: model)
    }
    
    func count(with model: ElectronicModel) {
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.alwaysButton.currentTitleColor == UIColor.echo_yellow3 {
                self.kwhValue += model.perSecond
                self.kwhLabel.text = "bolt\(self.kwhValue)kwh"
            }
        }
        
        timer.fire()
    }
    
    
    func getEachSum() -> Int {
        return self.kwhValue
    }
    
    //MARK:- Function
    
    func turnOn() {
        alwaysBtnClicked(alwaysButton)
    }
    
    func turnOff() {
        blockBtnClicked(blockButton)
    }
    
    
    //MARK:- IBAction Part
    
    @IBAction func alwaysBtnClicked(_ sender: Any) {
        if (alwaysButton.currentTitleColor == UIColor.systemGray2) {
            alwaysButton.setTitleColor(.echo_yellow3, for: .normal)
            blockButton.setTitleColor(.systemGray2, for: .normal)
        }
        kwhLabel.textColor = .echo_yellow3
    }
    
    
    @IBAction func blockBtnClicked(_ sender: Any) {
        if (blockButton.currentTitleColor == UIColor.systemGray2) {
            alwaysButton.setTitleColor(.systemGray2, for: .normal)
            blockButton.setTitleColor(.echo_green3, for: .normal)
        }
        kwhLabel.textColor = .echo_green3
    }
    

    
    

    
}
