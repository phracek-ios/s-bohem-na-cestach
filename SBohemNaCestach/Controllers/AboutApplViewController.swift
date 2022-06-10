//
//  AboutApplViewController.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 08/11/2019.
//  Copyright © 2019 Petr Hracek. All rights reserved.
//

import UIKit
import BonMot
import WebKit
import FirebaseAnalytics

class AboutApplViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler  {
    
    lazy var aboutApplWebView: WKWebView = {
         let wview = WKWebView()
         wview.isOpaque = false
         return wview
     }()
    
    var darkMode: Bool = false
    var back: UIColor = .black
    var text: UIColor = .white
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let textSource = createSimpleHtml(input: NSLocalizedString("o_aplikaci_text", comment: ""))
        aboutApplWebView.loadHTMLString(textSource, baseURL: nil)
        aboutApplWebView.backgroundColor = self.back
        aboutApplWebView.tintColor = self.text
        self.view.addSubview(aboutApplWebView)
        self.view.backgroundColor = self.back
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: aboutApplWebView)
        view.addConstraintsWithFormat(format: "V:|-25-[v0]-15-|", views: aboutApplWebView)
        navigationController?.navigationBar.barTintColor = UIColor.WithGodOnRoad.titleColor()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
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
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard
            let url = navigationAction.request.url else {
                decisionHandler(.cancel)
                return
        }
        if navigationAction.navigationType == .linkActivated {
            print("link")
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else
            {
                UIApplication.shared.openURL(url)
            }
            decisionHandler(.cancel)
            return
        }
    }
    func createSimpleHtml(input: String) -> String {
        if self.darkMode {
            return "<html><body style='margin: 40px'>" +
                "<div style='color:#ffffff'><font size=20>" +
                input +
                "</font></div></body></html>";
        } else {
            return "<html><body style='margin: 40px'>" +
                "<div style='color:#000000'><font size=20>" +
                input +
                "</font></div></body></html>";
        }
    }
}
