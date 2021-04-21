//
//  MedicationViewController.swift
//  PillPrompt
//
//  Created by Evan Dilger on 4/6/21.
//

import UIKit
import Parse

class MedicationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UpdateDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    var meds = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("Count: \(meds.count)")
        return meds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicationCell") as! MedicationCell

        let med = meds[indexPath.row]
        
        cell.nameField.text = med["name"] as? String
        cell.daysField.text = med["days"] as? String
        cell.frequencyField.text = med["frequency"] as? String

        return cell
    }
    func update() {
        
    //        let medications = (PFUser.current()!["medication"] as? [PFObject]) ?? []
    //        self.meds = medications
    //        self.tableView.reloadData()
            
            let query = PFQuery(className: "Medication")
            query.includeKey("author")
           
            print("ObjectId: \(PFUser.current()!.objectId!)")
            //query.whereKey("author", equalTo: PFUser.current()!.objectId!)

    //        query.findObjectsInBackground { (medications, error) in
    //            if medications != nil {
    //                self.meds = medications!
    //                self.tableView.reloadData()
    //            }
    //        }
            
            
        query.whereKey("author", equalTo: PFUser.current() as! Any)
            query.findObjectsInBackground { (medications, error) in
                if medications != nil {
                    self.meds = medications!
                    self.tableView.reloadData()
                }
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue" {
            guard let addVC = segue.destination as? AddMedicationViewController else { return }
            addVC.updateDeleate = self
        }
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
