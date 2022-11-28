//
//  TodoTableViewCell.swift
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

//delegate use to tie in to main controller to have a centerial function for edit button pressed and when switch is toggled
public protocol TodoItemCellDelegate:NSObjectProtocol {
    func editPressed(_ uibutton:UIButton)
    func onSwitchChanged(_ uiswitch:UISwitch)

}
class TodoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var todoTItle: UILabel!
    weak var delegate: TodoItemCellDelegate?

    @IBOutlet weak var editImage: UIImageView!
    @IBOutlet weak var switchView: UISwitch!
    @IBOutlet weak var centerMargin: NSLayoutConstraint!
    @IBOutlet weak var overdueView: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var checkBoxImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBAction func onEditPressed(_ sender: Any) {
        //trigger delegate function
        delegate?.editPressed(sender as! UIButton)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func onChangeSwitch(_ sender: Any) {
        //trigger delegate function
        delegate?.onSwitchChanged(sender as! UISwitch)

    }
}
