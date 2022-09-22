//
//  HomeView.swift
//  Organizart
//
//  Created by Cynara Costa on 13/09/22.
//

import UIKit

class HomeView: UIView {
    
    let card = CardViewInvoicing()
    let scrollView = UIScrollView()
    

    private let cardView: UIView = {
        let cardView = UIView()
        let teste = UILabel()
        teste.text = "teste"
        cardView.addSubview(teste)
        cardView.backgroundColor = .green
        cardView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return cardView
    }()

    private let backgroundView: UIImageView = {
        let backgroundView = UIImageView()
        backgroundView.image = UIImage(named: "background")
        backgroundView.contentMode = .scaleAspectFill
        return backgroundView
    }()

    private let invoicingLabel: UILabel = {
        let invoicingLabel = UILabel()
        invoicingLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 25)
        invoicingLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        invoicingLabel.text = "Faturamento"
        invoicingLabel.textColor = .label
        return invoicingLabel
    }()

    private let topProduct: UILabel = {
        let topProduct = UILabel()
        topProduct.text = "Produtos mais vendidos"
        topProduct.frame = CGRect(x: 0, y: 0, width: 150, height: 25)
        topProduct.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        topProduct.textColor = .label
        return topProduct
    }()

    private let topSaleFormat: UILabel = {
        let topSaleFormat = UILabel()
        topSaleFormat.text = "Top meios de venda"
        return topSaleFormat
    }()
    
    let salesTableView: UITableView = {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height/4
        let salesTableView = UITableView()
        
        salesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        salesTableView.translatesAutoresizingMaskIntoConstraints = false
        salesTableView.register(HomeSalesTableViewCell.self, forCellReuseIdentifier: HomeSalesTableViewCell.identifier)
        
        return salesTableView
    }()
    
    let productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 194, height: 234)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.isScrollEnabled = true
        collectionView.isUserInteractionEnabled = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HomeProductsCell.self, forCellWithReuseIdentifier: HomeProductsCell.identifier)
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(backgroundView)
        addSubview(scrollView)
        scrollView.addSubview(invoicingLabel)
        scrollView.addSubview(card)
        scrollView.addSubview(topProduct)
        scrollView.addSubview(salesTableView)
        scrollView.addSubview(productsCollectionView)
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupConstraints(){
        
        scrollView.backgroundColor = .green
        scrollView.contentSize = CGSize(width: self.frame.width, height: self.frame.height * 2)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        invoicingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            invoicingLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            invoicingLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32),
        ])

        card.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: invoicingLabel.bottomAnchor, constant: 8),
            card.leadingAnchor.constraint(equalTo: invoicingLabel.leadingAnchor),
            card.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32)
        ])

        topProduct.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topProduct.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 24),
            topProduct.leadingAnchor.constraint(equalTo: card.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            salesTableView.topAnchor.constraint(equalTo: topProduct.bottomAnchor),
            salesTableView.leadingAnchor.constraint(equalTo: card.leadingAnchor),
            salesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            productsCollectionView.topAnchor.constraint(equalTo: salesTableView.bottomAnchor,constant: 5),
            productsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 50)
        ])

    }
    
    
}

extension HomeView {
    
    func setTableViewDataSourceDelegate(){
        salesTableView.dataSource = HomeViewController()
        salesTableView.delegate = HomeViewController()
        salesTableView.reloadData()
    }
    
    func setCollectionViewDataSource(){
        productsCollectionView.dataSource = HomeViewController()
        productsCollectionView.delegate = HomeViewController()
        productsCollectionView.reloadData()
        
    }
    
    
}



#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView().showPreview().previewDevice("iPhone 13")        }
    }
}
#endif
