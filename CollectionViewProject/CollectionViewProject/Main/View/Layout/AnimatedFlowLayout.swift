//
//  AnimatedFlowLayout.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 27/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import UIKit

class AnimatedFlowLayout: UICollectionViewFlowLayout {

    var deletedItemsToAnimate: Set<IndexPath> = []

    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        for item in updateItems {
            if item.updateAction == .delete {
                deletedItemsToAnimate.insert(item.indexPathBeforeUpdate!)
            }
        }
    }

    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath),
            deletedItemsToAnimate.contains(itemIndexPath) {
            attributes.frame.origin.x = attributes.frame.size.width
            attributes.alpha = 0
            deletedItemsToAnimate.remove(itemIndexPath)
            return attributes
        }
        return nil
    }

}
