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
    @IBOutlet var btn_validate: UIButton!
    @IBOutlet var tf_answer: UITextField!
    @IBOutlet var btn_tick: UIButton!
    @IBOutlet var btn_cross: UIButton!
    
    private var centerConstraintDefault = CGFloat(0)
    private var menuIsHidden = true
    private var currentCardIsBack = false
    private let dbInstance: DbGetter = DbGetter.getInstance()
    private var currentSymbol: Symbol?
    private var isFlippable: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuView.layer.shadowOpacity = 0.5
        self.changeSymbol()
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
        if isFlippable || !currentCardIsBack{
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
        
    }
    private func randomCard(){
        let symbols = dbInstance.getAllSymbols()
        let randomNumber = Int(arc4random_uniform(UInt32(symbols.count)))
        self.currentSymbol = dbInstance.getAllSymbols()[randomNumber]
    }
    @IBAction func OnValidate(_ sender: UIButton) {
        symbolValidationPhase(isValidatingTime: true)
        
    }
    
    private func symbolValidationPhase( isValidatingTime: Bool){
        self.btn_validate.isHidden = isValidatingTime
        self.tf_answer.isHidden = isValidatingTime
        self.btn_tick.isHidden = !isValidatingTime
        self.btn_cross.isHidden = !isValidatingTime
        self.isFlippable = !isValidatingTime
        self.flipCard(self.btn_validate)
        
    }
    
    @IBAction func goodAnswer(_ sender: UIButton) {
        symbolValidationPhase(isValidatingTime: false)
        self.changeSymbol()
    }
    @IBAction func badAnswer(_ sender: UIButton) {
        symbolValidationPhase(isValidatingTime: false)
        self.changeSymbol()
    }
    private func changeSymbol(){
        self.randomCard()
        self.btn_front.setTitle(self.currentSymbol?.Symbol, for: .normal)
    }
}

