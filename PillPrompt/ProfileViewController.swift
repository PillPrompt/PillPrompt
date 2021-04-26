//
//  ProfileViewController.swift
//  PillPrompt
//
//  Created by Evan Dilger on 4/6/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = PFUser.current()!.username!
        emailLabel.text = PFUser.current()!.email!
        
        let user = PFUser.current()!
        nameLabel.text = user["name"] as! String

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        usernameLabel.text = PFUser.current()!.username!
        emailLabel.text = PFUser.current()!.email!
        
        let user = PFUser.current()!
        nameLabel.text = user["name"] as! String
    }
        
    
    @IBAction func onLogout(_ sender: Any) {
        
        PFUser.logOut()
        
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
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
