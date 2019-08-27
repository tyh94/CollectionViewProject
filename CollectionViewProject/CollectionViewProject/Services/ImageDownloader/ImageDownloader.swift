//
//  ImageDownloader.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 27/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import UIKit

enum ImageDownloaderError: Error {
    case loadError
}

protocol ImageDownloader {

    func downloadImage(url: URL,
                       completion: @escaping (Result<(URL, UIImage?), Error>) -> ())
    
    func cancelAll()

    func cleanCashe()
    
}
