//
//  LogInViewController.swift
//  MessyApp
//
//  Created by Petre Vane on 15/09/2018.
//  Copyright © 2018 OrbSec. All rights reserved.
//
//  This is the view controller where users login


import UIKit
import Firebase


class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   
    @IBAction func logInPressed(_ sender: AnyObject) {
    
        //TODO: Log in the user
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil {
                print(error)
            } else {
                print ("signing in successful")
                self.performSegue(withIdentifier:"goToChat", sender: self)
            }
        }
        
        
    }
    


    
}  
