//
//  RegisterAuPair1Controller.swift
//  AuPair
//
//  Created by Jonathan on 19/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit
import DatePickerDialog
import NextResponderTextField

class RegisterAuPair1Controller: FormViewController, UITextFieldDelegate, FormViewHelper {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var birthdateField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    
    var dateFormatter: DateFormatter!
    var selectedDate: Date? = Date()
    var pickerOpened = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initForm(self, [emailField, passwordField, confirmField, firstnameField, lastnameField, birthdateField, countryField])
        
        // Set date formatter
        dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale.current
        
        // To open picker
        birthdateField.delegate = self
    }
    
    @IBAction func tryNext(_ sender: Any) {
        guard let email = emailField.text, email.count > 5 && email.contains("@") else {
            wrongField(message: "L'email est incorrect.", input: emailField)
            return
        }
        
        guard let password = passwordField.text, password.count > 5 else {
            wrongField(message: "Le mot de passe doit faire minimum 6 caractères.", input: passwordField)
            return
        }
        
        guard let confirm = confirmField.text, confirm == password else {
            wrongField(message: "La confirmation est différente du mot de passe.", input: confirmField)
            return
        }
        
        guard let firstname = firstnameField.text, firstname.count >= 3 else {
            wrongField(message: "Le prénom est incorrect.", input: firstnameField)
            return
        }
        
        guard let lastname = lastnameField.text, lastname.count >= 3 else {
            wrongField(message: "Le nom est incorrect.", input: lastnameField)
            return
        }
        
        guard let selectedDate = selectedDate else {
            wrongField(message: "Le date est incorrect.", input: birthdateField)
            return
        }
        
        guard let country = countryField.text, lastname.count >= 3 else {
            wrongField(message: "Le pays est incorrect.", input: countryField)
            return
        }
        
        if let view = storyboard?.instantiateViewController(withIdentifier: "RegisterAuPair2") as? RegisterAuPair2Controller {
            navigationController?.pushViewController(view, animated: true)
        }
    }
    
    func updateSubmit(state: Bool) {
        self.navigationItem.rightBarButtonItem?.isEnabled = state
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // Ensure keyboard is hidden
        textField.resignFirstResponder()
        
        if !pickerOpened {
            // 1 week max date
            let maximumDate = Calendar.current.date(byAdding: .year, value: -13, to: Date())
            let minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
            
            pickerOpened = true
            DatePickerDialog().show("Date", doneButtonTitle: "Valider", cancelButtonTitle: "Annuler", minimumDate: minimumDate, maximumDate: maximumDate, datePickerMode: .date) {
                (date) -> Void in
                
                self.pickerOpened = false
                self.selectedDate = date
                if let date = date {
                    textField.text = self.dateFormatter.string(from: date).localizedCapitalized
                }
                
                self.updateNext()
                
                if let textField = textField as? NextResponderTextField {
                    textField.nextResponderField?.becomeFirstResponder()
                }
            }
        }
        
        return false
    }
    
    private func wrongField(message: String, input: UITextField) {
        let alert = UIAlertController(title: "Champ incorrect", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            (result : UIAlertAction) -> Void in input.becomeFirstResponder()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        input.becomeFirstResponder()
    }
    
}
