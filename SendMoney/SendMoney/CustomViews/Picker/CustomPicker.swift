//
//  CustomPicker.swift
//  SendMoney
//
//  Created by Sharon Varghese on 19/01/2025.
//

import UIKit

// Protocol to return the selected object
protocol CustomPickerDelegate: AnyObject {
    func didSelectItem(_ selectedItem: Any)
}

// Enum for Picker Types
enum PickerCategory {
    case services
    case providers
    case options
}

// Custom Picker View
class CustomPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // MARK: - @IBOutlet
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    // MARK: - Properties
    private let toolbar = UIToolbar()
    
    private var data: [Any] = []
    private var pickerType: PickerCategory?
    weak var delegate: CustomPickerDelegate?
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("CustomPickerView", owner: self, options: nil)
        addSubview(contentView)
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("CustomPickerView", owner: self, options: nil)
        addSubview(contentView)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupUI()
    }
    
    private func setupUI() {

    }
    
    // MARK: - Public Methods
    func configure(with data: [Any], type: PickerCategory, delegate: CustomPickerDelegate) {
        self.data = data
        self.pickerType = type
        self.delegate = delegate
        pickerView.reloadAllComponents()
    }
    
    // MARK: - Actions
    @objc private func cancelTapped() {
        hide()
    }
    
    @objc private func doneTapped() {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let selectedItem = data[selectedRow]
        delegate?.didSelectItem(selectedItem)
        hide()
    }
    func show(in view: UIView) {
        self.frame = view.bounds
        view.addSubview(self)
        self.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }

    func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = data[row]
        if let data = item as? Service {
            return data.label?.en
        }
        if let data = item as? Provider {
            return data.name
        }
        return nil
    }
    
    // MARK: - UIPickerViewDelegate
    @IBAction func cancelButtonAction(_ sender: Any) {
        removeFromSuperview()
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let selectedItem = data[selectedRow]
        delegate?.didSelectItem(selectedItem)
        removeFromSuperview()
    }
    
}

