//
//  SecondViewController.swift
//  Jason_mini
//
//  Created by Anqing Liu on 9/4/15.
//  Copyright (c) 2015 Anqing Liu. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    let city = [
        ["Paris","48.85341","2.3488"],
        ["Beijing","39.9075","116.39723"],
        ["Chicago","41.85003","-87.65005"],
        ["Sydney","-33.865143","151.2099"],
        ["Tokyo","35.6895","139.69171"],
        ["London","51.50853","-0.12574"],
        ["Berlin","52.52437","13.41053"],
        ["Budapest","47.49801","19.03991"],
        ["Rio","-22.90278"," -43.2075"],
        ["South Bend","41.679929","-86.249806"]
    ]
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }
    var valueToPass1 :String = ""
    var valueToPass2 :String = ""
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text=city[indexPath.row][0]
        return cell
    }
    
 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            // Get Cell Label
            let indexPath = tableView.indexPathForSelectedRow;
            let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!;
        
         valueToPass1 = city[indexPath!.row][1]
         valueToPass2 = city[indexPath!.row][2]
         //println("You selected cell #\(valueToPass2)!")
         performSegueWithIdentifier("Details", sender: self)
            
      
    }

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cities"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "Details"{
            let destination = segue.destinationViewController as! FirstViewController
      
            destination.passedvalue1=valueToPass1
            destination.passedvalue2=valueToPass2
             print("You selected cell #\(destination.passedvalue1)!")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

