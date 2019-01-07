//
//  LoginViewController.swift
//  CharactR
//
//  Created by MADELINE ALEXANDRE on 07/01/2019.
//  Copyright © 2019 MADELINE ALEXANDRE. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    private let dbInstance: DbGetter = DbGetter.getInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        
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

}
