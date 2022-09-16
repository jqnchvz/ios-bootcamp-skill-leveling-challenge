//
//  ItemDetailViewController.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 15-09-22.
//

import UIKit
import SDWebImage

class ItemDetailViewController: UIViewController {
    
    var item: MultigetQueryItem?
    
    private lazy var detailsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = item?.body.condition
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = item?.body.title
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var sellerAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = item?.body.seller_address.formattedLocation
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "x.square"))
        imageView.tintColor = .gray
        imageView.backgroundColor = .systemGray6
        if let urlString = item?.body.pictures[0].secure_url {
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
        label.text = item?.body.formattedPrice
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 36)
        return label
    }()
    
    private lazy var askButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 167, height: 48))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Preguntar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "MeliBlue")
        button.layer.cornerRadius = 6
        return button
    }()
    
    private lazy var contactButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 167, height: 48))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("📎 Whatsapp", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "MeliBlue")
        button.layer.cornerRadius = 6
        return button
    }()
    
//    private lazy var favoriteButton: UIButton = {
//
//    }()
//
//    private lazy var shareButton: UIButton = {
//
//    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Descripción"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
        
    }()
    
    private lazy var descriptionTextLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "lorem ipsum"
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.numberOfLines = 0
        textView.sizeToFit()
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        print("Loading view...")
        
        if let item = item {
            ApiCaller.shared.fetchDescription(item.body.id) { result in
                print("Fetching description...")
                switch result {
                case .success(let description):
                    DispatchQueue.main.async {
                        self.descriptionTextLabel.text = description.plain_text
                        print("Description updated")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
           
        }
   
        setupViews()
        setupConstraints()
        
    }
    
    private func setupViews() {
        print("Setting up views...")
        detailsScrollView.contentSize
        self.contentView.addSubview(subtitleLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(sellerAddressLabel)
        self.contentView.addSubview(mainImageView)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(descriptionTitleLabel)
        self.contentView.addSubview(descriptionTextLabel)
        self.detailsScrollView.addSubview(contentView)
        self.view.addSubview(detailsScrollView)
        
    }
    
    private func setupConstraints() {
        print("Setting up constraints...")
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            detailsScrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            detailsScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            detailsScrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            detailsScrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: detailsScrollView.widthAnchor),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: detailsScrollView.topAnchor, constant: 20),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 17),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 6),
            titleLabel.heightAnchor.constraint(equalToConstant: 17),
            
            sellerAddressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sellerAddressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sellerAddressLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            sellerAddressLabel.heightAnchor.constraint(equalToConstant: 17),
            
            mainImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainImageView.topAnchor.constraint(equalTo: sellerAddressLabel.bottomAnchor, constant: 24),
            mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor),
            
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            priceLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 24),
            priceLabel.heightAnchor.constraint(equalToConstant: 45),
            
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionTitleLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 25),
            descriptionTitleLabel.heightAnchor.constraint(equalToConstant: 17),
            
            descriptionTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionTextLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 24),
            descriptionTextLabel.bottomAnchor.constraint(equalTo: detailsScrollView.bottomAnchor)
        ])
    }

}
