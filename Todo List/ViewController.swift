//
//  ViewController.swift
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

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,TodoItemCellDelegate  {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //get cell object
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoTableViewCell
        cell.delegate = self
        cell.selectionStyle = .none

        return cell
    }
    
    // row height
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    func editPressed(_ uibutton: UIButton) {
        performSegue(withIdentifier: "editTodo", sender: PageState.update)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(sender is PageState){
            let taskDetailsViewController = segue.destination as! TaskDetailUIViewController
            taskDetailsViewController.pageState = sender as! PageState
        }
    }
    


    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

