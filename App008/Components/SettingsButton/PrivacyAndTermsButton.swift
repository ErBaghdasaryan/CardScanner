//
//  PrivacyAndTermsButton.swift
//  App008
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import UIKit
import SnapKit

class PrivacyAndTermsButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.backgroundColor = UIColor(hex: "#0D0D0D")
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "SFProText-Bold", size: 17)
        self.contentHorizontalAlignment = .left
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true

        let arrowImage = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrowImage.tintColor = .white
        self.addSubview(arrowImage)

        arrowImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(18.75)
            make.centerY.equalToSuperview()
            make.width.equalTo(9)
            make.height.equalTo(16.5)
        }
    }
}
