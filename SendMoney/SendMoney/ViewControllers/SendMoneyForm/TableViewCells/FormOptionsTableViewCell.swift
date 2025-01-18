//
//  FormOptionsTableViewCell.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit
struct FormOptionsTableViewCellModel {
    var formOptionModel: FormOptionsViewModel?
}

class FormOptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var formOptionsView: FormOptionsView!
    static let reuseIdentifier  = "FormOptionsTableViewCell"
    
    var data: FormOptionsTableViewCellModel? {
        didSet {
            loadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func loadData() {
        formOptionsView.data = data?.formOptionModel
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
