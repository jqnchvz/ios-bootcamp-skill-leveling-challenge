//
//  FavoritesViewController.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 21-09-22.
//

import UIKit
// MARK: FavoritesViewContoller

// Favorites Screen, Second TabBar Item
class FavoritesViewController: UIViewController {
    // Variable that stores items list obtained from the API call
    private var favoriteItemsList: MultigetQuery = []
    
    // Favorites list TableView
    private lazy var itemsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        let favoriteIds = FavoritesManager.shared.favoritesIds
        
        // Check if favorites list is empty to clear TableView before doing API call.
        guard !favoriteIds.isEmpty else {
            favoriteItemsList.removeAll()
            DispatchQueue.main.async {
                self.itemsTableView.reloadData()
            }
            return
        }
        
        // Fetch details for favorite items
        ApiCallManager.shared.fetchItemsDetailsFor(favoriteIds) { result in
            switch result {
            case .success(let multigetQuery):
                print(multigetQuery)
                self.favoriteItemsList = multigetQuery
                DispatchQueue.main.async {
                    self.itemsTableView.reloadData()
                }
                return
                
            case .failure(let error):
                print("Error fetching favorites list details: ", error.localizedDescription)
                let errorMessage = "Error fetching favorites list details: \(error.localizedDescription)"
                ErrorsManager.shared.showErrorAlert(message: errorMessage, vc: self)
                return
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: nil)
        
        
        setupView()
        setupConstraints()
    }
    
    // Add subviews
    private func setupView() {
        self.view.backgroundColor = .white
        navigationItem.title = "Favoritos"
        
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
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = ItemDetailViewController()
        detailViewController.item = favoriteItemsList[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

// MARK: TableView DataSource
extension FavoritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteItemsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        let item = favoriteItemsList[indexPath.row].body
        cell.setTitle(item.title)
        cell.setPrice(item.formattedPrice)
        cell.setSubtitle(item.translatedCondition)
        cell.setLocation(item.seller_address.formattedLocation)
        cell.setImageThumbnail(item.secure_thumbnail)
        return cell
    }
}

