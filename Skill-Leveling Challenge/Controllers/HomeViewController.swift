//
//  HomeViewController.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 12-09-22.
//

import UIKit

// MARK: Main View Controller

// Main App Screen, First TabBar Item.
class HomeViewController: UIViewController {
    // Variable that stores items list obtained from the API call
    private var itemsList: MultigetQuery = []
    
    // Search bar
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Buscar en Mercado Libre"
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.layer.cornerRadius = 20
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOpacity = 0.25
        searchBar.layer.shadowOffset = CGSize(width: 1, height: 1)
        searchBar.layer.shadowRadius = 1

        return searchBar
    }()
    
    // Search results TableView
    private lazy var itemsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    // Add subviews to main view
    private func setupView() {
        self.view.backgroundColor = .white
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: nil)
        
        self.view.addSubview(itemsTableView)
    }
    
    // Set up layout constraints
    private func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            itemsTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            itemsTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            itemsTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            itemsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
    }
}


// MARK: TableView Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = ItemDetailViewController()
        detailViewController.item = itemsList[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

// MARK: TableView DataSource
extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        let item = itemsList[indexPath.row].body
        
        // Set custom TableViewCell labels and thumbnail
        cell.setTitle(item.title)
        cell.setPrice(item.formattedPrice)
        cell.setSubtitle(item.translatedCondition)
        cell.setLocation(item.seller_address.formattedLocation)
        cell.setImageThumbnail(item.secure_thumbnail)
        
        return cell
    }
}

// MARK: Searchbar Delegate
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Hide keyboard when search button pressed
        searchBar.resignFirstResponder()
        
        // Trim whitespaces from search text before API call
        guard let searchTerm = searchBar.searchTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        
        // Cascading API calls to get items list and details
        ApiCallManager.shared.fetchCategory(searchTerm) { result in
            switch result {
            case .success(let categories):
                ApiCallManager.shared.fetchTopItemsIds(categories[0]) { result in
                    switch result {
                    case .success(let highlightQuery):
                        ApiCallManager.shared.fetchItemsDetailsFor(highlightQuery) { result in
                            switch result {
                            case .success(let multigetQuery):
                                self.itemsList = multigetQuery
                                DispatchQueue.main.async {
                                    self.itemsTableView.reloadData()
                                }
                            case .failure(let error):
                                let errorMessage = "Error fetching item details: \(error.description)"
                                ErrorsManager.shared.showErrorAlert(message: errorMessage, vc: self)
                                return
                            }
                        }
                    case .failure(let error):
                        let errorMessage = "Error fetching item IDs from category: \(error.description)"
                        ErrorsManager.shared.showErrorAlert(message: errorMessage, vc: self)
                        return
                    }
                }
            case .failure(let error):
                let errorMessage = "Error fetching category prediction from search term: \(error.description)"
                ErrorsManager.shared.showErrorAlert(message: errorMessage, vc: self)
                return
            }
        }
    }
}
