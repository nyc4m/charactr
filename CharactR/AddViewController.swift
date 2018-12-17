//
//  AddViewController.swift
//  CharactR
//
//  Created by PRUNOT BAPTISTE on 17/12/2018.
//  Copyright © 2018 MADELINE ALEXANDRE. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var txt_symbol: UITextField!
    @IBOutlet weak var txt_meaning: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onValidate(_ sender: UIButton) {
        let symbol = Symbol(symbol: txt_symbol.text!, signification: txt_symbol.text!, commentary: "")
        
        DbGetter.getInstance().insertSymbol(s: symbol)
        print("salut")
}
}
