//
//  ImageCollectionViewCell.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 26/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    var imageView: UIImageView!
    var activityIndicator: UIActivityIndicatorView!

    var cellObject: ImageCollectionViewCellObject!

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        contentView.addSubview(activityIndicator)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        activityIndicator.center = contentView.center
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
