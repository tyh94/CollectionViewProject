//
//  LoadImageOperation.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 26/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import UIKit

class LoadImageOperation: AsyncOperation {

    let url: URL
    let completion: (URL, UIImage?) -> ()

    var task: URLSessionTask?

    required init(url: URL,
                  completion: @escaping (URL, UIImage?) -> ()) {
        self.url = url
        self.completion = completion
    }

    override func main() {
        guard isCancelled == false else {
            completeOperation()
            return
        }
        task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let data = data,
                let image = UIImage(data: data) {
                self.completion(self.url, image)
            } else {
                self.completion(self.url, nil)
            }
            self.completeOperation()
        }
        task?.resume()
    }

    override func cancel() {
        super.cancel()
        task?.cancel()
    }

}
