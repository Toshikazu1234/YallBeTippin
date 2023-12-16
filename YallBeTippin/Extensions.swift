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

extension UIViewController {
    func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}
