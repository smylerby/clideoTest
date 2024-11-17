//
//  FetchAssetUseCase.swift
//  CodingSession
//
//  Created by Rustam Shorov on 17.11.24.
//

import Foundation
import Photos

protocol FetchAssetUseCase {
    func fetchAsset(completion: @escaping (PHAsset) -> Void)
    func fetchAsset(options: PHFetchOptions, completion: @escaping (PHAsset) -> Void)
}

extension FetchAssetUseCase where Self: AssetsRepositoryHolderType {
    func fetchAsset(completion: @escaping (PHAsset) -> Void) {
        assetsRepository.fetchAsset(options: nil, completion: completion)
    }
    
    func fetchAsset(options: PHFetchOptions, completion: @escaping (PHAsset) -> Void) {
        assetsRepository.fetchAsset(options: options, completion: completion)
    }
}
