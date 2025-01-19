//
//  SendMoneyListViewController.swift
//  SendMoney
//
//  Created by Sharon Varghese on 19/01/2025.
//

import UIKit
import Combine

class SendMoneyListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - @IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let viewModel = SendMoneyListViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UIViewControllerLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navBarTitle = LocalizedString.transferList.localized
        registerTableView()
        loaData()
    }
    
    func registerTableView() {
        tableView.register(UINib(nibName: "SendMoneyListTableViewCell", bundle: nil), forCellReuseIdentifier: SendMoneyListTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func loaData() {
        viewModel.fetchSavedData()
    }
    private func bindViewModel() {
        viewModel.$savedFormValues
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.savedFormValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SendMoneyListTableViewCell.reuseIdentifier, for: indexPath) as! SendMoneyListTableViewCell
        let formValue = viewModel.savedFormValues[indexPath.row]
        cell.data = formValue
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let formValue = viewModel.savedFormValues[indexPath.row]
        if let nextVC = storyboard?.instantiateViewController(withIdentifier: "TransferDetailViewController") as? TransferDetailViewController {
            nextVC.viewModel.formValue = formValue
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }

}
