//
//  SendMoneyListTableViewCell.swift
//  SendMoney
//
//  Created by Sharon Varghese on 19/01/2025.
//

import UIKit

class SendMoneyListTableViewCell: UITableViewCell {
    static let reuseIdentifier  = "SendMoneyListTableViewCell"
    
    // MARK: - @IBOutlet
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var serviceNameLabel: BaseLabel!
    @IBOutlet weak var providerNameLabel: BaseLabel!
    
    // MARK: - Properties
    var data: FormValue? {
        didSet {
            loadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupUI() {
        bgView.backgroundColor = CustomColors.formFieldBackgroundColor
        bgView.layer.cornerRadius = 8
        serviceNameLabel.style = .primaryMedium16
        providerNameLabel.style = .primaryMedium16
    }
    func loadData() {
        serviceNameLabel.text = data?.selectedService?.label?.en
        providerNameLabel.text = data?.selectedProvider?.name
        
    }
}
