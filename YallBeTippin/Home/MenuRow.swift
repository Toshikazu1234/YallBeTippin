//
//  MenuRow.swift
//  YallBeTippin
//
//  Created by R K on 12/15/23.
//

import UIKit

protocol MenuRowDelegate: AnyObject {
    func didAdd(_ orderItem: MenuItem, _ indexPath: IndexPath)
    func didMinus(_ orderItem: MenuItem, _ indexPath: IndexPath)
}

class MenuRow: UITableViewCell {
    static let id = "MenuRow"
    var menuItem: MenuItem?
    var indexPath: IndexPath?
    weak var delegate: MenuRowDelegate?
    
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
        img.layer.cornerRadius = 20
        plusButton.layer.cornerRadius = plusButton.frame.height / 2
        minusButton.layer.cornerRadius = minusButton.frame.height / 2
    }
    
    func configure(_ menuItem: MenuItem, _ indexPath: IndexPath) {
        self.menuItem = menuItem
        self.indexPath = indexPath
        nameLabel.text = menuItem.name
        priceLabel.text = menuItem.price.toCurrency()
        img.image = UIImage(named: menuItem.img)
        if menuItem.orderCount > 0 {
            verticalStack.isHidden = false
            orderNumberLabel.text = "\(menuItem.orderCount)"
        } else {
            verticalStack.isHidden = true
        }
    }
    
    @IBAction func didTapPlusButton() {
        guard let menuItem, let indexPath else { return }
        delegate?.didAdd(menuItem, indexPath)
    }
    
    @IBAction func didTapMinusButton() {
        guard let menuItem, let indexPath, menuItem.orderCount >= 0 else { return }
        delegate?.didMinus(menuItem, indexPath)
    }
}
