//
//  ContentPreviewCollectionCellModel.swift
//  CodingSession
//
//  Created by Rustam Shorov on 17.11.24.
//

import UIKit
import Photos

class ContentPreviewCollectionCellViewModel {
   
    let title: String?
    let asset: PHAsset
    let requestImageUseCase: RequestImageUseCase
    
    init(title: String?, asset: PHAsset, requestImageUseCase: RequestImageUseCase) {
        self.title = title
        self.asset = asset
        self.requestImageUseCase = requestImageUseCase
    }
    
    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        let targetSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
        self.requestImageUseCase.requestImage(
            asset: self.asset,
            targetSize: targetSize,
            completion: { image in
                completion(image)
        })
    }
}
