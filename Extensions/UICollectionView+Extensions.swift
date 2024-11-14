//
//  UICollectionView+Extensions.swift
//  JustNews

import UIKit
class ErrorView: UIView {
    private let messageLabel = UILabel()
    private let retryButton = UIButton(type: .system)
    
    var onRetry: (() -> Void)?

    init(onRetry: (() -> Void)?) {
        self.onRetry = onRetry
        super.init(frame: .zero)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Configure message label
        messageLabel.text = "Something went wrong. Please try again."
        messageLabel.textColor = .darkGray
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
        
        // Configure retry button
        retryButton.setTitle("Retry", for: .normal)
        retryButton.setTitleColor(.systemBlue, for: .normal)
        retryButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        addSubview(retryButton)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            // Center the label in the view
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Retry button below the message label
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20)
        ])
    }

    @objc private func retryButtonTapped() {
        onRetry?()
    }
}
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
        case .error(let action):
            backgroundView = ErrorView(onRetry: action)
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
