//
//  EditProfileViewController.swift
//  PillPrompt
//
//  Created by Evan Dilger on 4/26/21.
//

import UIKit
import Parse

class EditProfileViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBAction func onSubmit(_ sender: Any) {
        
        let user = PFUser.current()!
        user.setValue(nameField.text!, forKey: "name")
        user.setValue(usernameField.text!, forKey: "username")
        user.setValue(emailField.text!, forKey: "email")
        user.saveInBackground { (success, error) in
            if success{
                print("profile updated")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error updating profile: \(error)")
            }
        }
        
    }
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameField.text = PFUser.current()!.username!
        emailField.text = PFUser.current()!.email!
        
        let user = PFUser.current()!
        nameField.text = user["name"] as! String
        // Do any additional setup after loading the view.
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
