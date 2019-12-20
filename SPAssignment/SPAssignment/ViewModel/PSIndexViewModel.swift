//
/**
 *  * *****************************************************************************
 *  * Filename: PSIndexViewModel.swift                                            *
 *  * Author  : Nagraj Wadgire                                                    *
 *  * Creation Date: 19/12/19                                                     *
 *  * *
 *  * *****************************************************************************
 *  * Description:                                                                *
 *  * PSIndexViewModel will fetch the PSI vaules from webservice call and notify  *
 *  * the view                                                                    *
 *  *                                                                             *
 *  * *****************************************************************************
 */

import Foundation
import SwiftUI
import Combine
import MapKit

class PSIndexViewModel: ObservableObject {
    private var cancellable: AnyCancellable?
    init() {
        if #available(iOS 13.0, *) {
            fetchPSIndexValues()
        } else {
            getPSIndexValues()
        }
    }
    
    var annotations = [PSIAnnotation]() {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send(self)
            }
        }
    }
    
    /**
     Returns the array of PSIAnnotation objects. These annotation points will be drawn using mapView
     
     @param regionMetaData the array of PSIRegionMetaData objects which is received as webservice reponse
     */
    func getAnnotations(regionMetaData: [PSIRegionMetaData]) -> [PSIAnnotation] {
        var annotationArray = [PSIAnnotation]()
        for annotation in regionMetaData {
            let latitudeValue = annotation.location?.psiLatitude ?? 0.0
            let longitudeValue = annotation.location?.psiLongitude ?? 0.0
            let coordinate = CLLocationCoordinate2D.init(latitude: latitudeValue, longitude: longitudeValue)
            let annotation = PSIAnnotation(title: annotation.name, subtitle: annotation.name, coordinate: coordinate)
            annotationArray.append(annotation)
        }
        return annotationArray
    }
    
    /**
     This method retrieves the PSIndex values via GET service call. This method is calling if iOS version is less than 13.
     */
    func getPSIndexValues() {
        Webservice().getPSIndex { (response) in
            self.annotations = self.getAnnotations(regionMetaData: response.regionMetaData ?? [])
        }
    }
    
    /**
     This method retrieves the PSIndex values via GET service call. This method is calling if iOS version is greater than or equal to 13.
     */
    func fetchPSIndexValues() {
        let publisher = Webservice().fetchPSIndex()
        publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                print(error)
            case .finished :
                break
            }
        }){ psiValue in
            self.annotations = self.getAnnotations(regionMetaData: psiValue?.regionMetaData ?? [])
        }
    }
    let objectWillChange = PassthroughSubject<PSIndexViewModel, Never>()
}
