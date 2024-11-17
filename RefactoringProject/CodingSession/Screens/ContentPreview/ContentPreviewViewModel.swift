//
//  ContentPreviewViewModel.swift
//  CodingSession
//
//  Created by Rustam Shorov on 17.11.24.
//

import Foundation
import Photos
import UIKit
import RxSwift

protocol ContentPreviewViewModelProtocol {
    var onAssetsFetched: PublishSubject<Void> { get }
    
    func didLoad()
}

protocol ContentPreviewDataSource {
    func getCellModel(for index: Int) -> ContentPreviewCollectionCellViewModel?
    func numberOfItemsInSection() -> Int
}

class ContentPreviewViewModel: ContentPreviewViewModelProtocol {
    
    private let fetchAssetsUseCase: FetchAssetUseCase
    private let requestImageUseCase: RequestImageUseCase
    
    private var assets: [PHAsset] = []
    private let dateFormatter = DateComponentsFormatter()
    
    let onAssetsFetched = PublishSubject<Void>()
    
    init(fetchAssetsUseCase: FetchAssetUseCase,
         requestImageUseCase: RequestImageUseCase) {
        self.fetchAssetsUseCase = fetchAssetsUseCase
        self.requestImageUseCase = requestImageUseCase

        setupDateFormatter()
    }
    
    func didLoad() {
        var videoAssets: [PHAsset] = []
        
        fetchAssetsUseCase.fetchAsset { asset in
            videoAssets.append(asset)
        }
        
        self.assets = videoAssets
        onAssetsFetched.onNext(())
    }
    
    private func setupDateFormatter() {
        dateFormatter.allowedUnits = [.hour, .minute, .second]
        dateFormatter.zeroFormattingBehavior = [.pad]
        dateFormatter.unitsStyle = .positional
    }
    
    private func getFormattedTitle(from duration: TimeInterval) -> String? {
        return dateFormatter.string(from: duration)
    }
}

extension ContentPreviewViewModel: ContentPreviewDataSource {
    
    func getCellModel(for index: Int) -> ContentPreviewCollectionCellViewModel? {
        let asset = assets[index]
        let title = getFormattedTitle(from: asset.duration)
        
        let cellModel = ContentPreviewCollectionCellViewModel(
            title: title,
            asset: asset,
            requestImageUseCase: self.requestImageUseCase
        )

        return cellModel
    }

    func numberOfItemsInSection() -> Int {
        assets.count
    }
}
