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
    @Published var loading = false {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send(self)
            }
        }
    }
    private var publisher: AnyPublisher<PSIndex?, Error>?
    @Published var psIndexStatus = String() {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send(self)
            }
        }
    }
    
    init() {
        updatePSIndex()
    }
    
    var annotations = [PSIAnnotation]() {
        willSet {
            DispatchQueue.main.async {
                self.objectWillChange.send(self)
            }
        }
    }
    
    func updatePSIndex() {
        self.loading = true
        if #available(iOS 13.0, *) {
            fetchPSIndexValues()
        } else {
            getPSIndexValues()
        }
    }
    
    func psiReading(regionName: String, readingTitle: String, endvalue: PSIReadingValues) -> String {
        var finalString = String()
        switch regionName {
        case "national":
            finalString = String(format: "%@    %.2f\n", readingTitle, endvalue.regionNational ?? "")
        case "north":
            finalString = String(format: "%@    %.2f\n", readingTitle, endvalue.regionNorth ?? "")
        case "south":
            finalString = String(format: "%@    %.2f\n", readingTitle, endvalue.regionSouth ?? "")
        case "east":
            finalString = String(format: "%@     %.2f\n", readingTitle, endvalue.regionEast ?? "")
        case "west":
            finalString = String(format: "%@     %.2f\n", readingTitle, endvalue.regionWest ?? "")
        case "central":
            finalString = String(format: "%@     %.2f\n", readingTitle, endvalue.regionCentral ?? "")
        default:
            break
        }
        return finalString
    }
    
    /**
     Returns the array of PSIAnnotation objects. These annotation points will be drawn using mapView
     
     @param resonse the PSIndex which is received as webservice reponse
     */
    func getAnnotations(resonse: PSIndex) -> [PSIAnnotation] {
        var annotationArray = [PSIAnnotation]()
        let regionMetaData = resonse.regionMetaData
        for annotation in regionMetaData ?? [] {
            let latitudeValue = annotation.location?.psiLatitude ?? 0.0
            let longitudeValue = annotation.location?.psiLongitude ?? 0.0
            let coordinate = CLLocationCoordinate2D.init(latitude: latitudeValue, longitude: longitudeValue)
            
            var readingString: String = "Pollutant Standards Index (PSI)\n"
            for dataInfo in resonse.items ?? [] {
                let region = annotation.name ?? ""
                let value: PSIReadings = dataInfo.psiReadings ?? PSIReadings()
                var psiReading = self.psiReading(regionName: region, readingTitle: "o3SubIndex", endvalue: (value.o3SubIndex)!)
                readingString.append(psiReading)
                psiReading = self.psiReading(regionName: region, readingTitle: "pm10TwentyFourHourly", endvalue: (value.pm10TwentyFourHourly)!)
                readingString.append(psiReading)
                psiReading = self.psiReading(regionName: region, readingTitle: "pm10SubIndex", endvalue: (value.pm10SubIndex)!)
                readingString.append(psiReading)
                psiReading = self.psiReading(regionName: region, readingTitle: "coSubIndex", endvalue: (value.coSubIndex)!)
                readingString.append(psiReading)
                psiReading = self.psiReading(regionName: region, readingTitle: "pm25TwentyFourHourly", endvalue: (value.pm25TwentyFourHourly)!)
                readingString.append(psiReading)
                psiReading = self.psiReading(regionName: region, readingTitle: "so2SubIndex", endvalue: (value.so2SubIndex)!)
                readingString.append(psiReading)
                psiReading = self.psiReading(regionName: region, readingTitle: "coEightHourMax", endvalue: (value.coEightHourMax)!)
                readingString.append(psiReading)
                psiReading = self.psiReading(regionName: region, readingTitle: "no2OneHourMax", endvalue: (value.no2OneHourMax)!)
                readingString.append(psiReading)
                psiReading = self.psiReading(regionName: region, readingTitle: "so2TwentyFourHourly", endvalue: (value.so2TwentyFourHourly)!)
                readingString.append(psiReading)
                psiReading = self.psiReading(regionName: region, readingTitle: "pm25SubIndex", endvalue: (value.pm25SubIndex)!)
                readingString.append(psiReading)
                psiReading = self.psiReading(regionName: region, readingTitle: "psiTwentyFourHourly", endvalue: (value.psiTwentyFourHourly)!)
                readingString.append(psiReading)
                psiReading = self.psiReading(regionName: region, readingTitle: "o3EightHourMax", endvalue: (value.o3EightHourMax)!)
                readingString.append(psiReading)
            }
            let annotation = PSIAnnotation(title: annotation.name?.camelCase(), subtitle: readingString, coordinate: coordinate)
            annotationArray.append(annotation)
        }
        return annotationArray
    }
    
    /**
     This method retrieves the PSIndex values via GET service call. This method is calling if iOS version is less than 13.
     */
    func getPSIndexValues() {
        Webservice().getPSIndex { (response) in
            self.loading = false
            self.annotations = self.getAnnotations(resonse: response)
            self.psIndexStatus = response.apiInfo?.infoStatus ?? ""
        }
    }
    
    /**
     This method retrieves the PSIndex values via GET service call. This method is calling if iOS version is greater than or equal to 13.
     */
    func fetchPSIndexValues() {
        publisher = Webservice().fetchPSIndex()
        publisher?.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                self.loading = false
                self.annotations = []
                print(error)
            case .finished :
                break
            }
        }){ psiValue in
            self.loading = false
            self.annotations = self.getAnnotations(resonse: psiValue!)
            self.psIndexStatus = psiValue?.apiInfo?.infoStatus ?? ""
        }
    }
    let objectWillChange = PassthroughSubject<PSIndexViewModel, Never>()
}
