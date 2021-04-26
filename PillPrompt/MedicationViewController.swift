//
//  MedicationViewController.swift
//  PillPrompt
//
//  Created by Evan Dilger on 4/6/21.
//

import UIKit
import Parse

class MedicationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

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
        Medication.selectedMedication.removeAll()
        
    
//        let medications = (PFUser.current()!["medication"] as? [PFObject]) ?? []
//        self.meds = medications
//        self.tableView.reloadData()
        
        let query = PFQuery(className: "Medication")
        query.includeKeys(["author", "objectId"])
       
        //print("ObjectId: \(PFUser.current()!.objectId!)")
        query.whereKey("author", equalTo: PFUser.current()!)

        query.findObjectsInBackground { (medications, error) in
            if medications != nil {
                self.meds = medications!
                self.tableView.reloadData()
            }
        }
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //performSegue(withIdentifier: "showMedication", sender: self)
        let med = meds[indexPath.row]
        //print(med.objectId)
        UserDefaults.standard.setValue(med.objectId!, forKey: "selectedMed")
        Medication.selectedMedication.removeAll()
        Medication.selectedMedication.append(med)
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showMedication", sender: self)
    }
    
    struct Medication {
        static var selectedMedication = [PFObject]()
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
