//
//  UILabel+Extensions.swift
//  JustNews
//

import UIKit

extension UILabel {
    convenience init(text: String? = nil,
                     font: UIFont = .systemFont(ofSize: 15),
                     color: UIColor? = nil,
                     numberOfLines: Int = 1,
                     alignment: NSTextAlignment = .left) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        self.font = font
        textColor = color
        self.text = text
        self.numberOfLines = numberOfLines
        textAlignment = alignment
    }
}
