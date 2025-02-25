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
//  November 27, 2022

import UIKit
import NotificationBannerSwift
import RealmSwift

//Delegate method to use to trigger when the task details view is dismissed so this view know when to trigger a tableview update
public protocol DimissedDelegate:NSObjectProtocol {
    func onDismissed(_ sender:Any?)
}

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,TodoItemCellDelegate, DimissedDelegate {

    @IBOutlet weak var emptyMessageDesciption: UILabel!
    @IBOutlet weak var emptyMessageTitle: UILabel!
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var greetingsLabel: UILabel!
    
    //list of tasks
    var listOfTask:Results<TodoTask>? = nil
    //varible use to identify which cell row number is being interact with for edit or toggle a task as done or undone
    var selectedIndex = -1
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if list nil then make table show 0 rows
        return listOfTask?.count ?? 0
    }
    
    //delegate function to know when modal is dismissed
    func onDismissed(_ sender: Any?) {
        updateUI()
    }
    
    //update listOfTask from the persistent storage and reload table
    func updateUI(){
        listOfTask = TodoTask.getAllTodos()
        //hide empty message when table have data in it
        if(listOfTask != nil  && listOfTask!.count != 0){
            emptyMessageTitle.isHidden = true
            emptyMessageDesciption.isHidden = true
        }
        //show empty message when no data is in list
        else{
            emptyMessageTitle.isHidden = false
            emptyMessageDesciption.isHidden = false
        }
        tableView.reloadData()
    
    }
    
    //display header greeting, current day and current date
    func updateHeader(){
        
        let currentDate = Date.now
        let dateformat = DateFormatter()
        
        dateformat.dateFormat = "MMM dd, YYYY"
        //display today's date
        currentDateLabel.text = dateformat.string(from: currentDate)
        dateformat.dateFormat = "EEEE"
        //display day of the week
        currentDayLabel.text = dateformat.string(from: currentDate)

        let calendar = Calendar.current
        //get hour in the day
        let hours = calendar.component(.hour, from: currentDate)
        
        //display greeting based on hour of the day
        if (hours < 12) {
            greetingsLabel.text = "Good Morning"
        } else if (hours < 18) {
            greetingsLabel.text = "Good Afternoon"
        } else {
            greetingsLabel.text  = "Good Evening"
        }

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let todoTask = listOfTask![indexPath.row]
        
        //get cell object
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TodoTableViewCell
        
        //set delegate for on edit button press and onChange for switch
        cell.delegate = self
        cell.selectionStyle = .none
        
        //save row index in the tag so delegate can be referenced cell row index
        cell.editButton.tag = indexPath.row
        cell.switchView.tag = indexPath.row
        
        //set cell data
        cell.todoTItle.attributedText = NSMutableAttributedString(string: todoTask.name)
        cell.switchView.isOn = todoTask.isCompleted
        cell.overdueView.isHidden = true
        cell.dateLabel.isHidden = true
        
        //check title when there is no date in cell
        cell.centerMargin.constant = 0
        
        //allow image to become tintable
        cell.editImage.image = cell.editImage.image!.withRenderingMode(.alwaysTemplate)
        //set orange color on image
        cell.editImage.tintColor = UIColor(red: 238.0/255, green: 130/255, blue: 91.0/255,alpha: 1.0)
        
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(attributedString: cell.todoTItle.attributedText!)
        //if task complete gray out and strickthrought text and change edit icon to gray
        if(todoTask.isCompleted){
           
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.gray.withAlphaComponent(0.8), range: NSRange(location: 0, length: attributeString.length))
            cell.editImage.tintColor = UIColor.gray
        }
        else{
            //remove strikethroughStyle attribute if not completed
            attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSRange(location: 0, length: attributeString.length))
        }
        //set attributed text
        cell.todoTItle.attributedText = attributeString

        if(todoTask.dueDate != nil && todoTask.hasDueDate ){
            
            //find next day aka tomorrow's date
            let nextDayDate = Calendar.current.date(byAdding:  DateComponents(day:-1), to: Date.now)
            
            //if task is over due and task is not completed then show overdue view
            if(todoTask.dueDate! < nextDayDate! && !todoTask.isCompleted){
                cell.overdueView.isHidden = false
                cell.centerMargin.constant = -8
            }
            else if(todoTask.hasDueDate){
                
                //display date label
                cell.dateLabel.isHidden = false

                let dateformat = DateFormatter()
                dateformat.dateFormat = "MMMM dd, YYYY"
                cell.dateLabel.text = dateformat.string(from: todoTask.dueDate!)
                //offset title to fix date to make everything look vertically centered
                cell.centerMargin.constant = -8
                


            }
        }
        

        return cell
    }
    
    // row height
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    func editPressed(_ uibutton: UIButton) {
        //set selected index
        selectedIndex = uibutton.tag
        //trigger segue to task action details page
        performSegue(withIdentifier: "editTodo", sender: PageState.update)
    }
    
    func onSwitchChanged(_ uiswitch: UISwitch) {
        
        //set selected index
        selectedIndex = uiswitch.tag
        //update isComplete boolean on todoTaskItem
        let realm = try! Realm()
        try! realm.write {
            listOfTask![selectedIndex].isCompleted = uiswitch.isOn
        }
        //update list from persistent storage and reload table data
        listOfTask = TodoTask.getAllTodos()
        tableView.reloadData()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let taskDetailsViewController = segue.destination as! TaskDetailUIViewController
        //set self as delegate so the modal can trigger the isDismissed function
        taskDetailsViewController.delegate = self
        
        if(sender is PageState){
            //pass todo task to desination view controller and set page state
            taskDetailsViewController.todoTask = listOfTask![selectedIndex]
            taskDetailsViewController.pageState = sender as! PageState
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //update header
        updateHeader()
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        updateUI()
        super.viewDidLoad()
    }
    
}

