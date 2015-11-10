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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    @IBOutlet weak var sweetTextView: UITextView!
    
    @IBOutlet weak var hintLabel: UILabel!
    
   
    @IBOutlet weak var pickerView1: UIPickerView!
    
    @IBOutlet weak var sportsView: UIPickerView!
    @IBOutlet weak var selectedData: UILabel!
    @IBOutlet weak var myDataPicker: UIDatePicker!
 
    var picklabel1 = ""
    var picklabel2 = ""
    
    @IBAction func dataPickerAction(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        var strDate = dateFormatter.stringFromDate(myDataPicker.date)
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
        send["votes"] = 0
        send["location"] = picklabel1
        send["sports"] = picklabel2
        
            
            
        
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
        
        
        pickerView1.delegate = self
        pickerView1.dataSource = self
        sportsView.delegate=self
        sportsView.dataSource=self
        
        if (PFUser.currentUser() == nil){
            var loginAlert:UIAlertController = UIAlertController(title:"Login", message: "Please Log In", preferredStyle: UIAlertControllerStyle.Alert)
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Your username"
            })
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Your password"
                textfield.secureTextEntry = true
            })
            
            loginAlert.addAction(UIAlertAction(title: "login", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                let textFields:NSArray = loginAlert.textFields! as NSArray
                let usernameTextField:UITextField = textFields.objectAtIndex(0) as! UITextField
                let passwordTextField:UITextField = textFields.objectAtIndex(1) as! UITextField
                
                PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!)
                    {(user: PFUser?, error: NSError?) -> Void in
                        if ((user) != nil) {
                            print("Login Successfully")
                        }else{
                            print("Login Failed, Please try again!")
                        }
                }
            }))
            loginAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
                
                loginAlert .dismissViewControllerAnimated(true, completion: nil)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("postNavigationController") as! UINavigationController
                    self.presentViewController(viewController, animated: true, completion: nil)})
            }))
            
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }
        
  
   
        //self.selectedData.hidden=true
        
        sweetTextView.layer.borderColor = UIColor.blackColor().CGColor
        sweetTextView.layer.borderWidth = 0.5
        sweetTextView.delegate = self
        sweetTextView.becomeFirstResponder()
    }
    
    
    
    // deal with picker view (location)
    var wheelContents:[[String]] = []
    var pickOption = [ "Compton Ice Area","Eck Tennis Pavilion","Joyce Center","Lofts Sports Center","Notre Dame 9 Hole Golf Course","Rockne Memorial","Rolfs Aquatic Center","Rolfs Recreation Center","St. Joseph Beach","Stephen Soccer Field","Warren Golf Course","Others, please state"]
    var sportsOption = ["Badminton", "Basketball","Cycling","Dancing","Football","Golf","Hockey","Racquetball","Rock Climbing","Rowing","Running","Soccer","Swimming","Table Tennis","Tennis","Volleyball","Weightlifting","Others, please state"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == pickerView1){
            return pickOption.count}
        else if (pickerView == sportsView){
            return sportsOption.count}
        return 1
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == pickerView1){
            return pickOption[row]}
        else if (pickerView == sportsView){
            return sportsOption[row]}
        return ""
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        if (pickerView == pickerView1){
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
            //color the label's background
            let hue = CGFloat(row)/CGFloat(pickOption.count)
            pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
            let titleData = pickOption[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 10.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .Center
        picklabel1 = pickerLabel.text!
        return pickerLabel
        }
        else {
            var pickerLabel1 = view as! UILabel!
            if view == nil {  //if no label there yet
                pickerLabel1 = UILabel()
                //color the label's background
                let hue = CGFloat(row)/CGFloat(sportsOption.count)
                pickerLabel1.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            }
            let titleData = sportsOption[row]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 10.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
            pickerLabel1!.attributedText = myTitle
            pickerLabel1!.textAlignment = .Center
            picklabel2 = pickerLabel1.text!
            return pickerLabel1
        
            
        }
        
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
