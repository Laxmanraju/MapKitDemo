//
//  myLocAnnotation.swift
//  MapKitDemo
//
//  Created by laxman penmeta on 7/25/17.
//  Copyright © 2017 laxman penmeta. All rights reserved.
//

import MapKit

class myLocAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitlee: String?
    
    var mapPinDescription:String{
        return "\(self.title): \(self.subtitlee)"
    }
    
    init(title: String, subTitle: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.subtitlee = subTitle
        self.coordinate = coordinate
    }
}
