//
//  ViewController.swift
//  YallBeTippin
//
//  Created by R K on 12/15/23.
//

import UIKit

class HomeVC: UIViewController {
    var menuItems: [MenuItem] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMenuItems()
        setupTableView()
    }
    
    func fetchMenuItems() {
        menuItems = Api.shared.fetchMenu()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func didTapViewCart(_ sender: UIBarButtonItem) {
        if menuItems.contains(where: {$0.orderCount > 0}) {
            navigateToCart()
        } else {
            displayAlert()
        }
    }
    
    func displayAlert() {
        let alert = UIAlertController(
            title: "Alert",
            message: "Your cart is empty!",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "Okay",
            style: .cancel))
        present(alert, animated: true)
    }
    
    func navigateToCart() {
        let sb = UIStoryboard(
            name: CartVC.id,
            bundle: nil)
        let vc = sb.instantiateViewController(identifier: CartVC.id) { [unowned self] coder in
            let vc = CartVC(
                coder: coder,
                orderItems: getOrderItems(),
                delegate: self)
            return vc
        }
        pushVC(vc)
    }
    
    func getOrderItems() -> [MenuItem] {
        var orderItems: [MenuItem] = []
        menuItems.forEach { item in
            if item.orderCount > 0 {
                orderItems.append(item)
            }
        }
        return orderItems
    }
}

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MenuRow.id,
            for: indexPath) as! MenuRow
        cell.configure(menuItems[indexPath.row], indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        menuItems[indexPath.row].orderCount += 1
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension HomeVC: MenuRowDelegate {
    func didAdd(_ orderItem: MenuItem, _ indexPath: IndexPath) {
        menuItems[indexPath.row].orderCount += 1
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func didMinus(_ orderItem: MenuItem, _ indexPath: IndexPath) {
        menuItems[indexPath.row].orderCount -= 1
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension HomeVC: CartVCDelegate {
    func updateItems(using orderItems: [MenuItem]) {
        for var item in menuItems {
            if let orderItem = orderItems.first(where: {$0.name == item.name}) {
                item.orderCount = orderItem.orderCount
            } else {
                item.orderCount = 0
            }
        }
    }
}
