//
//  FormOptionsView.swift
//  SendMoney
//
//  Created by Sharon Varghese on 18/01/2025.
//

import UIKit

protocol FormOptionsViewDelegate {
    func didSelectShowOptions()
}
struct FormOptionsViewModel {
    var title: String?
    var selectedTitle: String?
    var type: FormOptionsType?
}
enum FormOptionsType {
    case service
    case provider
    case requiredField
}

class FormOptionsView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var titleLabel: BaseLabel!
    @IBOutlet weak var formFieldView: UIView!
    @IBOutlet weak var selectedTitleLabel: BaseLabel!
    
    var delegate: FormOptionsViewDelegate?
    var data: FormOptionsViewModel? {
        didSet {
            loadData()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("FormOptionsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("FormOptionsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        
    }
    func setupUI() {
        titleLabel.style = .primaryMedium16
        formFieldView.layer.cornerRadius = 5
        formFieldView.backgroundColor = CustomColors.formFieldBackgroundColor
    }
    func loadData() {
        titleLabel.text = data?.title
        selectedTitleLabel.text = data?.selectedTitle
    }
    
    @IBAction func optionsButtonAction(_ sender: Any) {
        print("open picker")
    }
}
