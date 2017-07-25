//
//  ViewController.swift
//  MapKitDemo
//
//  Created by laxman penmeta on 7/25/17.
//  Copyright © 2017 laxman penmeta. All rights reserved.
//

import UIKit
import MapKit
import  CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let locationManagr = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagr.delegate = self
        locationManagr.desiredAccuracy =  kCLLocationAccuracyBest
        locationManagr.requestWhenInUseAuthorization()
        locationManagr.startUpdatingLocation()
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        
        
        // Do any additional setup after loading the view, typically from a nib.
//        let myLoc = CLLocationCoordinate2D()
//        mapView.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(40.741895, -73.989308), 2000, 2000), animated: true)
        
//        let myLocAnnot = myLocAnnotation(title: "Title", subTitle: "SubTitle", coordinate: myLoc )
//        mapView.addAnnotation(myLocAnnot)
        
        self.fethcBankLocationsNearby()
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
//        let span = MKCoordinateSpanMake(0.1, 0.1)
        let mylocation = CLLocationCoordinate2DMake(location.coordinate.latitude,  location.coordinate.longitude)
//        let myRegion: MKCoordinateRegion = MKCoordinateRegionMake(mylocation, )
//        self.mapView.setRegion(myRegion, animated: true)
    }
    
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func fethcBankLocationsNearby()  {
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/place/textsearch/json?query=BBVA+Compass&location=MY_LAT,MY_LONG&radius=10000&key=AIzaSyA4jSuT-9CwCiBDtQON4ijLpL4RvU-lK5A") else {return}

        let request =  URLRequest(url:url)
        
        let session =  URLSession.shared
        session.dataTask(with: request){(data, response, error) in
            if let response =  response{
//               
                print("response = \(response)")
            }
            
            if let data = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                    if let results = json["results"] as AnyObject?{
                        print( results)
                        if let address = results[0] as AnyObject?{
                            print(address)
                            if let title = address["formatted_address"] as AnyObject?{
                                 print(title)
                                if let geometry = address["geometry"] as AnyObject?{
                                    print(geometry)
                                    if let location = geometry["location"] as AnyObject?{
                                        print(location)
                                        if let lat = location["lat"] as AnyObject?{
                                            print(lat)
                                    }
                                }
                            }
                        }
                    }
                }
                }catch{
                    print(error)
                }
            }
            
            }.resume()

        
    }

}

