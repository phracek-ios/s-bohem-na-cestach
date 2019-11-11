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
        let text: String
    }
    let cellIdentifier = "PrayersTableViewCell"
    fileprivate var rowData = [RowData]()
    fileprivate var prayersStructure: PrayersStructure?
    fileprivate var darkMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        let userDefaults = UserDefaults.standard
        self.darkMode = userDefaults.bool(forKey: "NightSwitch")
        label.text = "S Bohem na cestách"
        label.textAlignment = .left
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        prayersStructure = PrayersDataService.shared.prayersStructure
        // Register cell
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)

        if self.darkMode {
            self.tableView.backgroundColor = UIColor.WithGodOnRoad.backNightColor()
        } else {
            self.tableView.backgroundColor = UIColor.WithGodOnRoad.backLightColor()
        }
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.gray
        loadPrayersMenu()
        self.tableView.tableFooterView = UIView()
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.WithGodOnRoad.mainColor()]
        navigationController?.navigationBar.barStyle = UIBarStyle.black;
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        self.darkMode = userDefaults.bool(forKey: "NightSwitch")
        tableView.reloadData()
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
        cell.backgroundColor = UIColor.WithGodOnRoad.blueColor()
        cell.prayerName.textColor = UIColor.WithGodOnRoad.textLightColor()
        if self.darkMode {
            if indexPath.row % 2 == 0 {
                cell.prayerName.textColor = UIColor.WithGodOnRoad.textNightColor()
                cell.backgroundColor = UIColor.WithGodOnRoad.backNightColor()
            } else {
                cell.prayerName.textColor = UIColor.WithGodOnRoad.textLightColor()
            }
        }
        else {
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.WithGodOnRoad.backLightColor()
            }
        }


        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = rowData[indexPath.row]
        
        let view = R.storyboard.main.prayerViewController()!
        view.prayerTitle = data.name
        view.prayer = data.text
        navigationController?.pushViewController(view, animated: true)
    }

    private func loadPrayersMenu() {
        guard let prayersStructure = prayersStructure else { return }
        
        for prayer in prayersStructure.prayers {
            rowData.append(RowData(type: prayer.id, name: prayer.name, text: prayer.prayer))
        }
    }
    @objc private func darkModeEnabled(_ notification: Notification) {
        self.darkMode = true
        self.tableView.backgroundColor = UIColor.WithGodOnRoad.backNightColor()
        self.tableView.reloadData()
    }
    
    @objc private func darkModeDisabled(_ notification: Notification) {
        self.darkMode = false
        self.tableView.backgroundColor = UIColor.WithGodOnRoad.backLightColor()
        self.tableView.reloadData()
    }
}
