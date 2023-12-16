//
//  Extensions.swift
//  YallBeTippin
//
//  Created by R K on 12/15/23.
//

import UIKit

extension Double {
    func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        let value = NSNumber(value: self)
        return formatter.string(from: value) ?? "N/A"
    }
}

extension [MenuItem] {
    func calculateTotal(plus tip: TipPercentage) -> Double {
        var total: Double = 0
        self.forEach { item in
            let count = Double(item.orderCount)
            total += item.price * count
        }
        return total * tip.rawValue
    }
}

extension UIViewController {
    func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
