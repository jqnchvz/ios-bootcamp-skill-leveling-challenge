//
//  CustomTableViewCell.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 14-09-22.
//

import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .gray
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .gray
        return label
    }()
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "x.square"))
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = .systemGray6
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(itemImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(locationLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 159),
            
            itemImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 11),
            itemImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 131),
            itemImageView.heightAnchor.constraint(equalToConstant: 131),
            
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -11),
            titleLabel.heightAnchor.constraint(equalToConstant: 17),
            
            priceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -11),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.heightAnchor.constraint(equalToConstant: 25),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -11),
            subtitleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 17),
            
            locationLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -11),
            locationLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 2),
            locationLabel.heightAnchor.constraint(equalToConstant: 17)
            
            
            
        ])
    }
    
    func setTitle(_ title: String = "") {
        titleLabel.text = title
    }
    
    func setSubtitle(_ subtitle: String = "") {
        subtitleLabel.text = subtitle
    }
    
    func setPrice(_ priceString: String = "$ -") {
        priceLabel.text = priceString
    }
    
    func setLocation(_ location: String = "") {
        locationLabel.text = location
    }
    
    func setImageThumbnail(_ url: String) {
        let url = URL(string: url)!
        itemImageView.sd_setImage(with: url)
        
    }
    
}
