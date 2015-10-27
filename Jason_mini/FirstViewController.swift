//
//  FirstViewController.swift
//  Jason_mini
//
//  Created by Anqing Liu on 9/4/15.
//  Copyright (c) 2015 Anqing Liu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var showButton: UISwitch!
    var passedvalue1: String = ""
    var passedvalue2: String = ""
    
    let service = "swiftLogin"
    let userAccount = "swiftLoginUser"
    let key = "RandomKey"

    
    let locationManager = CLLocationManager()
    
    @IBAction func showMap(sender: UISwitch) {
        if showButton.on{
            MapView.hidden = false

        }else{
            MapView.hidden = true
        }
    }
    
    //MapView.reloadinputview
    
/*    override func viewDidAppear(animated: Bool) {
        let (dictionary, error) = Locksmith.loadData(forKey: key, inService: service, forUserAccount: userAccount)
        
        if let dictionary = dictionary {
            // User is already logged in, Send them to already logged in view.
        } else {
            self.performSegueWithIdentifier("logInViewSegue", sender: self)

        }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        self.MapView.showsUserLocation = true
        
   
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print("You selected cell is #\(passedvalue1) and \(passedvalue2)")
        
        if passedvalue1==""{
        let center = CLLocationCoordinate2D(latitude: manager.location!.coordinate.latitude, longitude: manager.location!.coordinate.longitude)
            
             print("LOCATION: \(center.latitude) + \(center.longitude)")
            
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 4, longitudeDelta:4))
            
            self.MapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            self.MapView.addAnnotation(annotation)
        }else{
        let center = CLLocationCoordinate2D(latitude:NSString(string: passedvalue1).doubleValue, longitude: NSString(string: passedvalue2).doubleValue)
            
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 4, longitudeDelta:4))
            
            // println("LOCATION: \(center.latitude) + \(center.longitude)")
            
            self.MapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            self.MapView.addAnnotation(annotation)
        }
    
    
       // println("LOCATION: \(center.latitude) + \(center.longitude)")
        
        self.locationManager.stopUpdatingLocation()
    }
    
    
 
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription, terminator: "")
    }

}

