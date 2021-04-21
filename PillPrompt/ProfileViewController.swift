//
//  ProfileViewController.swift
//  PillPrompt
//
//  Created by Evan Dilger on 4/6/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogout(_ sender: Any) {
        
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let delegate = windowScene.delegate as? SceneDelegate
          else {
            return
        }
        
        delegate.window?.rootViewController = loginViewController
        
       // self.dismiss(animated: false, completion: nil)
        //self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
}
