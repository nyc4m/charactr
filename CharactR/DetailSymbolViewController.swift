//
//  DetailSymbolViewController.swift
//  CharactR
//
//  Created by MADELINE ALEXANDRE on 19/12/2018.
//  Copyright © 2018 MADELINE ALEXANDRE. All rights reserved.
//

import UIKit

class DetailSymbolViewController: UIViewController {

    @IBOutlet weak var tv_signification: UITextView!
    @IBOutlet weak var tv_notePerso: UITextView!
    @IBOutlet weak var tv_symbol: UITextField!
    
    var symbol, signification, commentary: String?
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorder(txtView: tv_signification)
        setBorder(txtView: tv_notePerso)
        
        //Le commentaire risque d'être nul (on est pas obligé d'en mettre un)
        //donc on vérifie qu'il n'est pas nil, le cas échéant on ne l'affiche pas
        if let note_perso_unwrapped = commentary{
            tv_notePerso.text = note_perso_unwrapped
        }
        tv_symbol.text = symbol!
        tv_signification.text = signification!
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func setBorder(txtView: UITextView){
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        txtView.layer.borderWidth = 0.5
        txtView.layer.borderColor = borderColor.cgColor
        txtView.layer.cornerRadius = 5.0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func updateDatas(_ sender: UIButton) {
        self.symbol = self.tv_symbol.text
        self.signification = self.tv_signification.text
        self.commentary = self.tv_notePerso.text
        let done = DbGetter.getInstance().updateSymbol(s: Symbol(id: self.id!,symbol: self.symbol!, signification: self.signification!, commentary: self.commentary!))
        if(done){
            navigationController?.popToRootViewController(animated: true)
        }
    }
    

}
