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
import UIKit
extension String {
    func camelCase() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func camelCase() {
        self = self.camelCase()
    }
}

extension NSMutableAttributedString {
    class func getAttributedString(fromString string: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: string)
    }
    
    func apply(attribute: [NSAttributedString.Key: Any], subString: String) {
        if let range = self.string.range(of: subString) {
            self.apply(attribute: attribute, onRange: NSRange(range, in: self.string))
        }
    }
    
    func apply(attribute: [NSAttributedString.Key: Any], onRange range: NSRange) {
        if range.location != NSNotFound {
            self.setAttributes(attribute, range: range)
        }
    }

    func apply(color: UIColor, subString: String) {
      if let range = self.string.range(of: subString) {
        self.apply(color: color, onRange: NSRange(range, in: self.string))
      }
    }

    func apply(color: UIColor, onRange: NSRange) {
      self.addAttributes([NSAttributedString.Key.foregroundColor: color],
                         range: onRange)
    }
}
