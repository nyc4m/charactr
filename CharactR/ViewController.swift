//
//  ViewController.swift
//  CharactR
//
//  Created by MADELINE ALEXANDRE on 12/12/2018.
//  Copyright © 2018 MADELINE ALEXANDRE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var frontCard: UIView!
    @IBOutlet var backCard: UIView!
    @IBOutlet var centerConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    private var centerConstraintDefault = CGFloat(0)
    private var menuIsHidden = true
    private var currentCardIsBack = false
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
            centerConstraint.isActive = false
        }else{
            leadingConstraint.constant = -200
            centerConstraint.isActive = true

        }
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
        menuIsHidden = !menuIsHidden
    }
    @IBAction func flipCard(_ sender: UIButton) {
        let toView = currentCardIsBack ? frontCard! : backCard!
        let fromView = currentCardIsBack ? backCard! : frontCard!
        
        UIView.transition(from: fromView, to: toView, duration: 1, options: .transitionFlipFromRight, animation:completion: nil)
        currentCardIsBack = !currentCardIsBack
        
        
    }
    
}

