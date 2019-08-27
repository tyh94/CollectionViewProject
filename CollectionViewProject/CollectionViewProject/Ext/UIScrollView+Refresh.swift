//
//  UIScrollView+Refresh.swift
//  CollectionViewProject
//
//  Created by Татьяна Хохлова on 26/08/2019.
//  Copyright © 2019 Drom. All rights reserved.
//

import UIKit

extension UIScrollView {

    @discardableResult func addRefresher(target: Any,
                                         action: Selector) -> UIRefreshControl {
        let refresher = UIRefreshControl()
        refresher.addTarget(target,
                            action: action,
                            for: .valueChanged)
        if #available(iOS 10.0, *) {
            refreshControl = refresher
        } else {
            addSubview(refresher)
        }
        return refresher
    }

}
