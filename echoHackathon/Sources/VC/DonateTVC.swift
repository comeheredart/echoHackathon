//
//  DonateTVC.swift
//  echoHackathon
//
//  Created by JEN Lee on 2021/05/27.
//

import UIKit

class DonateTVC: UITableViewCell {

    @IBOutlet var view: UIView!
    @IBOutlet var title: UILabel!
    @IBOutlet var subtitle: UILabel!
    //@IBOutlet var imageview: UIImageView!
    
    static var Nib = UINib(nibName: "DonateTVC", bundle: nil)
    static let identifier = "DonateTVC"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDisplay()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    

    func setDisplay() {
        self.view.layer.cornerRadius = 20
        self.view.layer.masksToBounds = true

    }
    
    
    
}
