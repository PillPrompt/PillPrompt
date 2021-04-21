//
//  ProfileViewController.swift
//  PillPrompt
//
//  Created by Evan Dilger on 4/6/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    var users = [PFObject]()

    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var usename_label: UILabel!
    @IBOutlet weak var email_label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "User")
        query.includeKey("name")
       
        print("ObjectId: \(PFUser.current()!.objectId!)")
        //query.whereKey("author", equalTo: PFUser.current()!.objectId!)

//        query.findObjectsInBackground { (medications, error) in
//            if medications != nil {
//                self.meds = medications!
//                self.tableView.reloadData()
//            }
//        }
        
        
        query.whereKey("name", equalTo: "Tester1")
        query.findObjectsInBackground { (userDetails, error) in
            if userDetails != nil {
                
                self.users = userDetails!
                if (self.users.count != 0) {
                    // Continue loading more data:
                    let user = userDetails?[0]
                    self.name_label.text = user?["name"] as? String
                    self.email_label.text = user?["name"] as? String
                    self.usename_label.text = user?["name"] as? String
                }
                
                
                            }
            let user = PFUser.current();
            self.name_label.text = user?["name"] as! String
            self.email_label.text = user?.email
            self.usename_label.text = user?.username
            
            
        }

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
