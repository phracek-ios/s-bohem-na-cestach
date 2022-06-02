//
//  InfoViewController.swift
//  SBohemNaCestach
//
//  Created by Petr Hracek on 31.05.2022.
//  Copyright © 2022 Petr Hracek. All rights reserved.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {

    // MARK: - Properties
    
    lazy var imageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "title_photo")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView)
        self.view.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        self.view.rightAnchor.constraint(equalTo: imageView.rightAnchor).isActive = true
        self.view.leftAnchor.constraint(equalTo: imageView.leftAnchor).isActive = true
    }
}
