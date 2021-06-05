//
//  Center.swift
//  AnimalCompanionService
//
//  Created by kpugame on 2021/06/05.
//

import Foundation
import MapKit
import Contacts

class CenterClass: NSObject, MKAnnotation{
    let name: String?
    let addr: String?
    let coordinate: CLLocationCoordinate2D
    
    init(Cname: String, Caddr: String, coordinate:
            CLLocationCoordinate2D){
        self.name = Cname
        self.addr = Caddr
        self.coordinate = coordinate
        
        super.init()
    }

    var subtitle: String?{
        var s = name! + "\n" + addr!
        return s
    }

    func mapItem() -> MKMapItem{
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        return mapItem
    }
}
