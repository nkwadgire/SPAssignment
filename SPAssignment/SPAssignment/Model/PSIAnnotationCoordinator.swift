//
/**
*  * *****************************************************************************
*  * Filename: PSIAnnotationCoordinator.swift                                               *
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
          return annotationView
       }
}
