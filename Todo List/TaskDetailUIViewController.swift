//
//  TaskDetailUIViewController.swift
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
//  November 13, 2022

import Foundation
import UIKit

enum PageState {case create, update}
class TaskDetailUIViewController: UIViewController{
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var button: CircleUIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    var pageState:PageState = .create
    override func viewDidLoad() {
        datePicker.overrideUserInterfaceStyle = .dark
        updateUI()
    }
    
    @IBAction func onButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    func updateUI(){
        
        if(pageState == .update){
            button.setTitle("Update", for: .normal)
            titleLabel.text = "Task Details"
            deleteButton.isHidden = false
        }
        
    }
}
