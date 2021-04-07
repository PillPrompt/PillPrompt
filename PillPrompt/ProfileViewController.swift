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
        
        self.dismiss(animated: false, completion: nil)
        //self.performSegue(withIdentifier: "logoutSegue", sender: nil)

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
