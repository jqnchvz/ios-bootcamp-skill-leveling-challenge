//
//  MainDetailView.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 19-09-22.
//

import UIKit

class DetailsHeaderView: UIView {
    
    var subtitle: String?
    var title: String?
    var sellerAddress: String?
    var imageUrl: String?
    var price: String?
    
    required init(subtitle: String?, title: String?, sellerAddress: String?, imageUrl: String? = nil, price: String?) {
        self.subtitle = subtitle ?? "N/A"
        self.title = title ?? "N/A"
        self.sellerAddress = sellerAddress ?? "N/A"
        self.imageUrl = imageUrl
        self.price = price ?? "$ -"

        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        self.subtitle = "No disponible"
        self.title = "No disponible"
        self.sellerAddress = "No disponible"
        self.imageUrl = nil
        self.price = "$ -"
        
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
        
    }
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = subtitle
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var sellerAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = sellerAddress
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "x.square"))
        imageView.tintColor = .gray
        imageView.backgroundColor = .systemGray6
        if let urlString = imageUrl {
            let url = URL(string: urlString)
            imageView.sd_setImage(with: url)
            imageView.backgroundColor = .white
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = price
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 36)
        return label
    }()
    
    private func setupView() {
        
        self.addSubview(subtitleLabel)
        self.addSubview(titleLabel)
        self.addSubview(sellerAddressLabel)
        self.addSubview(mainImageView)
        self.addSubview(priceLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 17),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 6),
            titleLabel.heightAnchor.constraint(equalToConstant: 17),
            
            sellerAddressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sellerAddressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sellerAddressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            sellerAddressLabel.heightAnchor.constraint(equalToConstant: 17),
            
            mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainImageView.topAnchor.constraint(equalTo: sellerAddressLabel.bottomAnchor, constant: 24),
            mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor),
            
            priceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 24),
            priceLabel.heightAnchor.constraint(equalToConstant: 45),
            priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }


}
