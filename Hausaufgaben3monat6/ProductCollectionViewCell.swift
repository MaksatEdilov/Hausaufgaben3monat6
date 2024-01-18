//
//  ProductCollectionViewCell.swift
//  Hausaufgaben3monat6
//
//  Created by Maksat Edil on 17/1/24.
//

import UIKit


protocol ProductCellDelegate: AnyObject {
    func productSelected(_ product: Product)
}

class ProductsCollectionViewCell: UICollectionViewCell {
    
    static let id = String(describing: ProductsCollectionViewCell.self)
    
    
    private let productTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Max"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productDescriptionLabel: UILabel = {
        let view = UILabel()
        view.text = "Edilov"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productPriceLabel: UILabel = {
        let view = UILabel()
        view.text = "\(10)"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: ProductCellDelegate?
    
    private var product: Product?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setup() {
        addContentview()
        setupConstraints()
    }
    
    private func addContentview() {
        contentView.addSubview(productTitleLabel)
        contentView.addSubview(productDescriptionLabel)
        contentView.addSubview(productPriceLabel)
        //        contentView.addSubview(whiteView)
    }
    
    private func setupConstraints() {
        //        whiteView.snp.makeConstraints { make in
        //            make.directionalEdges.equalToSuperview()
        //        }
        
        
        NSLayoutConstraint.activate([
            //            whiteView.topAnchor.constraint(equalTo: contentView.topAnchor),
            //            whiteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            //            whiteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //            whiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            productTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            productDescriptionLabel.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor, constant: 5),
            productDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            productPriceLabel.topAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor, constant: 5),
            productPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
    
    func fill(with item: Product) {
        productTitleLabel.text = item.title
        productDescriptionLabel.text = item.description
        productPriceLabel.text = String(item.price)
        product = item
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellDidTapped))
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func cellDidTapped() {
        guard let product = product else { return }
        delegate?.productSelected(product)    }
}


