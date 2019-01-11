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
    private let loginValidateSegue = "LoginFound"
    private let createAccountSegue = "createAccountSegue"
    private var isConnected = false
    @IBOutlet var l_error: UILabel!
    @IBOutlet var tv_username: UITextField!
    @IBOutlet var tv_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        let username: String = tv_username.text!
        let password: String = tv_password.text!
        if dbInstance.askForConnexion(username: username, password: password){
            l_error.text = ""
            isConnected = true
            performSegue(withIdentifier: loginValidateSegue, sender: nil)

        }else{
            l_error.text = "Nom d'utilisateur ou mot de passe inconnu"
        }
        
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return ((identifier == loginValidateSegue && isConnected) || identifier == createAccountSegue) ? true : false

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
