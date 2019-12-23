//
/**
 *  * *****************************************************************************
 *  * Filename: PSIAnnotationCoordinator.swift                                    *
 *  * Author  : Nagraj Wadgire                                                    *
 *  * Creation Date: 19/12/19                                                     *
 *  * *
 *  * *****************************************************************************
 *  * Description:                                                                *
 *  * PSIAnnotationCoordinator will allow to place custom annotation view for     *
 *  * the map.                                                                    *
 *  *                                                                             *
 *  * *****************************************************************************
 */

import Foundation
import MapKit

class PSIAnnotationCoordinator: NSObject, MKMapViewDelegate {
    var mapView: MapView
    init(_ control: MapView) {
        self.mapView = control
    }
    
    func mapView(_ mapView: MKMapView, viewFor
        annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customAnnotationView")
        annotationView.canShowCallout = true
        annotationView.image = UIImage(named: "customAnnotation")
        annotationView.canShowCallout = true
        let psIndex = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        let reading = NSMutableAttributedString.getAttributedString(fromString: annotation.subtitle! ?? "")
        reading.apply(color: .lightGray, subString: "o3SubIndex")
        reading.apply(color: .lightGray, subString: "pm10TwentyFourHourly")
        reading.apply(color: .lightGray, subString: "pm10SubIndex")
        reading.apply(color: .lightGray, subString: "coSubIndex")
        reading.apply(color: .lightGray, subString: "pm25TwentyFourHourly")
        reading.apply(color: .lightGray, subString: "so2SubIndex")
        reading.apply(color: .lightGray, subString: "coEightHourMax")
        reading.apply(color: .lightGray, subString: "no2OneHourMax")
        reading.apply(color: .lightGray, subString: "so2TwentyFourHourly")
        reading.apply(color: .lightGray, subString: "pm25SubIndex")
        reading.apply(color: .lightGray, subString: "psiTwentyFourHourly")
        reading.apply(color: .lightGray, subString: "o3EightHourMax")
        
        psIndex.attributedText = reading
        psIndex.numberOfLines = 0
        annotationView.detailCalloutAccessoryView = psIndex
        
        let attribute = NSLayoutConstraint.Attribute.width
        let relation = NSLayoutConstraint.Relation.lessThanOrEqual
        let notAttribute = NSLayoutConstraint.Attribute.notAnAttribute
        let width = NSLayoutConstraint(item: psIndex, attribute: attribute, relatedBy: relation, toItem: nil, attribute: notAttribute, multiplier: 1, constant: 280)
        psIndex.addConstraint(width)
        
        let heightAttributeValue = NSLayoutConstraint.Attribute.height
        let heightRelation = NSLayoutConstraint.Relation.equal
        let height = NSLayoutConstraint(item: psIndex, attribute:heightAttributeValue , relatedBy: heightRelation, toItem: nil, attribute: notAttribute, multiplier: 1, constant: 300)
        psIndex.addConstraint(height)
         return annotationView
    }
    
}
