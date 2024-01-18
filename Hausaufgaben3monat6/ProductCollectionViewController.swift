//
//  ProductCollectionViewController.swift
//  Hausaufgaben3monat6
//
//  Created by Maksat Edil on 17/1/24.
//

import UIKit
import SnapKit

class ProductsCollectionViewController: UIViewController {
    
    private let urlParse = NetworkService()
    
    private var products: [Product] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 250, height: 100)
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .red
        view.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: ProductsCollectionViewCell.id)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
        fetchProducts()
    }
    
    private func setup() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
    
    private func fetchProducts() {
        urlParse.fetchProducts { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let model):
                self.products = model
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateProduct(_ product: Product) {
        urlParse.updateProduct(with: product) { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addProduct(_ product: Product) {
        urlParse.addNewProduct(with: product) { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func deleteProduct(_ product: Product) {
        urlParse.deleteProduct(with: product) { result in
            switch result {
            case .success(let model):
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ProductsCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.id, for: indexPath)
        as! ProductsCollectionViewCell
        let model = products[indexPath.item]
        cell.fill(with: model)
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        cell.layer.borderWidth = 1
        return cell
    }
}
