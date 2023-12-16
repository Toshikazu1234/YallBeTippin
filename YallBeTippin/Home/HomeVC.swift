//
//  ViewController.swift
//  YallBeTippin
//
//  Created by R K on 12/15/23.
//

import UIKit

class HomeVC: UIViewController {
    var menuItems: [MenuItem] = []
    var orderItems: [MenuItem] = []
    
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
        if orderItems.isEmpty {
            displayAlert()
        } else {
            navigateToCart()
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
                orderItems: orderItems)
            return vc
        }
        pushVC(vc)
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
        cell.configure(menuItem: menuItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = menuItems[indexPath.row]
        if !orderItems.contains(where: { menuItem in
            item.name == menuItem.name
        }) {
            orderItems.append(item)
        } else if var orderItem = orderItems.first(where: { menuItem in
            item.name == menuItem.name
        }) {
            orderItem.orderCount += 1
        }
    }
}
