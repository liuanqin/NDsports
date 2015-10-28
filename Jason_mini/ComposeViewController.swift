//
//  ComposeViewController.swift
//  Jason_mini
//
//  Created by Anqing Liu on 10/27/15.
//  Copyright © 2015 Anqing Liu. All rights reserved.
//

import Parse

class ComposeViewController: UIViewController {

    @IBOutlet weak var writeTextView: UITextView!
    
    @IBOutlet weak var hintLabel: UILabel!
    
    
    
    @IBAction func sendAction(sender: AnyObject) {
        var send:PFObject = PFObject(className: "Send")
        send["contents"] = writeTextView.text
        send["sweeter"] = PFUser.currentUser()
        
        send.saveInBackground()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
    }
    

   override func viewDidLoad() {
        super.viewDidLoad()
        
        writeTextView.layer.borderColor = UIColor.blackColor().CGColor
        writeTextView.layer.borderWidth = 0.5
        writeTextView.becomeFirstResponder()
    }
    
    
}
