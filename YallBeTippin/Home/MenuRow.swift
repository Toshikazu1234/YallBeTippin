//
//  MenuRow.swift
//  YallBeTippin
//
//  Created by R K on 12/15/23.
//

import UIKit

class MenuRow: UITableViewCell {
    static let id = "MenuRow"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.layer.cornerRadius = 10
        plusButton.layer.cornerRadius = plusButton.frame.height / 2
        minusButton.layer.cornerRadius = minusButton.frame.height / 2
    }
    
    func configure(menuItem: MenuItem) {
        nameLabel.text = menuItem.name
        priceLabel.text = menuItem.price.toCurrency()
        img.image = UIImage(named: menuItem.img)
        verticalStack.isHidden = menuItem.orderCount > 0 ? false : true
    }
}
