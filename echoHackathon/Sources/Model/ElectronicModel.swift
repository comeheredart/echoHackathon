//
//  ElectronicModel.swift
//  echoHackathon
//
//  Created by JEN Lee on 2021/05/21.
//

import Foundation

struct ElectronicModel {
    var name: String
    var perSecond: Int
    var curkwh: Int
    var isOn: Bool
    
    func wow(){
        print(self.isOn)
    }
    
    
}
