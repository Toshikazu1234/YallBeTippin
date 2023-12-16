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
    enum TipPercentage: Double {
        case small = 0.18
        case medium = 0.2
        case large = 0.22
        case none = 0
    }
    var tipPercentage: TipPercentage = .small
    
    lazy var confirmButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "Confirm",
            style: .plain,
            target: self,
            action: #selector(didTapConfirmButton))
        return button
    }()
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var smallTipButton: UIButton!
    @IBOutlet weak var mediumTipButton: UIButton!
    @IBOutlet weak var largeTipButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    lazy var tipButtons: [UIButton] = [
        smallTipButton,
        mediumTipButton,
        largeTipButton,
        skipButton
    ]
    
    init(coder: NSCoder, orderItems: [MenuItem]) {
        self.orderItems = orderItems
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Just gonna ask a question"
        navigationItem.rightBarButtonItem = confirmButton
        stackView.subviews.forEach { view in
            view.layer.cornerRadius = 20
        }
        skipButton.layer.cornerRadius = 12
        smallTipButton.isSelected = true
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let orientation = UIDevice.current.orientation
        if orientation.isLandscape {
            stackView.axis = .horizontal
        } else if orientation.isPortrait {
            stackView.axis = .vertical
        }
    }
    
    @objc func didTapConfirmButton() {
        let total = calculateTotal()
        let sb = UIStoryboard(
            name: ThankYouVC.id,
            bundle: nil)
        let vc = sb.instantiateViewController(identifier: ThankYouVC.id) { [unowned self] coder in
            let thankYouVC = ThankYouVC(
                coder: coder,
                orderItems: orderItems)
            return thankYouVC
        }
        pushVC(vc)
    }
    
    @IBAction func didTapSmallTipButton() {
        deselectTipButtons()
        smallTipButton.isSelected = true
        tipPercentage = .small
    }
    
    @IBAction func didTapMediumTipButton() {
        deselectTipButtons()
        mediumTipButton.isSelected = true
        tipPercentage = .medium
    }
    
    @IBAction func didTapLargeTipButton() {
        deselectTipButtons()
        largeTipButton.isSelected = true
        tipPercentage = .large
    }
    
    @IBAction func didTapSkipButton() {
        deselectTipButtons()
        skipButton.isSelected = true
        tipPercentage = .none
    }
    
    func deselectTipButtons() {
        tipButtons.forEach { button in
            button.isSelected = false
        }
    }
    
    func calculateTotal() -> Double {
        var total: Double = 0
        orderItems.forEach { item in
            let count = Double(item.orderCount)
            total += item.price * count
        }
        return total * tipPercentage.rawValue
    }
}
