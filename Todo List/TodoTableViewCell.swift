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
//  November 13, 2022

import UIKit
public protocol TodoItemCellDelegate:NSObjectProtocol {
    func editPressed(_ uibutton:UIButton)
}
class TodoTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var todoTItle: UILabel!
    weak var delegate: TodoItemCellDelegate?

    @IBOutlet weak var checkBoxImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBAction func onEditPressed(_ sender: Any) {
        delegate?.editPressed(sender as! UIButton)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
