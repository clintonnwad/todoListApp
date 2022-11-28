//
//  CircleUIButton.swift
//  Todo List
//
//  Created by Jovi on 13/11/2022.
//
//  GROUP NUMBER: 15
//  NAMES:
//  Clinton Nwadiukor  - 301291242
//  Jovi Chen-Mcintyre - 301125059
//
//  DESCRIPTION:
//  Simple ToDo application that performs basic Todo functions
//  Users can create a task, modify and update existing tasks
//  The app is available in portrait and landscape
//
//  REVISION HISTORY:
//  https://github.com/clintonnwad/todoListApp
//
//  DATE LAST MODIFIED:
//  November 27, 2022

import UIKit
//IB designable add ability to make button prefect circle no matter the height
@IBDesignable
class CircleUIButton: UIButton {

    @IBInspectable var enableDesign: Bool = false {
        didSet {
            if(enableDesign){
                layer.cornerRadius = layer.bounds.height/2
                layer.masksToBounds = layer.cornerRadius > 0
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if(enableDesign){
            layer.cornerRadius = layer.bounds.height/2
            layer.masksToBounds = layer.cornerRadius > 0
        }
    }


}
