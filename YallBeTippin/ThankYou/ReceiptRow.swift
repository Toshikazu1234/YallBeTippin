//
//  ReceiptRow.swift
//  YallBeTippin
//
//  Created by R K on 12/16/23.
//

import UIKit

class ReceiptRow: UITableViewCell {
    static let id = "ReceiptRow"
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ orderItem: MenuItem) {
        nameLabel.text = orderItem.name
        countLabel.text = "x\(orderItem.orderCount)"
        let total = calculateTotal(orderItem)
        totalLabel.text = total.toCurrency()
    }
    
    private func calculateTotal(_ orderItem: MenuItem) -> Double {
        let count = Double(orderItem.orderCount)
        return orderItem.price * count
    }
}
