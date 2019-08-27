//
//  MainViewOutput.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 27/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import UIKit

protocol MainViewOutput {

    func moduleWasLoaded()

    func moduleRefresh()

    func downloadImage(url: URL,
                       completion: @escaping (URL, UIImage?) -> ())

}
