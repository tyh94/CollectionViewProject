//
//  ImageDownloaderCashe.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 26/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import UIKit

final class ImageDownloaderCashe {

    lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.drom.imageDownloadqueue"
        queue.qualityOfService = .userInteractive
        return queue
    }()

    let imageCache = NSCache<NSString, UIImage>()

}

extension ImageDownloaderCashe: ImageDownloader {

    func downloadImage(url: URL,
                       completion: @escaping (Result<(URL, UIImage?), Error>) -> ()) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success((url, cachedImage)))
        } else {
            let operation = LoadImageOperation(url: url) { [weak self] (url , image) in
                if let image = image {
                    self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(.success((url, image)))
                } else {
                    completion(.failure(ImageDownloaderError.loadError))
                }
            }
            imageDownloadQueue.addOperation(operation)
        }
    }

    func cancelAll() {
        imageDownloadQueue.cancelAllOperations()
    }

    func cleanCashe() {
        imageCache.removeAllObjects()
    }

}
