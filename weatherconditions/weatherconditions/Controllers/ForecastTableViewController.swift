//
//  ForecastTableViewController.swift
//  weatherconditions
//
//  Created by Daniele Rapali on 30/10/2020.
//

import UIKit

class ForecastTableViewController: UITableViewController {
    // MARK: - Variables

     private let cellIdentifier = "forecastCell"
    
    var listModel: [List] = [] {
        didSet {
            tableView.reloadData()
        }
    }
}

extension ForecastTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listModel.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ForecastTableViewCell
        cell.bindCellData(model: listModel[indexPath.row])
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }

}
