//
//  CartVC.swift
//  YallBeTippin
//
//  Created by R K on 12/15/23.
//

import UIKit

protocol CartVCDelegate: AnyObject {
    func updateItems(using orderItems: [MenuItem])
}

class CartVC: UIViewController {
    static let id = "CartVC"
    @IBOutlet weak var tableView: UITableView!
    
    var orderItems: [MenuItem]
    let delegate: CartVCDelegate
    
    init(coder: NSCoder, orderItems: [MenuItem], delegate: CartVCDelegate) {
        self.orderItems = orderItems
        self.delegate = delegate
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart"
        setupTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate.updateItems(using: orderItems)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: CartRow.id, bundle: nil),
            forCellReuseIdentifier: CartRow.id)
    }
}

extension CartVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CartRow.id,
            for: indexPath) as! CartRow
        cell.configure(orderItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        orderItems.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
