//
//  UICollectionView+Extensions.swift
//  JustNews

import UIKit

class LoadingView: UIView {
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let backgroundView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Set up background
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.layer.cornerRadius = 10
        addSubview(backgroundView)

        // Set up activity indicator
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(activityIndicator)

        // Layout constraints
        NSLayoutConstraint.activate([
            // Background view centered in the loading view
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: 100),
            backgroundView.heightAnchor.constraint(equalToConstant: 100),

            // Activity indicator centered in the background view
            activityIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
}

class CollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    func setupView() { }
}
extension NSObject {

    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
extension UICollectionView {
    func setState(with newState: ViewState) {
        switch newState {
        case .success:
            backgroundView = UIView(frame: self.frame)
        case .loading:
            backgroundView = LoadingView()
        case .error:
            backgroundView = LoadingView()
        }
    }
    func dequeue<T>(at indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
        return cell
    }
    func dequeue<T: UICollectionReusableView>(header indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.nameOfClass,
            for: indexPath
        ) as! T
    }
    func dequeue<T: UICollectionReusableView>(footer indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: T.nameOfClass,
            for: indexPath
        ) as! T
    }
    func dequeue<T: UICollectionReusableView>(for indexPath: IndexPath, and kind: String) -> T {
        return dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: T.nameOfClass,
            for: indexPath
        ) as! T
    }
    func register(_ _class: AnyClass) {
        register(_class, forCellWithReuseIdentifier: String(describing: _class.self))
    }

    func register<T: UICollectionReusableView>(header: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.nameOfClass)
    }

    func register<T: UICollectionReusableView>(footer: T.Type) {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.nameOfClass)
    }
    
    func selectRow(at row: Int, section: Int = 0, position: ScrollPosition = .top) {
        let indexPathSelected = IndexPath(row: row, section: section)
        self.selectItem(at: indexPathSelected, animated: true, scrollPosition: position)
    }
}
