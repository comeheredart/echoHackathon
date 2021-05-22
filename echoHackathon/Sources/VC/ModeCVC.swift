//
//  ModeCVC.swift
//  echoHackathon
//
//  Created by JEN Lee on 2021/05/21.
//

import UIKit

class ModeCVC: UICollectionViewCell {

    static let identifier = "ModeCVC"
    static var Nib = UINib(nibName: "ModeCVC", bundle: nil)
    
    @IBOutlet var view: UIView!
    @IBOutlet var modeLabel: UILabel!
    @IBOutlet var modeDescriptionLabel: UILabel!
    @IBOutlet var modeimageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDisplay()
        
    }
    
    func configure(with model: ModeModel) {
        modeLabel.text = model.modeName
        modeDescriptionLabel.text = model.modeDescription
    }
    
    func setDisplay() {
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
    }
    

}
