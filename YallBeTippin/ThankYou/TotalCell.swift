//
//  TotalCell.swift
//  YallBeTippin
//
//  Created by R K on 12/16/23.
//

import UIKit

class TotalCell: UITableViewCell {
    static let id = "TotalCell"
    
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ total: Double) {
        totalLabel.text = total.toCurrency()
    }
}
