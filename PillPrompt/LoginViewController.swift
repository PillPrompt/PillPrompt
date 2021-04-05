//
//  LoginViewController.swift
//  PillPrompt
//
//  Created by Evan Dilger on 4/5/21.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var wrongUsernameLabel: UILabel!
    
    
    @IBAction func onSignIn(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.wrongUsernameLabel.text = ""
                self.usernameTextField.text = nil
                self.passwordTextField.text = nil
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
                self.wrongUsernameLabel.text = "incorrect username or password"
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wrongUsernameLabel.text = ""

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        // Do any additional setup after loading the view.
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
