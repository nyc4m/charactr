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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorder(txtView: tv_signification)
        setBorder(txtView: tv_notePerso)
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

}
