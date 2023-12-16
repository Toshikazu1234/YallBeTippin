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
    
    @IBOutlet weak var tableView: UITableView!
    
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
}
