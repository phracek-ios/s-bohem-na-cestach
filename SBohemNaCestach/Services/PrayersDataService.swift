//
//  PrayersDataService.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 18/10/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import Foundation
class PrayersDataService {

    // MARK: - Shared
    static var shared = PrayersDataService()

    // MARK: - Properties
    var prayersStructure: PrayersStructure?

    // MARK: -
    func loadData() {
        parseJSON()
    }

    private func parseJSON() {
        if let path = Bundle.main.path(forResource: "prayers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                prayersStructure = try JSONDecoder().decode(PrayersStructure.self, from: data)
                //print(stationsStructure.debugDescription)
            } catch {
                print(error)
            }
        } else {
            print("File not found")
        }
    }

}
