//
//  MainViewController.swift
//  JustNews
//
//  Created by Indo Teknologi Utama on 14/11/24.
//

enum GeneralSection {
    case main
    case error
    case loadingIndicator
}

typealias GeneralCDataSource = UICollectionViewDiffableDataSource<GeneralSection, AnyHashable>
typealias GeneralCSnapshot = NSDiffableDataSourceSnapshot<GeneralSection, AnyHashable>

import UIKit

extension MainViewController {
    static func instantiate() -> MainViewController {
        .init(viewModel: MainViewModel())
    }
}

class MainViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = configureCollectionView()
    private lazy var dataSource = configureDataSource()
    private var snapshot: GeneralCSnapshot
    
    var viewModel: IMainViewModel
    
    init(viewModel: IMainViewModel) {
        self.snapshot = GeneralCSnapshot()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.fillSuperviewSafeArea()
        collectionView.dataSource = self.dataSource
        viewModel.posts.bind { posts in
            if !self.snapshot.sectionIdentifiers.contains(.main) {
                self.snapshot.appendSections([.main])
                self.dataSource.apply(self.snapshot)
            }
            self.snapshot.appendItems(posts, toSection: .main)
            DispatchQueue.main.async {
                self.dataSource.apply(self.snapshot, animatingDifferences: true)
            }
        }
        viewModel.state.bind { state in
            DispatchQueue.main.async {
                self.collectionView.setState(with: state)
            }
        }
        viewModel.fetchNews()
    }
    
    private func configureCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.register(MainCollectionViewCell.self)
        collectionView.register(LoadingCVCell.self)
        collectionView.backgroundColor = .lightGray
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = .zero
        collectionView.delegate = self
        return collectionView
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [unowned self] index, env in
            return self.sectionFor(index: index, environment: env)
        }
    }
    /// - Tag: ListAppearances
    func sectionFor(index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = snapshot.sectionIdentifiers[index]
        switch section {
        case .main:
            // Define item size with a fixed height of 160
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(160))
            
            // Create an item with the defined size
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Define the spacing between items (horizontal)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            
            // Create a group with 3 items in 1 row
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(160))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Define the spacing between groups (vertical)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            
            // Define the spacing between sections (rows)
            section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
            
            return section
        case .loadingIndicator, .error:
            // Define item size with a fixed height of 160
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
            
            // Create an item with the defined size
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // Define the spacing between items (horizontal)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
            
            // Create a group with 3 items in 1 row
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // Define the spacing between groups (vertical)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            
            // Define the spacing between sections (rows)
            section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
            
            return section
        }
    }
    
    private func configureDataSource() -> GeneralCDataSource {
        let _dataSource = GeneralCDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            if self.snapshot.sectionIdentifiers[indexPath.section] == .loadingIndicator {
                let indicatorCell: LoadingCVCell = collectionView.dequeue(at: indexPath)
                indicatorCell.start()
                return indicatorCell
            }
            let cell: MainCollectionViewCell = collectionView.dequeue(at: indexPath)
            if let post = itemIdentifier as? Post {
                cell.bind(with: post)
            }
            return cell
        }
        
        snapshot.appendSections([.main])
        _dataSource.apply(snapshot)
        return _dataSource
    }
}
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        if let movies = snapshot.itemIdentifiers(inSection: .main) as? [Movie] {
        //            self.presenter.didTapMovie(movie: movies[indexPath.row])
        //        }
    }
}
