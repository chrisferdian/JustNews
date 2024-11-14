//
//  MainCollectionViewCell.swift
//  JustNews
//
//  Created by Indo Teknologi Utama on 14/11/24.
//

import UIKit
import SDWebImage

class MainCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView(contentMode: .scaleAspectFill)
    let labelTitle = UILabel()
    let labelDescription = UILabel()
    let labelDateTime = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        contentView.addSubview(imageView)
        imageView.verticalSuperview(space: 8)
        imageView.leftToSuperview(space: 8)
        imageView.square(edge: 100)
        imageView.setCorner(radius: 8)
        imageView.clipsToBounds = true
        
        contentView.addSubview(labelTitle)
        labelTitle.font = .systemFont(ofSize: 14, weight: .medium)
        labelTitle.numberOfLines = 1
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.left(toAnchor: imageView.rightAnchor, space: 8)
        labelTitle.topToSuperview(space: 8)
        labelTitle.rightToSuperview(space: -8)
        
        contentView.addSubview(labelDescription)
        labelDescription.font = .systemFont(ofSize: 12, weight: .light)
        labelTitle.numberOfLines = 2
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.top(toAnchor: labelTitle.bottomAnchor, space: 4)
        labelDescription.rightToSuperview(space: -8)
        labelDescription.left(toAnchor: imageView.rightAnchor, space: 8)
        labelDescription.textColor = .gray
        
        contentView.addSubview(labelDateTime)
        labelDateTime.font = .systemFont(ofSize: 12, weight: .regular)
        labelDateTime.translatesAutoresizingMaskIntoConstraints = false
        labelDateTime.bottomToSuperview(space: -8)
        labelDateTime.left(toAnchor: imageView.rightAnchor, space: 8)
        labelDateTime.rightToSuperview(space: -8)
        labelDateTime.textColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(with post: Post) {
        imageView.sd_setImage(with: URL(string: post.image))
        labelTitle.text = post.title
        labelDescription.text = post.content
        labelDateTime.text = post.publishedAt
    }
}
