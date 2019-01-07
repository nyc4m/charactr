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
    @IBOutlet var l_reponse: UILabel!
    @IBOutlet var tv_signification: UITextView!
    @IBOutlet var tv_commentaire: UITextView!
    @IBOutlet var l_answer: UILabel!
    @IBOutlet var l_signification: UILabel!
    @IBOutlet var l_commentary: UILabel!
    
    private var centerConstraintDefault = CGFloat(0)
    private var menuIsHidden = true
    private var currentCardIsBack = false
    private let dbInstance: DbGetter = DbGetter.getInstance()
    private var currentSymbol: Symbol?
    private var isFlippable: Bool = true
    private var nbGoodAnswer: Int = 0
    private let NB_ANSWER_PER_LIST: Int = 10
    private var currentList : [Symbol]?
    
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
    private func nextCard(){
        if currentList == nil {
            var list = dbInstance.getAllSymbols()
            for _ in 0..<NB_ANSWER_PER_LIST{
                let rand = Int(arc4random_uniform(UInt32(NB_ANSWER_PER_LIST)))
                self.currentList?.append(list[rand])
                list.remove(at: rand)
            }
        }
        let symbols = dbInstance.getAllSymbols()
        let randomNumber = Int(arc4random_uniform(UInt32(symbols.count)))
        self.currentSymbol = dbInstance.getAllSymbols()[randomNumber]
    }
    @IBAction func OnValidate(_ sender: UIButton) {
        symbolValidationPhase(isValidatingTime: true)
        self.l_reponse.text = self.tf_answer.text
    }
    
    private func symbolValidationPhase( isValidatingTime: Bool){
        self.btn_validate.isHidden = isValidatingTime
        self.tf_answer.isHidden = isValidatingTime
        self.btn_tick.isHidden = !isValidatingTime
        self.btn_cross.isHidden = !isValidatingTime
        self.isFlippable = !isValidatingTime
        self.flipCard(self.btn_validate)
        self.tv_signification.isHidden = !isValidatingTime
        self.l_answer.isHidden = !isValidatingTime
        self.l_signification.isHidden = !isValidatingTime
        l_reponse.isHidden = !isValidatingTime
    }
    
    @IBAction func goodAnswer(_ sender: UIButton) {
        symbolValidationPhase(isValidatingTime: false)
        self.changeSymbol()
        self.tf_answer.text = ""
    }
    @IBAction func badAnswer(_ sender: UIButton) {
        symbolValidationPhase(isValidatingTime: false)
        self.changeSymbol()
        self.tf_answer.text = ""
    }
    private func changeSymbol(){
        self.nextCard()
        self.btn_front.setTitle(self.currentSymbol?.Symbol, for: .normal)
        self.tv_commentaire.text = self.currentSymbol?.Commentary
        self.tv_signification.text = self.currentSymbol?.Signification
    }
}

