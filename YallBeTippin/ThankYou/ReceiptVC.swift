//
//  ReceiptVC.swift
//  YallBeTippin
//
//  Created by R K on 12/15/23.
//

import UIKit

class ReceiptVC: UIViewController {
    static let id = "ThankYouVC"
    
    private let orderItems: [MenuItem]
    private let total: Double
    private let tip: TipPercentage
    
    private lazy var restartButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Restart",
            style: .plain,
            target: self,
            action: #selector(restart))
        return button
    }()
    
    @IBOutlet private weak var tableView: UITableView!
    
    init(coder: NSCoder, orderItems: [MenuItem], tip: TipPercentage) {
        self.orderItems = orderItems
        self.total = orderItems.calculateTotal(plus: tip)
        self.tip = tip
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = restartButton
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func restart() {
        popToRoot()
    }
}

extension ReceiptVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItems.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row < orderItems.count {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ReceiptRow.id,
                for: indexPath) as! ReceiptRow
            cell.configure(orderItems[indexPath.row])
            return cell
        } else if row == orderItems.count {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TipRow.id,
                for: indexPath) as! TipRow
            cell.configure(tip: tip)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TotalCell.id,
                for: indexPath) as! TotalCell
            cell.configure(total)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
