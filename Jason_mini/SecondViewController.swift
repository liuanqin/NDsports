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
        ["Compton Ice Area","41.693804","-86.230840"],
        ["Eck Tennis Pavilion","41.700278","-86.226397"],
        ["Joyce Center","41.698512","-86.231294"],
        ["Lofts Sports Center","41.700812","-86.228028"],
        ["Notre Dame 9 Hole Golf Course","41.699529","-86.244424"],
        ["Rockne Memorial","41.700202","-86.244028"],
        ["Rolfs Aquatic Center","41.698544","-86.230272"],
        ["Rolfs Recreation Center","41.700193","-86.230462"],
        ["St. Joseph Beach","41.707258","-86.237534"],
        ["Stephen Soccer Field","41.707788","-86.233157"],
        ["Warren Golf Course","41.713157","-86.223698"]
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

