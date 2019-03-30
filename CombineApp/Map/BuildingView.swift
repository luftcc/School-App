

import Foundation
import MapKit


@available(iOS 11.0, *)
class BuildingView: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let building = newValue as? Building else { return }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero,
                                                    size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControlState())
            rightCalloutAccessoryView = mapsButton
            // 2
            markerTintColor = building.markerTintColor
            glyphText = String(building.discipline.first!)
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 0
            detailLabel.font = detailLabel.font.withSize(12)
            detailLabel.text = building.subtitle
            detailCalloutAccessoryView = detailLabel
        }
    }
}
