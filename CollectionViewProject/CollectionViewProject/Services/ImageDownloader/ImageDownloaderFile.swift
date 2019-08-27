//
//  ImageDownloaderFile.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 27/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import UIKit

class ImageDownloaderFile {
    
    lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.drom.imageDownloadqueue"
        queue.qualityOfService = .userInteractive
        return queue
    }()

    let fileManager: CasheFileManager

    init() {
        fileManager = CasheFileManagerImage(fileManager: FileManager.default,
                                            workDirectoryName: "Cache/Images")
    }

}

extension ImageDownloaderFile: ImageDownloader {

    func downloadImage(url: URL,
                       completion: @escaping (Result<(URL, UIImage?), Error>) -> ()) {
        if let imageUrl = try? fileManager.fileURL(identifier: url.absoluteString),
            let cachedData = try? Data(contentsOf: imageUrl),
            let cachedImage = UIImage(data: cachedData) {
            completion(.success((url, cachedImage)))
        } else {
            let operation = LoadImageOperation(url: url) { [weak self] (url , image) in
                if let image = image,
                    let data = image.pngData() {
                    try? self?.fileManager.store(data: data, identifier: url.absoluteString)
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
        try? fileManager.clean()
    }
    
}
