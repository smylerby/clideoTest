//
//  RequestImageUseCase.swift
//  CodingSession
//
//  Created by Rustam Shorov on 17.11.24.
//

import Foundation
import Photos
import UIKit

protocol RequestImageUseCase {
    func requestImage(asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?, completion: @escaping (UIImage?) -> Void)
    func requestImage(asset: PHAsset, targetSize: CGSize, completion: @escaping (UIImage?) -> Void)
}

extension RequestImageUseCase where Self: AssetsRepositoryHolderType {
    func requestImage(asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?, completion: @escaping (UIImage?) -> Void) {
        assetsRepository.requestImage(asset: asset, targetSize: targetSize, contentMode: contentMode, options: options, completion: completion)
    }
    
    func requestImage(asset: PHAsset, targetSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        assetsRepository.requestImage(asset: asset, targetSize: targetSize, contentMode: .aspectFill, options: nil, completion: completion)
    }
}
