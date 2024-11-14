//
//  DetailsViewController.swift
//  JustNews
//

import UIKit
import SDWebImage

extension DetailsViewController {
    static func instantiate(post: Post) -> DetailsViewController {
        let viewModel = DetailsViewModel(post: post)
        return DetailsViewController(viewModel: viewModel)
    }
}
class DetailsViewController: UIViewController {
    
    let viewModel: IDetailsViewModel
    
    init(viewModel: IDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI Components
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    private let labelsContainerView = UIStackView()
    private let heroImageView = UIImageView()
    private let titleLabel = UILabel()
    private let publishDateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let horizontalPadding: CGFloat = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // Scroll View setup
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Content View (UIStackView) setup
        contentView.axis = .vertical
        contentView.spacing = 16
        contentView.alignment = .fill
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        // Hero Image setup (no padding applied)
        heroImageView.contentMode = .scaleAspectFill
        heroImageView.clipsToBounds = true
        heroImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        contentView.addArrangedSubview(heroImageView)
        
        // Labels Container View setup (to apply padding to all labels)
        labelsContainerView.axis = .vertical
        labelsContainerView.spacing = 8
        labelsContainerView.alignment = .leading
        labelsContainerView.layoutMargins = UIEdgeInsets(top: 0, left: horizontalPadding, bottom: horizontalPadding, right: horizontalPadding)
        labelsContainerView.isLayoutMarginsRelativeArrangement = true
        contentView.addArrangedSubview(labelsContainerView)
        
        // Title Label setup
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        labelsContainerView.addArrangedSubview(titleLabel)
        
        // Publish Date Label setup
        publishDateLabel.font = UIFont.systemFont(ofSize: 14)
        publishDateLabel.textColor = .gray
        labelsContainerView.addArrangedSubview(publishDateLabel)
        
        // Description Label setup
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        labelsContainerView.addArrangedSubview(descriptionLabel)
    }
    
    private func configureUI() {
        // Placeholder content, replace with actual data
        heroImageView.sd_setImage(with: .init(string: viewModel.post.image))
        titleLabel.text = viewModel.post.title
        publishDateLabel.text = "Published on: \(viewModel.post.publishedAt)"
        descriptionLabel.text = "\(viewModel.post.content) \n \(viewModel.post.content)"
    }
}
