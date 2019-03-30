

import Foundation
import MapKit
import Contacts

class Building: NSObject,MKAnnotation{
    var title: String?
    var discipline: String
    var locationName: String
    var coordinate: CLLocationCoordinate2D
    
    var markerTintColor: UIColor  {
        switch discipline {
        case "教学楼":
            return .red
        case "宿舍":
            return .cyan
        case "院系楼":
            return .blue
        default:
            return .green
        }
    }
    
    init(title: String, discipline: String, locationName: String,coordinate: CLLocationCoordinate2D){
        self.title = title
        self.discipline = discipline
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String?{
        return locationName
    }
    
    func mapItem() -> MKMapItem{
        let addressDict = [CNPostalAddressStreetKey: subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
        
    }
    
    init?(json: [Any]) {
        // 1
        self.title = json[0] as? String ?? "No Title"
        self.locationName = json[2] as! String
        self.discipline = json[1] as! String
        // 2
        if let latitude = Double(json[4] as! String),
            let longitude = Double(json[3] as! String) {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
    }
}
