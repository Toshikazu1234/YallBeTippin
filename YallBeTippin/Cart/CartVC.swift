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
    
    private lazy var confirmButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Confirm",
            style: .plain,
            target: self,
            action: #selector(didTapConfirmButton))
        return button
    }()
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var orderItems: [MenuItem]
    weak var delegate: CartVCDelegate?
    
    init(coder: NSCoder, orderItems: [MenuItem]) {
        self.orderItems = orderItems
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart"
        navigationItem.rightBarButtonItem = confirmButton
        setupTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.updateItems(using: orderItems)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: CartRow.id, bundle: nil),
            forCellReuseIdentifier: CartRow.id)
    }
    
    @objc private func didTapConfirmButton() {
        let sb = UIStoryboard(
            name: TipVC.id,
            bundle: nil)
        let vc = sb.instantiateViewController(identifier: TipVC.id) { [unowned self] coder in
            let tipVC = TipVC(
                coder: coder,
                orderItems: orderItems)
            return tipVC
        }
        pushVC(vc)
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
        cell.configure(orderItems[indexPath.row], indexPath)
        cell.delegate = self
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

extension CartVC: CartRowDelegate {
    func didAdd(_ orderItem: MenuItem, _ indexPath: IndexPath) {
        orderItems[indexPath.row].orderCount += 1
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func didMinus(_ orderItem: MenuItem, _ indexPath: IndexPath) {
        orderItems[indexPath.row].orderCount -= 1
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
