//
//  ViewController.swift
//  CharactR
//
//  Created by MADELINE ALEXANDRE on 12/12/2018.
//  Copyright © 2018 MADELINE ALEXANDRE. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var btn_back: UIButton!
    @IBOutlet var btn_front: UIButton!
    @IBOutlet var card: UIView!
    @IBOutlet var frontCard: UIView!
    @IBOutlet var backCard: UIView!
    @IBOutlet var centerConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    private var centerConstraintDefault = CGFloat(0)
    private var menuIsHidden = true
    private var currentCardIsBack = false
    private let dbInstance: DbGetter = DbGetter.getInstance()
    private var currentSymbol: Symbol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.layer.shadowOpacity = 0.5
        self.randomCard()
    }
    
    @IBAction func reinitDB(_ sender: UIButton) {
        DbGetter.getInstance().reinitTable()
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
        UIView.transition(with: fromView, duration: 1.0, options: [.transitionFlipFromRight, .showHideTransitionViews], animations: {
            fromView.isHidden = true
        })
        
        UIView.transition(with: toView, duration: 1.0, options: [.transitionFlipFromRight, .showHideTransitionViews], animations: {
            toView.isHidden = false
        })
        currentCardIsBack = !currentCardIsBack
    }
    private func randomCard(){
        let symbols = dbInstance.getAllSymbols()
        let randomNumber = Int(arc4random_uniform(UInt32(symbols.count)))
        self.currentSymbol = dbInstance.getAllSymbols()[randomNumber]
    }
}

