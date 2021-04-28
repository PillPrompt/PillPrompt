//
//  EditMedicationViewController.swift
//  PillPrompt
//
//  Created by Evan Dilger on 4/26/21.
//

import UIKit
import Parse



class EditMedicationViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var freqencyField: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var sundaySwith: UISwitch!
    @IBOutlet weak var mondaySwitch: UISwitch!
    @IBOutlet weak var tuesdaySwitch: UISwitch!
    @IBOutlet weak var wednesdaySwitch: UISwitch!
    @IBOutlet weak var thursdaySwitch: UISwitch!
    @IBOutlet weak var fridaySwitch: UISwitch!
    @IBOutlet weak var saturdaySwitch: UISwitch!
    
    var meds = [PFObject]()
    var objectID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 5
        stepper.minimumValue = 0

        objectID = UserDefaults.standard.string(forKey: "selectedMed")!
        print(objectID)
        
        let medication = MedicationViewController.Medication.selectedMedication[0]
        print(medication)
        
        nameField.text = medication["name"]! as! String
        let frequency = medication["frequency"]
        freqencyField.text = frequency as! String
        stepper.value = 0
        
        let days = medication["days"]! as! String
        
        if days.contains("U") != true {
            sundaySwith.setOn(false, animated:true)
        }
        if days.contains("M") != true {
            mondaySwitch.setOn(false, animated:true)
        }
        if days.contains("T") != true {
            tuesdaySwitch.setOn(false, animated:true)
        }
        if days.contains("W") != true {
            wednesdaySwitch.setOn(false, animated:true)
        }
        if days.contains("R") != true {
            thursdaySwitch.setOn(false, animated:true)
        }
        if days.contains("F") != true {
            fridaySwitch.setOn(false, animated:true)
        }
        if days.contains("S") != true {
            saturdaySwitch.setOn(false, animated:true)
        }
        
        
        
//        let query = PFQuery(className: "Medication")
//        query.includeKeys(["author", "objectId"])
//
//        //print("ObjectId: \(PFUser.current()!.objectId!)")
//        query.whereKey("author", equalTo: PFUser.current()!)
//
//        query.findObjectsInBackground { (medications, error) in
//            if medications != nil {
//                self.meds = medications!
//            }
//        }
//
//        var index = 0
//        for med in meds {
//            if med.objectId! == objectID {
//                break
//            } else {
//                index += 1
//            }
//        }
//
//        if index >= meds.count {
//            print("out of range")
//        }
//        else {
//            let medication = meds[index]
//            nameField.text = medication["name"] as! String
//            freqencyField.text = medication["frequency"] as! String
//        }
//
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSubmit(_ sender: Any) {
    
        let medication = MedicationViewController.Medication.selectedMedication[0]

        // Check which days are toggled
        var days = ""
        if sundaySwith.isOn {
            days += "U:"
        }
        if mondaySwitch.isOn {
            days += "M:"
        }
        if tuesdaySwitch.isOn {
            days += "T:"
        }
        if wednesdaySwitch.isOn {
            days += "W:"
        }
        if thursdaySwitch.isOn {
            days += "R:"
        }
        if fridaySwitch.isOn {
            days += "F:"
        }
        if saturdaySwitch.isOn {
            days += "S:"
        }

        medication.setValue(nameField.text!, forKey: "name")
        medication.setValue(freqencyField.text!, forKey: "frequency")
        medication.setValue(days.dropLast(), forKey: "days")

        medication.saveInBackground { (success, error) in
            if success{
                print("medication updated")
                MedicationViewController.Medication.selectedMedication.removeAll()
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error updating medication: \(error)")
            }
        }
        
        
        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        freqencyField.text = Int(sender.value).description
    }
    
    
    @IBAction func onDelete(_ sender: Any) {
        let medication = MedicationViewController.Medication.selectedMedication[0]
    
        medication.deleteInBackground { (success, error) in
            if success{
                print("medication deleted")
                MedicationViewController.Medication.selectedMedication.removeAll()
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error removing medication: \(error)")
            }
        }
    }
    
    @IBAction func onCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
