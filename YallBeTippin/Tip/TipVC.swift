//
//  TipVC.swift
//  YallBeTippin
//
//  Created by R K on 12/15/23.
//

import UIKit

class TipVC: UIViewController {
    static let id = "TipVC"
    
    let orderItems: [MenuItem]
    
    init(coder: NSCoder, orderItems: [MenuItem]) {
        self.orderItems = orderItems
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Just gonna asking a question"
        
    }
}
