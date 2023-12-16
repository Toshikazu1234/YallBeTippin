//
//  TipRow.swift
//  YallBeTippin
//
//  Created by R K on 12/16/23.
//

import UIKit

class TipRow: UITableViewCell {
    static let id = "TipRow"

    @IBOutlet weak var tipLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(tip: TipPercentage) {
        tipLabel.text = tip.toString()
    }
}
