//
//  PrayersTableViewController.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 25/10/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit

class PrayersTableViewController: UIViewController, UITableViewDelegate {

    struct RowData {
        let type: Int
        let name: String
        let text: String
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
         tv.translatesAutoresizingMaskIntoConstraints = false
         return tv
    }()
    
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
        setupUI()
        loadPrayersMenu()

        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)
    }
    
    func setupUI() {
        self.view.addSubview(tableView)
        self.view.topAnchor.constraint(equalTo: tableView.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        self.view.leftAnchor.constraint(equalTo: tableView.leftAnchor).isActive = true
        self.view.rightAnchor.constraint(equalTo: tableView.rightAnchor).isActive = true
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        // Register cell
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PrayersTableViewCell.self, forCellReuseIdentifier: PrayersTableViewCell.cellId)

        if self.darkMode {
            self.tableView.backgroundColor = UIColor.WithGodOnRoad.backNightColor()
        } else {
            self.tableView.backgroundColor = UIColor.WithGodOnRoad.backLightColor()
        }
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorColor = UIColor.gray
        self.tableView.tableFooterView = UIView()
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
extension PrayersTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PrayersTableViewCell.cellId) as! PrayersTableViewCell
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = rowData[indexPath.row]
        
        let view = PrayerViewController()
        view.prayerTitle = data.name
        view.prayer = data.text
        navigationController?.pushViewController(view, animated: true)
    }
}
