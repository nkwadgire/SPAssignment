//
/**
 *  * *****************************************************************************
 *  * Filename: StringExtension.swift                                             *
 *  * Author  : Nagraj Wadgire                                                    *
 *  * Creation Date: 20/12/19                                                     *
 *  * *
 *  * *****************************************************************************
 *  * Description:                                                                *
 *  * StringExtension extends the String class                                    *
 *  *                                                                             *
 *  * *****************************************************************************
 */

import Foundation
extension String {
    func camelCase() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func camelCase() {
        self = self.camelCase()
    }
}
