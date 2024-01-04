//
//  HomeViewController.swift
//  FlexPinAndReactorkit
//
//  Created by 박현준 on 12/17/23.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

enum HomeSection: CaseIterable {
    case main
}

final class HomeViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    let reactor: HomeReactor
    // MARK: - Properties
    lazy var homeCollectionView: UICollectionView = {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewFlowLayout()))
    
    // MARK: - Life Cycles
    init(reactor: HomeReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        addViews()
        setDataSource()
        bind(reactor: reactor)
        // 초기 더미 데이터
        reactor.configureSnapshot(data: HomeTripDummy.home.getTrips())
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeCollectionView.frame = view.bounds
    }
    
    // MARK: - Set UI
    private func addViews() {
        view.addSubview(homeCollectionView)
    }
    
    private func setCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width-40, height: 230)
        layout.headerReferenceSize = .init(width: UIScreen.main.bounds.width, height: 300)
        return layout
    }
    
    private func setDataSource() {
        homeCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        homeCollectionView.register(
            HomeCollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeCollectionHeaderView.identifier
        )
        
        reactor.dataSource = UICollectionViewDiffableDataSource<HomeSection, HomeTrip>(collectionView: self.homeCollectionView) { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
            cell.configure()
            return cell
        }
        
        reactor.dataSource.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeCollectionHeaderView.identifier, for: indexPath) as? HomeCollectionHeaderView else {
                    return HomeCollectionHeaderView()
                }
                header.backgroundColor = .brown
                return header
            } else {
                return nil
            }
        }
        
        homeCollectionView.dataSource = reactor.dataSource
    }
    
}

extension HomeViewController: View {
    func bind(reactor: HomeReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }

    // MARK: - Bind
    func bindAction(reactor: HomeReactor) {

    }

    func bindState(reactor: HomeReactor) {

    }
}
