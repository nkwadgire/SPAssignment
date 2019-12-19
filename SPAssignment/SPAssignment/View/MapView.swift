//
/**
*  * *****************************************************************************
*  * Filename: MapView.swift                                                     *
*  * Author  : Nagraj Wadgire                                                    *
*  * Creation Date: 19/12/19                                                     *
*  * *
*  * *****************************************************************************
*  * Description:                                                                *
*  * MapView will be display the PSI values on the map.                          *
*  *                                                                             *
*  * *****************************************************************************
*/

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var annotationPoints: [PSIAnnotation]
    
    func makeCoordinator() -> PSIAnnotationCoordinator {
        PSIAnnotationCoordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.34, longitudeDelta: 0.34)
        if !annotationPoints.isEmpty {
            let latitudeValue = annotationPoints[0].coordinate.latitude
            let longitudeValue = annotationPoints[0].coordinate.longitude
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue), span: span)
            view.setRegion(region, animated: true)
        }
        view.delegate = context.coordinator
        view.addAnnotations(annotationPoints)
    }
}
