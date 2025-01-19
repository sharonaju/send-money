//
//  TransferDetailViewController.swift
//  SendMoney
//
//  Created by Sharon Varghese on 19/01/2025.
//

import UIKit

class TransferDetailViewController: BaseViewController {
    @IBOutlet weak var textView: UITextView!
    var viewModel = TransferDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navBarTitle = viewModel.formValue.selectedService?.label?.en ?? ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    func loadData() {
        textView.text = viewModel.convertToJSON()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
