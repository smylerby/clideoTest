//
//  ContentPreviewBuilder.swift
//  CodingSession
//
//  Created by Rustam Shorov on 17.11.24.
//

import Foundation

final class ContentPreviewBuilder {
    
    static func build() -> ContentPreviewView {
        let context = ContentPreviewContext(assetsRepository: AssetsRepository.shared)
        
        let viewModel = ContentPreviewViewModel(
            fetchAssetsUseCase: context,
            requestImageUseCase: context)
        
        let vc = ContentPreviewViewController()
        
        vc.viewModel = viewModel
        vc.dataSource = viewModel
        return vc
    }
}

final private class ContentPreviewContext: AssetsRepositoryHolderType {
    let assetsRepository: AssetsRepositoryProtocol
    
    init(assetsRepository: AssetsRepositoryProtocol) {
        self.assetsRepository = assetsRepository
    }
}

extension ContentPreviewContext: FetchAssetUseCase {}
extension ContentPreviewContext: RequestImageUseCase {}
