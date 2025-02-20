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

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let headerImage = UIImageView(image: UIImage(named: "home1"))
    private let balance = UILabel(text: "Balance",
                                  textColor: .white,
                                  font: UIFont(name: "SFProText-Bold", size: 20))
    private let count = UILabel(text: "1500A",
                                textColor: .white,
                                font: UIFont(name: "SFProText-Bold", size: 20))
    private let showQROrClose = UIButton(type: .system)
    private let promoText = UILabel(text: "Promos",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Bold", size: 20))
    private let firsPromo = UIImageView(image: UIImage(named: "promo1"))
    private let secondPromo = UIImageView(image: UIImage(named: "promo2"))
    private let thirdPromo = UIImageView(image: UIImage(named: "promo3"))
    private var promosStack: UIStackView!

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

        self.promoText.textAlignment = .left
        self.promosStack = UIStackView(arrangedSubviews: [firsPromo,
                                                          secondPromo,
                                                          thirdPromo],
                                       axis: .vertical,
                                       spacing: 8)
        self.promosStack.distribution = .fillEqually

        scrollView.contentInsetAdjustmentBehavior = .never
        self.navigationController?.hidesBarsOnSwipe = true

        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.contentView.addSubview(headerImage)
        self.contentView.addSubview(balance)
        self.contentView.addSubview(count)
        self.contentView.addSubview(showQROrClose)
        self.contentView.addSubview(promoText)
        self.contentView.addSubview(promosStack)
        setupConstraints()
        setupNavigationItems()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        headerImage.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(130)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(self.view.frame.size.height - 308)
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

        promoText.snp.makeConstraints { view in
            view.top.equalTo(showQROrClose.snp.bottom).offset(20)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(30)
        }

        promosStack.snp.makeConstraints { view in
            view.top.equalTo(promoText.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(214)
            view.bottom.equalToSuperview().inset(20)
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
