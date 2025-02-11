//
/**
 *  * *****************************************************************************
 *  * Filename: PSIndexSpecs.swift                                                *
 *  * Author  : Nagraj Wadgire                                                    *
 *  * Creation Date: 20/12/19                                                     *
 *  * *
 *  * *****************************************************************************
 *  * Description:                                                                *
 *  * PSIndexSpecs performs unit testing for PSIndex model structure              *
 *  *                                                                             *
 *  * *****************************************************************************
 */

import Quick
import Nimble
@testable import SPAssignment

class PSIndexSpecs: QuickSpec {
    override func spec() {
        var psIndex: PSIndex!
        describe("Pollutant Standards Index") {
            context("can be created with a valid JSON") {
                afterEach {
                    psIndex = nil
                }
                beforeEach {
                    if let path = Bundle(for: type(of: self)
                    ).path(forResource: "PSIndex", ofType: "json") {
                        do {
                            let data = try Data(contentsOf: URL(fileURLWithPath: path),
                                                options: .alwaysMapped)
                            let decoder = JSONDecoder()
                            psIndex = try decoder.decode(PSIndex.self, from: data)
                        } catch {
                            fail("Error while parsing the JSON!!")
                        }
                    }
                }
                // Passes if 'psIndex' is not nil
                it("can parse and check if the response is not nil") {
                    expect(psIndex).toNot(beNil())
                }
                
                // Passes if 'psIndex.regionMetaData' is not empty
                it("can parse and check if the region metadata is not empty") {
                    expect(psIndex.regionMetaData?.isEmpty).toNot(equal(true))
                }
                
                // Passes if 'psIndex.regionMetaData' is kind of [PSIRegionMetaData]
                it("can parse and check if the region metadata is kind of array of PSIRegionMetaData objects") {
                    expect(psIndex.regionMetaData).to(beAKindOf([PSIRegionMetaData].self))
                }
                
                // Passes if 'psi.location?.psiLatitude' is equal to 1.35735 where psi.title is "west"
                it("can parse the correct latitude") {
                    for psi in psIndex.regionMetaData ?? [] where psi.name == "west" {
                        expect(psi.location?.psiLatitude).to(beCloseTo(1.35735, within: 0.1))
                    }
                }
                
                // Passes if 'psi.location?.psiLongitude' is equal to 103.7 where psi.title is "west"
                it("can parse the correct longitude") {
                    for psi in psIndex.regionMetaData ?? [] where psi.name == "west" {
                        expect(psi.location?.psiLongitude).to(beCloseTo(103.7, within: 0.1))
                    }
                }
                
                // Passes if 'psIndex.items' is not empty
                it("can parse and check if the items is not empty") {
                    expect(psIndex.items?.isEmpty).toNot(equal(true))
                }
                
                // Passes if 'psIndex.items' is kind of [PSIItems]
                it("can parse and check if the items is kind of array of PSIItems objects") {
                    expect(psIndex.items).to(beAKindOf([PSIItems].self))
                }
                
                // Passes if 'psi.psiReadings?.o3SubIndex?.regionNorth' is equal to 1 where psi.title is "north"
                it("can parse the correct o3SubIndex for north region") {
                    for psi in psIndex.regionMetaData ?? [] where psi.name == "north" {
                        for psi in psIndex.items ?? [] {
                            expect(psi.psiReadings?.o3SubIndex?.regionNorth).to(beCloseTo(1, within: 0.1))
                        }
                    }
                }
                
                // Passes if 'psi.psiReadings?.o3SubIndex?.pm10TwentyFourHourly' is equal to 1 where psi.title is "south"
                it("can parse the correct pm10TwentyFourHourly for south region") {
                    for psi in psIndex.regionMetaData ?? [] where psi.name == "south" {
                        for psi in psIndex.items ?? [] {
                            expect(psi.psiReadings?.pm10TwentyFourHourly?.regionSouth).to(beCloseTo(23, within: 0.1))
                        }
                    }
                }
                
                // Passes if 'psIndex.apiInfo?.infoStatus' is equal to "healthy"
                it("can parse the api_info Status") {
                    expect(psIndex.apiInfo?.infoStatus).to(equal("healthy"))
                }
            }
        }
    }
}
