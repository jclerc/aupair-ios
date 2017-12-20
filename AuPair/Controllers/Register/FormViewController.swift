//
//  FormViewController.swift
//  AuPair
//
//  Created by Jonathan on 20/12/2017.
//  Copyright © 2017 Jonathan. All rights reserved.
//

import UIKit

//class TextFieldDelegate: NSObject, UITextFieldDelegate {
//
//    var method: (() -> Void)?
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        method?()
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        method?()
//        return false
//    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        method?()
//        return false
//    }
//
//    func didChangeValue<Value>(for keyPath: KeyPath<TextFieldDelegate, Value>) {
//        method?()
//    }
//}

class FormViewController: UIViewController {
    
    var fields: [UITextField]!
    var helper: FormViewHelper!
    
    func initForm(_ helper: FormViewHelper, _ fields: [UITextField]) {
        self.helper = helper
        self.fields = fields
//        let delegate = TextFieldDelegate()
//        delegate.method = updateNext

        for field in fields {
//            field.delegate = delegate
            field.addTarget(self, action: #selector(actionKeyboardButtonTapped(sender:)), for: .editingDidEnd)
        }
        updateNext()
    }
    
    @objc private func actionKeyboardButtonTapped(sender: UITextField) {
        print("mdr")
        updateNext()
    }
    
    func updateNext() {
        print("check")
        var valid = true
        
        for field in fields {
            if field.text?.count == 0 {
                valid = false
                break
            }
        }
        
        helper.updateSubmit(state: valid)
    }
    
}

//struct Fields {
//    var fields: [UITextField]
//    var button: UIButton?
//    var barButton: UIBarButtonItem?
//}

protocol FormViewHelper {
    func updateSubmit(state: Bool)
}
