//
//  ErrorView.swift
//  JustNews
//

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
