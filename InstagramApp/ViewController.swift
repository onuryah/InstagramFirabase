//
//  ViewController.swift
//  InstagramApp
//
//  Created by Ceren Çapar on 7.10.2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
        }
    }
    @IBAction func signInButtonClicked(_ sender: Any) {
        if usernameTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil {
                    self.makeAllert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
            
        }else {
        makeAllert(titleInput: "Error!", messageInput: "Username/Password?")
        }
    }
    
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        
        if usernameTextField.text != "" && passwordTextField.text != "" {
            
            
            Auth.auth().createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!) { authdata, error in
                if error != nil {
                    self.makeAllert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }}
            
            
        }else {
            makeAllert(titleInput: "Error!", messageInput: "Username/Password?")
        }}
    
    
    func makeAllert(titleInput : String, messageInput : String ) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)

    }
    

}

