//
//  UICollectionView+Register.swift
//  CodingSession
//
//  Created by Rustam Shorov on 17.11.24.
//

import UIKit

// MARK: - UICollectionView
extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: T.description().components(separatedBy: ".").last ?? "")
    }
}
