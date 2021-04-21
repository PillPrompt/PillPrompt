//
//  AddMedicationViewController.swift
//  PillPrompt
//
//  Created by Evan Dilger on 4/6/21.
//

import UIKit
import Parse

class AddMedicationViewController: UIViewController {
    
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
    
    @IBAction func onSubmit(_ sender: Any) {
        let medication = PFObject(className: "Medication")
    
        medication["author"] = PFUser.current()!
        medication["name"] = nameField.text!
        medication["frequency"] = freqencyField.text! as? String
        
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
        
        medication["days"] = days.dropLast()
        
        PFUser.current()!.add(medication, forKey: "medication")
        
        PFUser.current()!.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Error: \(error)")
            }
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        freqencyField.text = Int(sender.value).description
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stepper.value = 0
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 5
        stepper.minimumValue = 0
        
        sundaySwith.setOn(false, animated:true)
        mondaySwitch.setOn(false, animated:true)
        tuesdaySwitch.setOn(false, animated:true)
        wednesdaySwitch.setOn(false, animated:true)
        thursdaySwitch.setOn(false, animated:true)
        fridaySwitch.setOn(false, animated:true)
        saturdaySwitch.setOn(false, animated:true)
        // Do any additional setup after loading the view.
    }
}
