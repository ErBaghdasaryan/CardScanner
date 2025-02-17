//
//  CustomTextView.swift
//  App008
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import UIKit

public class TextView: UITextView, UITextViewDelegate {

    private var placeholderText: String = ""
    public var placeholderLabel: UILabel = UILabel()

    public convenience init(placeholder: String) {
        self.init()
        self.placeholderText = placeholder

        configure()
    }

    private func configure() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 30
        self.layer.maskedCorners = [
            .layerMaxXMaxYCorner,
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        self.backgroundColor = UIColor(hex: "#0D0D0D")

        placeholderLabel.text = placeholderText
        placeholderLabel.font = UIFont(name: "SFProText-Semibold", size: 27)
        placeholderLabel.sizeToFit()
        placeholderLabel.textAlignment = .left
        placeholderLabel.numberOfLines = 2
        addSubview(placeholderLabel)
        placeholderLabel.isHidden = !text.isEmpty

        self.placeholderLabel.attributedText = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.3)])

        self.textColor = .white
        self.textAlignment = .left
        self.font = UIFont(name: "SFProText-Semibold", size: 15)

        self.delegate = self
    }

    // MARK: UITextViewDelegate
    public func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
