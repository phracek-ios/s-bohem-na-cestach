//
//  AboutApplViewController.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 08/11/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import BonMot

class AboutApplViewController: UIViewController, TTTAttributedLabelDelegate {

    let paulin_web = "http://www.paulinky.cz"
    let paulin_email = "paulinky@paulinky.cz"
    let phracek_email = "phracek@gmail.com"
    let paulin_god_road = "http://paulinky.cz/obchod/detail/S-Bohem-na-cestach"

    @IBOutlet weak var aboutLabel: TTTAttributedLabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerContentView: UIView!
    
    var darkMode: Bool = false
    var back: UIColor = .black
    var text: UIColor = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let about_text_1: String = "<p><b>S Bohem na cestách</b></p><p>Výběr textu:<br>Anna Mátiková FSP, Andrea Hýblová FSP<br><br>Nakladatelství PAULÍNKY, 2010<br>Petrská 9, 110 00 Praha 1 <br>"
        let about_text_2: String = "</p><p>© Úvodní foto:<br>Mark Brown</p><p>© Program: <br>Petr Hracek "
        let about_text_3: String = "<br></p><p>Tato aplikace vznikla proto, aby doprovázela cestovatele, poutníka, turistu či „dovolenkáře“ při získávání nových zážitků a zkušeností, a napomáhala vést jeho pohled k Bohu a otvírala jeho srdce, aby i v čase prázdnin a dovolené bylo naplňováno Božími dary.<br></p><p>Chcete-li získat i tištěnou verzi této aplikace, lze si ji objednat v e-shopu Paulínky nebo v knihkupectvích s nabídkou křesťanské literatury:<br>"
        aboutLabel.numberOfLines = 0
        aboutLabel.delegate = self
        var numberWords = 0
        let text = "\(about_text_1)\(paulin_web)<br>\(paulin_email)\(about_text_2)\(phracek_email)\(about_text_3)\(paulin_god_road)</p>"
        aboutLabel.setText(generateContent(text: text))
        aboutLabel.addLink(to: URL(string: paulin_web), with: NSRange(location: about_text_1.count - 30, length: paulin_web.count))
        numberWords += about_text_1.count - 30 + paulin_web.count + 1
        aboutLabel.addLink(to: URL(string: paulin_email), with: NSRange(location: numberWords, length: paulin_email.count))
        numberWords += paulin_email.count + about_text_2.count - 16
        aboutLabel.addLink(to: URL(string: phracek_email), with: NSRange(location: numberWords, length: phracek_email.count))
        numberWords += phracek_email.count + about_text_3.count - 20
        aboutLabel.addLink(to: URL(string: paulin_god_road), with: NSRange(location: numberWords, length: paulin_god_road.count + 1))

        navigationController?.navigationBar.barStyle = UIBarStyle.black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        self.darkMode = userDefaults.bool(forKey: "NightSwitch")
        if self.darkMode == true {
            self.back = UIColor.WithGodOnRoad.backNightColor()
            self.text = UIColor.WithGodOnRoad.textNightColor()
        }
        else {
            self.back = UIColor.WithGodOnRoad.backLightColor()
            self.text = UIColor.WithGodOnRoad.textLightColor()
        }
        refresh_ui()
    }
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        UIApplication.shared.open(url)
    }
    
    func refresh_ui() {
        self.view.backgroundColor = self.back
        self.aboutLabel.backgroundColor = self.back
        self.aboutLabel.textColor = self.text
        self.contentView.backgroundColor = self.back
        self.scrollView.backgroundColor = self.back
        self.innerContentView.backgroundColor = self.back
    }
}
