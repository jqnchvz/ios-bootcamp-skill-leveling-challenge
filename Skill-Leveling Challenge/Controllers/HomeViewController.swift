//
//  HomeViewController.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 12-09-22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var itemsList: MultigetQuery = []
    
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

    private lazy var itemsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .done, target: self, action: nil)
        
        self.view.addSubview(itemsTableView)
    }
    
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

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = ItemDetailViewController()
        detailViewController.item = itemsList[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

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
        cell.setTitle(item.title)
        cell.setPrice(item.formattedPrice)
        cell.setSubtitle(item.condition.capitalized)
        cell.setLocation(item.seller_address.formattedLocation)
        cell.setImageThumbnail(item.secure_thumbnail)
        return cell
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Buscando \(searchBar.searchTextField.text)")
        guard let searchTerm = searchBar.searchTextField.text else { return }
        ApiCaller.shared.fetchItemsDetails(searchTerm) { result in
            switch result {
            case .success(let multigetQuery):
                self.itemsList = multigetQuery
                DispatchQueue.main.async {
                    self.itemsTableView.reloadData()
                }
                
            case.failure(let error):
                self.itemsList.removeAll()
                DispatchQueue.main.async {
                    self.itemsTableView.reloadData()
                }
                print(error.localizedDescription)
            }
        }
    }
}
