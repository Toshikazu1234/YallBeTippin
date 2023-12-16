//
//  ThankYouVC.swift
//  YallBeTippin
//
//  Created by R K on 12/15/23.
//

import UIKit

class ThankYouVC: UIViewController {
    static let id = "ThankYouVC"
    
    let orderItems: [MenuItem]
    let total: Double
    
    lazy var restartButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Restart",
            style: .plain,
            target: self,
            action: #selector(restart))
        return button
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    init(coder: NSCoder, orderItems: [MenuItem], tip: TipPercentage) {
        self.orderItems = orderItems
        self.total = orderItems.calculateTotal(plus: tip)
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func restart() {
        popToRoot()
    }
}

extension ThankYouVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItems.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < orderItems.count {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ReceiptRow.id,
                for: indexPath) as! ReceiptRow
            cell.configure(orderItems[indexPath.row])
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
