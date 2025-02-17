//
//  AboutViewController.swift
//  App008
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import UIKit
import App008ViewModel
import SnapKit

class AboutViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "About",
                                 textColor: .white,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let text = TextView(placeholder: "")
    private let backButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#0D0D0D")

        self.header.textAlignment = .left
        self.text.textAlignment = .left 

        self.backButton.setImage(UIImage(named: "backButton"), for: .normal)

        self.text.isUserInteractionEnabled = false
        self.text.textAlignment = .left
        self.text.text = """
        Join Our Rewards Program!


        Earn points every time you visit, shop, or take part in exclusive promotions. The more active you are, the more perks you unlock!


        Scan the QR code during your visit to collect bonus points.
         Redeem your points for special deals and discounts.
         Keep track of your balance and loyalty status in the app.


        The more points you collect, the bigger the rewards! Sign up now and start enjoying the benefits!
        """

        self.view.addSubview(header)
        self.view.addSubview(text)
        self.view.addSubview(backButton)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(69)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(41)
        }

        text.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(36)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(58)
            view.bottom.equalToSuperview().inset(196)
        }

        backButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(62)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(81)
        }
    }

}

//MARK: Make buttons actions
extension AboutViewController {
    
    private func makeButtonsAction() {
        self.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }

    @objc func backTapped() {
        guard let navigationController = self.navigationController else { return }
        SettingsRouter.popViewController(in: navigationController)
    }
}

extension AboutViewController: IViewModelableController {
    typealias ViewModel = IAboutViewModel
}


//MARK: Preview
import SwiftUI

struct AboutViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let aboutViewController = AboutViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<AboutViewControllerProvider.ContainerView>) -> AboutViewController {
            return aboutViewController
        }

        func updateUIViewController(_ uiViewController: AboutViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AboutViewControllerProvider.ContainerView>) {
        }
    }
}
