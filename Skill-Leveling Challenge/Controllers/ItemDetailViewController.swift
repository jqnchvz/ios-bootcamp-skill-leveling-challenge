//
//  ItemDetailViewController.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 15-09-22.
//

import UIKit
import SDWebImage

// MARK: ItemDetailViewController

// Item Details Screen
class ItemDetailViewController: UIViewController {
    // Selected item
    var item: MultigetQueryItem?
    
    // Main ScrollView
    private lazy var detailsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    // Content view to manage layout inside ScrollView
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Header view with main info about item
    private lazy var detailsHeaderView: DetailsHeaderView = {
        
        let headerView = DetailsHeaderView(
                                subtitle: item?.body.translatedCondition,
                                title: item?.body.title,
                                sellerAddress: item?.body.seller_address.formattedLocation,
                                imageUrl: item?.body.pictures[0].secure_url,
                                price: item?.body.formattedPrice
                            )
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        return headerView
    }()
    
    // Buttons view
    private lazy var detailsButtonsView: DetailsButtonsView = {
        let buttonsView = DetailsButtonsView()
        buttonsView.itemId = item?.body.id
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsView
    }()
    
    // Long text description view
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
    
    // Update buttons state when view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        detailsButtonsView.itemId = item?.body.id
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: nil)
        
        // Fetch description text for selected item
        if let item = item {
            ApiCallManager.shared.fetchDescription(item.body.id) { result in
                switch result {
                case .success(let description):
                    DispatchQueue.main.async {
                        self.descriptionTextLabel.text = description.plain_text
                    }
                case .failure(let error):
                    let errorMessage = "Error fetching description for item: \(error.description)"
                    ErrorsManager.shared.showErrorAlert(message: errorMessage, vc: self)
                }
            }
            
           
        }
   
        setupViews()
        setupConstraints()
        
    }
    
    // Add subviews
    private func setupViews() {
        self.contentView.addSubview(detailsHeaderView)
        self.contentView.addSubview(detailsButtonsView)
        self.contentView.addSubview(descriptionTitleLabel)
        self.contentView.addSubview(descriptionTextLabel)
        self.detailsScrollView.addSubview(contentView)
        self.view.addSubview(detailsScrollView)
        
    }
    
    // Set up layout constraints
    private func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            detailsScrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            detailsScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            detailsScrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            detailsScrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: detailsScrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: detailsScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: detailsScrollView.bottomAnchor),
            
            detailsHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            detailsHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            detailsHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            detailsButtonsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            detailsButtonsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            detailsButtonsView.topAnchor.constraint(equalTo: detailsHeaderView.bottomAnchor, constant: 25),
            
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionTitleLabel.topAnchor.constraint(equalTo: detailsButtonsView.bottomAnchor, constant: 58),
            descriptionTitleLabel.heightAnchor.constraint(equalToConstant: 17),
            
            descriptionTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionTextLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 24),
            descriptionTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}
