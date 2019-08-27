//
//  MainPresenter.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 27/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import UIKit

class MainPresenter {

    weak var viewInput: MainViewInput?

    let imageDownloader: ImageDownloader

    let images = [ImageCollectionViewCellObject(url: URL(string: "https://media.mnn.com/assets/images/2017/04/cat-in-tape-heptagon.jpg.838x0_q80.jpg")!),
                  ImageCollectionViewCellObject(url: URL(string: "https://cdn.iz.ru/sites/default/files/styles/900x600/public/photo_item-2017-10/1507111513.jpg?itok=KLCG2x9B")!),
                  ImageCollectionViewCellObject(url: URL(string: "https://animaljournal.ru/articles/pets/dogs/angliyskiy_koker_spaniel/koker_spaniel.jpg")!),
                  ImageCollectionViewCellObject(url: URL(string: "https://lapkins.ru/upload/uf/ca9/ca986f90d0226b3f27aa05f6b24b7cd9.jpg")!),
                  ImageCollectionViewCellObject(url: URL(string: "https://russian7.ru/wp-content/uploads/2017/06/dva-krolika-celuyutsya1.jpg")!),
                  ImageCollectionViewCellObject(url: URL(string: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIncZy5I9LZg8s8d_XQKyjcOqCMgM-c92V16s_GN6y1m2khUyI")!)]

    required init(viewInput: MainViewInput,
                  imageDownloader: ImageDownloader) {
        self.viewInput = viewInput
        self.imageDownloader = imageDownloader
    }

}

// MARK: - MainViewOutput

extension MainPresenter: MainViewOutput {

    func moduleWasLoaded() {
        viewInput?.update(images: images)
    }

    func moduleRefresh() {
        imageDownloader.cancelAll()
        imageDownloader.cleanCashe()
        viewInput?.update(images: images)
    }

    func downloadImage(url: URL,
                       completion: @escaping (URL, UIImage?) -> ()) {
        imageDownloader.downloadImage(url: url) { result in
            if case let .success(url, image) = result {
                DispatchQueue.main.async {
                    completion(url,image)
                }
            }
        }
    }

}
