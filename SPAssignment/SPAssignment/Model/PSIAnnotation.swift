//
/**
*  * *****************************************************************************
*  * Filename: PSIAnnotation.swift                                               *
*  * Author  : Nagraj Wadgire                                                    *
*  * Creation Date: 19/12/19                                                     *
*  * *
*  * *****************************************************************************
*  * Description:                                                                *
*  * PSIAnnotation class will create annotation point for passed coordinates     *
*  *                                                                             *
*  * *****************************************************************************
*/

import Foundation
import MapKit
import SwiftUI

class PSIAnnotation: NSObject, MKAnnotation, Identifiable {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String?,
         subtitle: String?,
         coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
