//
//  TotalCell.swift
//  YallBeTippin
//
//  Created by R K on 12/16/23.
//

import UIKit

class TotalCell: UITableViewCell {
    static let id = "TotalCell"
    
    @IBOutlet private weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ total: Double) {
        totalLabel.text = total.toCurrency()
    }
}
