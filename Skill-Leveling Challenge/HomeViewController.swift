//
//  HomeViewController.swift
//  Skill-Leveling Challenge
//
//  Created by Joaquin Gonzalo Chavez Barbaste on 12-09-22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let testArray = ["Celda 1", "Celda 2", "Celda 3"]
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Buscar en Mercado Libre"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.layer.cornerRadius = 20
        searchBar.backgroundColor = .white
        searchBar.backgroundImage = UIImage()
        
        return searchBar
    }()
    
    private lazy var resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        self.view.addSubview(searchBar)
        self.view.addSubview(resultsTableView)
    }
    
    private func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            resultsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            resultsTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            resultsTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            resultsTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20)
        
        ])
        
    }
}

extension HomeViewController: UITableViewDelegate {
}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = testArray[indexPath.row]
        cell.detailTextLabel?.text = "Descripción \(indexPath.row)"
        cell.textLabel?.textColor = .black
        return cell
    }
}
