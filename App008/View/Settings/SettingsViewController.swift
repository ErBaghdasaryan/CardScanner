//
//  SettingsViewController.swift
//  App008
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import UIKit
import App008ViewModel
import SnapKit

class SettingsViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Settings",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let about = PrivacyAndTermsButton()
    private let terms = PrivacyAndTermsButton()
    private let privacy = PrivacyAndTermsButton()
    private let appImage = UIImageView(image: UIImage(named: "header"))
    private let back = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()
        self.view.backgroundColor = UIColor(hex: "#0D0D0D")

        self.header.textAlignment = .left

        self.about.setTitle("About our project", for: .normal)
        self.terms.setTitle("Terms", for: .normal)
        self.privacy.setTitle("Privacy Policy", for: .normal)

        self.back.setImage(UIImage(named: "backButton"), for: .normal)

        self.view.addSubview(header)
        self.view.addSubview(about)
        self.view.addSubview(privacy)
        self.view.addSubview(terms)
        self.view.addSubview(appImage)
        self.view.addSubview(back)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(74)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(34)
        }

        about.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(32)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(24)
        }

        privacy.snp.makeConstraints { view in
            view.top.equalTo(about.snp.bottom).offset(28)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(24)
        }

        terms.snp.makeConstraints { view in
            view.top.equalTo(privacy.snp.bottom).offset(28)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(24)
        }

        appImage.snp.makeConstraints { view in
            view.top.equalTo(terms.snp.bottom).offset(28)
            view.leading.equalToSuperview().offset(16)
            view.width.equalTo(198)
            view.height.equalTo(45)
        }

        back.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(62)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(81)
        }
    }
}


extension SettingsViewController: IViewModelableController {
    typealias ViewModel = ISettingsViewModel
}

//MARK: Make buttons actions
extension SettingsViewController {
    
    private func makeButtonsAction() {
        self.about.addTarget(self, action: #selector(aboutTapped), for: .touchUpInside)
        self.terms.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
        self.privacy.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
        self.back.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }

    @objc func aboutTapped() {
        guard let navigationController = self.navigationController else { return }

        SettingsRouter.showAboutViewController(in: navigationController)
    }

    @objc func termsTapped() {
        guard let navigationController = self.navigationController else { return }

        SettingsRouter.showTermsViewController(in: navigationController)
    }

    @objc func privacyTapped() {
        guard let navigationController = self.navigationController else { return }

        SettingsRouter.showPrivacyViewController(in: navigationController)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        HomeRouter.popViewController(in: navigationController) {
            navigationController.navigationBar.isHidden = false
        }
    }

}

//MARK: Preview
import SwiftUI

struct SettingsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let settingsViewController = SettingsViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) -> SettingsViewController {
            return settingsViewController
        }

        func updateUIViewController(_ uiViewController: SettingsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) {
        }
    }
}
