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
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.refreshControl = myRefreshControl
        myRefreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    
    @objc func reload() {
        viewDidAppear(true)
        self.myRefreshControl.endRefreshing()
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
        
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.weekday, from: date)
        var today = String()
        if (day == 1) {
            today = "U"
        }
        else if (day == 2) {
            today = "M"
        }
        else if (day == 3) {
            today = "T"
        }
        else if (day == 4) {
            today = "W"
        }
        else if (day == 5) {
            today = "R"
        }
        else if (day == 6) {
            today = "F"
        }
        else {
            today = "S"
        }
        
        let cell_days = med["days"]! as? String
        
        if (cell_days!.contains(today) == true) {
            cell.todayLabel.text = "Today"
            //print("\(cell_days) contains \(today)")
        } else {
            cell.todayLabel.text = ""
        }
        
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
