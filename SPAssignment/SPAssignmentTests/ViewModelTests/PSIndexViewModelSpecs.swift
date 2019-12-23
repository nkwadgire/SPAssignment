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
        describe("Given a list of PSI values") {
            context("and parsing PSI values is successful") {
                beforeEach {
                    if let path = Bundle(for: type(of: self)
                    ).path(forResource: "PSIndex", ofType: "json") {
                        do {
                            let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                                options: .alwaysMapped)
                            let decoder = JSONDecoder()
                            let psIndex = try decoder.decode(PSIndex.self, from: data)
                            psIndexViewModel.annotations = psIndexViewModel.getAnnotations(resonse: psIndex)
                        } catch {
                            fail("Error while parsing the JSON!!")
                        }
                    }
                }
                
                // Passes if 'psIndexViewModel.annotations' is not nil
                it("check if the annotation list is not nil") {
                    expect(psIndexViewModel.annotations).toNot(beNil())
                }
                // Passes if 'psIndexViewModel.annotations' is not nil
                it("check if the annotation list is not nil") {
                    expect(psIndexViewModel.annotations.isEmpty).toNot(equal(true))
                }
                
                // Passes if 'psIndexViewModel.annotations' is kind of [PSIRegionMetaData]
                it("check if the annotations list is kind of array of PSIAnnotation objects") {
                    expect(psIndexViewModel.annotations).to(beAKindOf([PSIAnnotation].self))
                }
                
                // Passes if 'psIndexViewModel.annotations' is having atleast one object
                it("check if the annotations list is having atleast one object") {
                    expect(psIndexViewModel.annotations.count) > 0
                }
                
                // Passes if 'psi.coordinate.latitude' is equal to 1.35735 where psi.title is "west"
                it("can parse the correct latitude") {
                    for psi in psIndexViewModel.annotations where psi.title == "west" {
                        expect(psi.coordinate.latitude).to(beCloseTo(1.35735, within: 0.1))
                    }
                }
                
                // Passes if 'psi.coordinate.longitude' is equal to 103.7 where psi.title is "west"
                it("can parse the correct longitude") {
                    for psi in psIndexViewModel.annotations where psi.title == "west" {
                        expect(psi.coordinate.longitude).to(beCloseTo(103.7, within: 0.1))
                    }
                }
                
                // Passes if 'psIndexViewModel.psIndexStatus' is healthy
                it("check if the PSIndex status is healthy") {
                    expect(psIndexViewModel.psIndexStatus).toEventually(contain("healthy"))
                }
            }
        }
    }
}
