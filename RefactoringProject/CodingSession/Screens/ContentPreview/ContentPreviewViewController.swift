//
//  ContentPreviewViewController.swift
//  CodingSession
//
//  Created by Rustam Shorov on 17.11.24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

protocol ContentPreviewView {
    var viewModel: ContentPreviewViewModelProtocol? { get set }
    var dataSource: ContentPreviewDataSource? { get set }
}

final class ContentPreviewViewController: UIViewController, ContentPreviewView {
    
    private lazy var collectionView = makeCollectionView()
    
    var viewModel: ContentPreviewViewModelProtocol?
    var dataSource: ContentPreviewDataSource?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        viewModel?.didLoad()
    }
    
    private func bind() {
        guard let viewModel = viewModel else { return }
        
        viewModel.onAssetsFetched
            .asDriver(onErrorDriveWith: .empty())
            .drive { _ in
                self.collectionView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(ContentPreviewCollectionCell.self)
    }
}

extension ContentPreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = dataSource else { return 0 }
        
        return dataSource.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataSource = dataSource,
              let model = dataSource.getCellModel(for: indexPath.row) else { return UICollectionViewCell() }
        
        let cell = ContentPreviewCollectionCell()
        
        model.fetchImage(completion: { image in
            cell.image = image
        })
        
        cell.configure(with: model.title)
        
        return cell
    }
    
}

// MARK: - Layout UI
private extension ContentPreviewViewController {
    
    func layoutCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Prepare UI components
private extension ContentPreviewViewController {
    
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.accessibilityIdentifier = "view_content_collection"
        
        return UICollectionView()
    }
}
