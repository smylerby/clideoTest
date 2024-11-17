//
//  AssetsRepository.swift
//  CodingSession
//
//  Created by Rustam Shorov on 17.11.24.
//

import Foundation
import Photos
import UIKit

protocol AssetsRepositoryHolderType {
    var assetsRepository: AssetsRepositoryProtocol { get }
}

protocol AssetsRepositoryProtocol {
    func fetchAsset(options: PHFetchOptions?, completion: @escaping (PHAsset) -> Void)
    func requestImage(asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?, completion: @escaping (UIImage?) -> Void)
}

final class AssetsRepository: AssetsRepositoryProtocol {

    private enum Constants {
        static let mediaPredicate = "mediaType == %d"
    }
    
    static let shared = AssetsRepository()
    
    private let imageManager: PHImageManager
    private let defaultImageRequestOptions: PHImageRequestOptions
    private let defaultVideoRequestOptions: PHFetchOptions
    
    private init() { 
        self.imageManager = PHImageManager.default()
        
        self.defaultImageRequestOptions = PHImageRequestOptions()
        self.defaultImageRequestOptions.isSynchronous = false
        self.defaultImageRequestOptions.deliveryMode = .highQualityFormat
        
        self.defaultVideoRequestOptions = PHFetchOptions()
        self.defaultVideoRequestOptions.predicate = NSPredicate(format: Constants.mediaPredicate, PHAssetMediaType.video.rawValue)
    }
    
    func fetchAsset(options: PHFetchOptions? = nil, completion: @escaping (PHAsset) -> Void) {
        let fetchOptions = options ?? self.defaultVideoRequestOptions
        
        let fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        
        fetchResult.enumerateObjects { (asset, _, _) in
            completion(asset)
        }
    }
    
    func requestImage(
        asset: PHAsset,
        targetSize: CGSize,
        contentMode: PHImageContentMode = .aspectFill,
        options: PHImageRequestOptions? = nil,
        completion: @escaping (UIImage?) -> Void
    ) {
        
        let requestOptions = options ?? self.defaultImageRequestOptions
        imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: requestOptions, resultHandler: { image,_ in
            completion(image)
        })
    }
}
