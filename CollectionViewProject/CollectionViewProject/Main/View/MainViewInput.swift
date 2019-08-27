//
//  MainViewInput.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 27/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import Foundation

protocol MainViewInput: AnyObject {

    func update(images: [ImageCollectionViewCellObject])
    
}
