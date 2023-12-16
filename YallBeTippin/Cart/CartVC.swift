//
//  CartVC.swift
//  YallBeTippin
//
//  Created by R K on 12/15/23.
//

import UIKit

class CartVC: UIViewController {
    static let id = "CartVC"
    @IBOutlet weak var tableView: UITableView!
    
    var orderItems: [MenuItem]
    
    init(coder: NSCoder, orderItems: [MenuItem]) {
        self.orderItems = orderItems
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CartRow.id,
            for: indexPath) as! CartRow
        cell.configure(orderItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        orderItems.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
