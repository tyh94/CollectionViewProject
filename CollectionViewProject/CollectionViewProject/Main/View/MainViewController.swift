//
//  MainViewController.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 26/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var collectionView: UICollectionView!
    var layout: UICollectionViewFlowLayout!
    var refresher: UIRefreshControl!

    var viewOutput: MainViewOutput!

    var images = [ImageCollectionViewCellObject]()

    private func addBlurEffect(toView view: UINavigationBar) {
        view.setBackgroundImage(UIImage(), for: .default)
        view.shadowImage = UIImage()

        var bounds = view.bounds
        bounds.offsetBy(dx: 0.0, dy: -10.0)
        bounds.size.height = bounds.height + 10.0

        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)

        visualEffectView.isUserInteractionEnabled = false
        visualEffectView.frame = bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(visualEffectView, at: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        if let navigationController = navigationController {
            addBlurEffect(toView: navigationController.navigationBar)
        }
        layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        refresher = collectionView.addRefresher(target: self, action: #selector(pullToRefresh))
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: ImageCollectionViewCell.self))
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)
        viewOutput.moduleWasLoaded()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if #available(iOS 11.0, *) {
            collectionView.frame = view.safeAreaLayoutGuide.layoutFrame
        } else {
            collectionView.frame = view.bounds
        }
        let itemSide = collectionView.frame.size.width - 20
        layout.itemSize = CGSize(width: itemSide, height: itemSide)
    }

    @objc private func pullToRefresh() {
        viewOutput.moduleRefresh()
        refresher.endRefreshing()
    }

}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ImageCollectionViewCell.self),
                                                      for: indexPath) as! ImageCollectionViewCell
        cell.activityIndicator.startAnimating()
        cell.cellObject = images[indexPath.item]
        return cell
    }


}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let object = images[indexPath.item]
        viewOutput.downloadImage(url: object.url) { (url, image) in
            guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
            if let image = image,
                cell.cellObject.url == url {
                cell.imageView.image = image
            }
            cell.activityIndicator.stopAnimating()
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        if cell.imageView.image != nil {
            UIView.animate(withDuration: 0.3, animations: {
                cell.frame.origin.x = cell.frame.size.width
                cell.alpha = 0
            }) { _ in
                collectionView.performBatchUpdates({
                    collectionView.deleteItems(at: [indexPath])
                    self.images.remove(at: indexPath.item)
                })
            }
        }
    }

}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {

    func update(images: [ImageCollectionViewCellObject]) {
        self.images = images
        collectionView.reloadData()
    }

}
