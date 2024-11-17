//
//  ContentPreviewCollectionCell.swift
//  CodingSession
//
//  Created by Rustam Shorov on 17.11.24.
//

import UIKit

private enum Constants {
    static let padding: CGFloat = 8
}

final class ContentPreviewCollectionCell: UICollectionViewCell {
    
    private lazy var thumbImageView = makeImageView()
    private lazy var durationLabel = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        prepareUI()
    }
    
    var image: UIImage? {
        didSet {
            thumbImageView.image = image
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String?) {
        durationLabel.text = title
    }
    
    private func prepareUI() {
        layoutTitleLabel()
        layoutImageVIew()
    }
    
    override func prepareForReuse() {
        durationLabel.text = nil
        thumbImageView.image = nil
    }
}

// MARK: - Layout UI {
private extension ContentPreviewCollectionCell {
    func layoutTitleLabel() {
        contentView.addSubview(durationLabel)
        durationLabel.snp.makeConstraints { make in
            make.leading.equalTo(Constants.padding)
            make.bottom.equalTo(-Constants.padding)
        }
    }
    
    func layoutImageVIew() {
        contentView.addSubview(thumbImageView)
        thumbImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Prepare UI components
private extension ContentPreviewCollectionCell {
    
    func makeLabel() -> UILabel {
        let lbl = UILabel()
        lbl.accessibilityIdentifier = "lbl_duration"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        return lbl
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.accessibilityIdentifier = "view_image_thumb"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        return view
    }
}
