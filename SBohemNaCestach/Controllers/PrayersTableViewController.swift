//
//  PrayersTableViewController.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 25/10/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class PrayersTableViewController: UITableViewController {

    struct RowData {
        let type: Int
        let name: String
    }
    let cellIdentifier = "PrayersTableViewCell"
    fileprivate var rowData = [RowData]()
    fileprivate var prayersStructure: PrayersStructure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "S Bohem na cestách"
        prayersStructure = PrayersDataService.shared.prayersStructure
        // Register cell
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        let userDefaults = UserDefaults.standard
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.gray
        loadPrayersMenu()
        tableView.reloadData()
        self.tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? PrayersTableViewCell else {
            fatalError("The dequeue cell is not an entrance of \(cellIdentifier)")
        }
        cell.accessoryType = .disclosureIndicator
        cell.prayerName.text = rowData[indexPath.row].name
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.WithGodOnRoad.backLightColor()
        }
        else {
            cell.backgroundColor = UIColor.WithGodOnRoad.blueColor()
        }
        return cell
    }


    private func loadPrayersMenu() {
        guard let prayersStructure = prayersStructure else { return }
        
        for prayer in prayersStructure.prayers {
            rowData.append(RowData(type: prayer.id, name: prayer.name))
        }
    }
}
