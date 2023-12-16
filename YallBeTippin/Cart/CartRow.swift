//
//  CartRow.swift
//  YallBeTippin
//
//  Created by R K on 12/15/23.
//

import UIKit

protocol CartRowDelegate: AnyObject {
    func didAdd(_ orderItem: MenuItem, _ indexPath: IndexPath)
    func didMinus(_ orderItem: MenuItem, _ indexPath: IndexPath)
}

class CartRow: UITableViewCell {
    static let id = "CartRow"
    var orderItem: MenuItem?
    var indexPath: IndexPath?
    weak var delegate: CartRowDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    
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
        img.layer.cornerRadius = 20
        plusButton.layer.cornerRadius = plusButton.frame.height / 2
        minusButton.layer.cornerRadius = minusButton.frame.height / 2
    }
    
    func configure(_ orderItem: MenuItem, _ indexPath: IndexPath) {
        self.orderItem = orderItem
        self.indexPath = indexPath
        nameLabel.text = orderItem.name
        priceLabel.text = orderItem.price.toCurrency()
        img.image = UIImage(named: orderItem.img)
        orderNumberLabel.text = "\(orderItem.orderCount)"
    }
    
    @IBAction func didTapPlusButton() {
        guard let orderItem, let indexPath else { return }
        delegate?.didAdd(orderItem, indexPath)
    }
    
    @IBAction func didTapMinusButton() {
        guard let orderItem, let indexPath, orderItem.orderCount >= 0 else { return }
        delegate?.didMinus(orderItem, indexPath)
    }
}
