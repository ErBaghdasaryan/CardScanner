//
//  OnboardingViewController.swift
//  App008
//
//  Created by Er Baghdasaryan on 17.02.25.
//

import UIKit
import App008ViewModel
import SnapKit
import StoreKit

class OnboardingViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    var collectionView: UICollectionView!
    private let pageControl = AdvancedPageControlView()
    private let nextButton = UIButton(type: .system)
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = UIColor(hex: "#0D0D0D")

        self.nextButton.setImage(UIImage(named: "nextButton"), for: .normal)

        let mylayout = UICollectionViewFlowLayout()
        mylayout.itemSize = sizeForItem()
        mylayout.scrollDirection = .horizontal
        mylayout.minimumLineSpacing = 0
        mylayout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: mylayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear

        collectionView.register(OnboardingCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false

        pageControl.drawer = ExtendedDotDrawer(numberOfPages: 2,
                                               height: 8,
                                               width: 8,
                                               space: 8,
                                               indicatorColor: UIColor(hex: "#F5C920"),
                                               dotsColor: UIColor(hex: "#F5C920")?.withAlphaComponent(0.5),
                                               isBordered: true,
                                               borderWidth: 0.0,
                                               indicatorBorderColor: .orange,
                                               indicatorBorderWidth: 0.0)
        pageControl.setPage(0)

        self.view.addSubview(pageControl)
        self.view.addSubview(collectionView)
        self.view.addSubview(nextButton)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel?.loadData()
        collectionView.reloadData()
    }

    func sizeForItem() -> CGSize {
        let deviceType = UIDevice.currentDeviceType

        switch deviceType {
        case .iPhone:
            let width = self.view.frame.size.width - 32
            let heightt = self.view.frame.size.height - 440
            return CGSize(width: width, height: heightt)
        case .iPad:
            let scaleFactor: CGFloat = 1.5
            let width = 550 * scaleFactor
            let height = 1100 * scaleFactor
            return CGSize(width: width, height: height)
        }
    }

    func setupConstraints() {
        pageControl.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(83)
            view.centerX.equalToSuperview()
            view.width.equalTo(70)
            view.height.equalTo(10)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalTo(pageControl.snp.bottom).offset(108)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview().inset(240)
        }

        nextButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(62)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(64)
        }
    }

}

//MARK: Make buttons actions
extension OnboardingViewController {
    
    private func makeButtonsAction() {
        nextButton.addTarget(self, action: #selector(nextButtonTaped), for: .touchUpInside)
    }

    @objc func nextButtonTaped() {
        guard let navigationController = self.navigationController else { return }

        let numberOfItems = self.collectionView.numberOfItems(inSection: 0)
        let nextRow = self.currentIndex + 1

        if nextRow < numberOfItems {
            let nextIndexPath = IndexPath(item: nextRow, section: 0)
            self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            self.currentIndex = nextRow
            performActionForPage(index: currentIndex)
        } else {
            OnboardingRouter.showHomeViewController(in: navigationController)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleItems = collectionView.indexPathsForVisibleItems.sorted()
        if let visibleItem = visibleItems.first {
            currentIndex = visibleItem.item
            performActionForPage(index: currentIndex)
        }
    }

    func performActionForPage(index: Int) {
        switch index {
        case 0:
            pageControl.setPage(0)
        case 1:
            pageControl.setPage(1)
            nextButton.setImage(UIImage(named: "startButton"), for: .normal)
        default:
            break
        }
    }
}

extension OnboardingViewController: IViewModelableController {
    typealias ViewModel = IOnboardingViewModel
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel?.onboardingItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OnboardingCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(image: viewModel?.onboardingItems[indexPath.row].image ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

//MARK: Preview
import SwiftUI

struct OnboardingViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let onboardingViewController = OnboardingViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) -> OnboardingViewController {
            return onboardingViewController
        }

        func updateUIViewController(_ uiViewController: OnboardingViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) {
        }
    }
}
