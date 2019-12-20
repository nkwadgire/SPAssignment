//
/**
 *  * *****************************************************************************
 *  * Filename: PSIndexViewModelSpecs.swift                                       *
 *  * Author  : Nagraj Wadgire                                                    *
 *  * Creation Date: 20/12/19                                                     *
 *  * *
 *  * *****************************************************************************
 *  * Description:                                                                *
 *  * PSIndexViewModelSpecs performs unit testing for PSIndex view model          *
 *  *                                                                             *
 *  * *****************************************************************************
 */

import Quick
import Nimble
@testable import SPAssignment

class PSIndexViewModelSpecs: QuickSpec {
    override func spec() {
        let psIndexViewModel = PSIndexViewModel()
        describe("Pollutant Standards Index") {
            context("can be created with a valid JSON") {
                beforeEach {
                    psIndexViewModel.getPSIndexValues()
                }
                // Passes if 'psIndex' is not nil
                it("can parse and check if the response is not nil") {
                    expect(psIndexViewModel.annotations.isEmpty).to(equal(true))
                }
            }
        }
    }
}
