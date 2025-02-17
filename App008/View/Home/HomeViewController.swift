//
//  HomeViewController.swift
//  App008
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import UIKit
import App008Model
import App008ViewModel
import SnapKit

class HomeViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let headerImage = UIImageView(image: UIImage(named: "home1"))
    private let balance = UILabel(text: "Balance",
                                  textColor: .white,
                                  font: UIFont(name: "SFProText-Bold", size: 20))
    private let count = UILabel(text: "1500A",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Bold", size: 20))
    private let showQROrClose = UIButton(type: .system)

    private var buttonState: ButtonState = .showQR

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#0D0D0D")

        self.balance.textAlignment = .left
        self.count.textAlignment = .right

        self.showQROrClose.setImage(UIImage(named: "showQRButton"), for: .normal)
        setHeaderAttributedText()

        self.view.addSubview(headerImage)
        self.view.addSubview(balance)
        self.view.addSubview(count)
        self.view.addSubview(showQROrClose)
        setupConstraints()
        setupNavigationItems()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {

        headerImage.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(130)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview().inset(202)
        }

        balance.snp.makeConstraints { view in
            view.top.equalTo(headerImage.snp.bottom)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(60)
            view.height.equalTo(48)
        }

        count.snp.makeConstraints { view in
            view.top.equalTo(headerImage.snp.bottom)
            view.leading.equalToSuperview().offset(60)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(48)
        }

        showQROrClose.snp.makeConstraints { view in
            view.top.equalTo(count.snp.bottom).offset(10)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(81)
        }

    }

}

//MARK: Make buttons actions
extension HomeViewController {
    
    private func makeButtonsAction() {
        self.showQROrClose.addTarget(self, action: #selector(showQR), for: .touchUpInside)
    }

    @objc func showQR() {
        switch self.buttonState {
        case .showQR:
            self.headerImage.image = UIImage(named: "home2")
            self.showQROrClose.setImage(UIImage(named: "closeButton"), for: .normal)
            self.buttonState = .close
        case .close:
            self.headerImage.image = UIImage(named: "home1")
            self.showQROrClose.setImage(UIImage(named: "showQRButton"), for: .normal)
            self.buttonState = .showQR
        }
    }

    private func setupNavigationItems() {

        let addButton = UIButton(type: .system)
        addButton.setImage(UIImage(named: "settings"), for: .normal)
        addButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = barButton
        self.navigationController?.navigationBar.tintColor = .white

        let leftImageView = UIImageView(image: UIImage(named: "header"))
        leftImageView.contentMode = .scaleAspectFit

        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 198, height: 52))
        leftImageView.frame = containerView.bounds
        containerView.addSubview(leftImageView)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: containerView)
        self.navigationController?.navigationBar.backgroundColor = UIColor(hex: "#0D0D0D")
    }

    private func setHeaderAttributedText() {

        let fullText = "1500A"
        let highlightedText: String = "A"

        let attributedString = NSMutableAttributedString(string: fullText)

        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: fullText.count))

        if let range = fullText.range(of: highlightedText) {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#F5C920")!, range: nsRange)
        }

        count.attributedText = attributedString
    }

    @objc func openSettings() {
        guard let navigationController = self.navigationController else { return }
        HomeRouter.showSettingsViewController(in: navigationController)
    }
}

extension HomeViewController: IViewModelableController {
    typealias ViewModel = IHomeViewModel
}

enum ButtonState {
    case showQR
    case close
}

//MARK: Preview
import SwiftUI

struct HomeViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let homeViewController = HomeViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<HomeViewControllerProvider.ContainerView>) -> HomeViewController {
            return homeViewController
        }

        func updateUIViewController(_ uiViewController: HomeViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<HomeViewControllerProvider.ContainerView>) {
        }
    }
}
