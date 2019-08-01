//
//  ViewController.swift
//  ResultTypeDemo
//
//  Created by Biron Su on 8/1/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var businesses = [Business]() {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let apiClient = YelpAPIClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        apiClient.searchBusinesses { result in
            switch result {
            case .failure(let error):
                print("error: \(error)")
            case .success(let code):
                print("code: \(code)")
            }
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TableViewCell else { return TableViewCell()}
        cell.titleLabel.text = businesses[indexPath.row].name
        cell.placeImage.image = 
        return cell
    }
    
    
}

