//
//  FormTextFieldTableViewCell.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit
struct FormTextFieldTableViewCellModel {
    var formTextFieldModel: FormTextFieldViewModel?
}
class FormTextFieldTableViewCell: UITableViewCell {

    static let reuseIdentifier = "FormTextFieldTableViewCell"
    
    @IBOutlet weak var formTextFieldView: FormTextFieldView!
    var data: FormTextFieldTableViewCellModel? {
        didSet {
            loadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadData() {
        formTextFieldView.data = data?.formTextFieldModel
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
