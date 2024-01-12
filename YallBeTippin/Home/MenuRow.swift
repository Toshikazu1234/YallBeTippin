//
//  MenuRow.swift
//  YallBeTippin
//
//  Created by R K on 12/15/23.
//

import UIKit

protocol MenuRowDelegate: AnyObject {
    func didAdd(_ indexPath: IndexPath)
    func didMinus(_ indexPath: IndexPath)
}

class MenuRow: UITableViewCell {
    static let id = "MenuRow"
    private var indexPath: IndexPath?
    weak var delegate: MenuRowDelegate?
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var img: UIImageView!
    
    @IBOutlet private weak var verticalStack: UIStackView!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var orderNumberLabel: UILabel!
    @IBOutlet private weak var minusButton: UIButton!
    
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
    
    @IBAction private func didTapPlusButton() {
        guard let indexPath else { return }
        delegate?.didAdd(indexPath)
    }
    
    @IBAction private func didTapMinusButton() {
        guard let indexPath else { return }
        delegate?.didMinus(indexPath)
    }
}
