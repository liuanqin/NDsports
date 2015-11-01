//
//  ComposeViewController.swift
//  Jason_mini
//
//  Created by Anqing Liu on 10/27/15.
//  Copyright © 2015 Anqing Liu. All rights reserved.
//

import Parse
import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var sweetTextView: UITextView!
    
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBOutlet weak var locationTextField: UITextField!
   
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var selectedData: UILabel!
    @IBOutlet weak var myDataPicker: UIDatePicker!
 
    @IBAction func dataPickerAction(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var strDate = dateFormatter.stringFromDate(myDataPicker.date)
        self.selectedData.hidden=false
        self.selectedData.text = strDate
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func sendAction(sender: AnyObject) {
        print(Int(hintLabel.text!))
        if (Int(hintLabel.text!) != 140){
        var send:PFObject = PFObject(className: "Send")
        send["contents"] = sweetTextView.text
        send["author"] = PFUser.currentUser()
        
        send.saveInBackground()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        }
        else{
            
            let alertController = UIAlertController(title: "Error", message:
                "Please write an activity!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pickerView.delegate = self
        pickerView.dataSource = self;
        
        locationTextField.inputView = pickerView
        locationTextField.text = pickOption[0]
        self.selectedData.hidden=true
        locationTextField.hidden = true
        
        sweetTextView.layer.borderColor = UIColor.blackColor().CGColor
        sweetTextView.layer.borderWidth = 0.5
        sweetTextView.delegate = self
        sweetTextView.becomeFirstResponder()
    }
    
    
    
    // deal with picker view (location)
    var pickOption = ["Rolfs", "Rockne", "test", "seven", "fifteen"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
            //color the label's background
            let hue = CGFloat(row)/CGFloat(pickOption.count)
            pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        let titleData = pickOption[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .Center
        
        return pickerLabel
        
    }
   
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        locationTextField.hidden = false
        locationTextField.text = pickOption[row]
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
