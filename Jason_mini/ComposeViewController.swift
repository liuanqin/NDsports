//
//  ComposeViewController.swift
//  Jason_mini
//
//  Created by Anqing Liu on 10/27/15.
//  Copyright © 2015 Anqing Liu. All rights reserved.
//

import Parse
import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var sweetTextView: UITextView!
    
    @IBOutlet weak var hintLabel: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func sendAction(sender: AnyObject) {
        var send:PFObject = PFObject(className: "Send")
        send["contents"] = sweetTextView.text
        send["author"] = PFUser.currentUser()
        
        send.saveInBackground()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
    }
    

   override func viewDidLoad() {
        super.viewDidLoad()
        
        sweetTextView.layer.borderColor = UIColor.blackColor().CGColor
        sweetTextView.layer.borderWidth = 0.5
        sweetTextView.delegate = self
        sweetTextView.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView!,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String!) -> Bool{
            
            var newLength:Int = (textView.text as NSString).length + (text as NSString).length - range.length
            var remainingChar:Int = 140 - newLength
            
            hintLabel.text = "\(remainingChar)"
            
            return (newLength > 140) ? false : true
    }
    
    
}
