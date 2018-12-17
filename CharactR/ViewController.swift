//
//  ViewController.swift
//  CharactR
//
//  Created by MADELINE ALEXANDRE on 12/12/2018.
//  Copyright © 2018 MADELINE ALEXANDRE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    private var menuIsHidden = true
    private let dbInstance: DbGetter = DbGetter.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.layer.shadowOpacity = 0.5
    }

    @IBAction func menuTap(_ sender: UIBarButtonItem) {
        self.toggleMenu()
    }
    private func toggleMenu(){
        if menuIsHidden{
            leadingConstraint.constant = 0
        }else{
            leadingConstraint.constant = -200
        }
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
        menuIsHidden = !menuIsHidden
    }
}

