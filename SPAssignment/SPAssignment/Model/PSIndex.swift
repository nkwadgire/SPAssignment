//
/**
*  * *****************************************************************************
*  * Filename: PSIndex.swift                                                     *
*  * Author  : Nagraj Wadgire                                                    *
*  * Creation Date: 19/12/19                                                     *
*  * *
*  * *****************************************************************************
*  * Description:                                                                *
*  * PSIndex model struct will hold the PSI response values.                     *
*  *                                                                             *
*  * *****************************************************************************
*/

import Foundation
import MapKit

struct PSIndex: Decodable {
    var regionMetaData: [PSIRegionMetaData]?
    var items: [PSIItems]?
    var apiInfo: PSIStatus?
    
    init() {}
    init(from decoder: Decoder) throws {
        do {
            let value = try decoder.container(keyedBy: CodingKeys.self)
            regionMetaData = try value.decodeIfPresent([PSIRegionMetaData].self, forKey: .regionMetaData)
            items = try value.decodeIfPresent([PSIItems].self, forKey: .items)
            apiInfo = try value.decodeIfPresent(PSIStatus.self, forKey: .apiInfo)
        } catch {
            print("Error reading config file: \(error.localizedDescription)")
        }
    }
    private enum CodingKeys: String, CodingKey {
        case regionMetaData = "region_metadata"
        case items = "items"
        case apiInfo = "api_info"
    }
}

struct PSIRegionMetaData: Decodable, Identifiable {
    var id: Int = 0
    var name: String? = ""
    var location: PSIlocation? = PSIlocation()
    
    init() {}
    
    init(from decoder: Decoder) throws {
        do {
            let value = try decoder.container(keyedBy: CodingKeys.self)
            name = try value.decodeIfPresent(String.self, forKey: .name)
            location = try value.decodeIfPresent(PSIlocation.self, forKey: .location)
        } catch {
            print("Error reading config file: \(error.localizedDescription)")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case location = "label_location"
    }
}

struct PSIlocation: Decodable {
    var psiLatitude: Double?
    var psiLongitude: Double?
    
    init() {}
    
    init(from decoder: Decoder) throws {
        do {
            let value = try decoder.container(keyedBy: CodingKeys.self)
            psiLatitude = try value.decodeIfPresent(Double.self, forKey: .psiLatitude)
            psiLongitude = try value.decodeIfPresent(Double.self, forKey: .psiLongitude)
        } catch {
            print("Error reading config file: \(error.localizedDescription)")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case psiLatitude = "latitude"
        case psiLongitude = "longitude"
    }
}

struct PSIItems: Decodable {
    var timestamp: String?
    var updateTimestamp: String?
    var psiReadings: PSIReadings?
    
    init() {}
    
    init(from decoder: Decoder) throws {
        do {
            let value = try decoder.container(keyedBy: CodingKeys.self)
            timestamp = try value.decodeIfPresent(String.self, forKey: .timestamp)
            updateTimestamp = try value.decodeIfPresent(String.self, forKey: .updateTimestamp)
            psiReadings = try value.decodeIfPresent(PSIReadings.self, forKey: .psiReadings)
        } catch {
            print("Error reading config file: \(error.localizedDescription)")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp"
        case updateTimestamp = "update_timestamp"
        case psiReadings = "readings"
    }
}

struct PSIReadings: Decodable {
    var o3SubIndex: PSIReadingValues?
    var pm10TwentyFourHourly: PSIReadingValues?
    var pm10SubIndex: PSIReadingValues?
    var coSubIndex: PSIReadingValues?
    var pm25TwentyFourHourly: PSIReadingValues?
    var so2SubIndex: PSIReadingValues?
    var coEightHourMax: PSIReadingValues?
    var no2OneHourMax: PSIReadingValues?
    var so2TwentyFourHourly: PSIReadingValues?
    var pm25SubIndex: PSIReadingValues?
    var psiTwentyFourHourly: PSIReadingValues?
    var o3EightHourMax: PSIReadingValues?
    
    init() {}
    
    init(from decoder: Decoder) throws {
        do {
            let value = try decoder.container(keyedBy: CodingKeys.self)
            o3SubIndex = try value.decodeIfPresent(PSIReadingValues.self, forKey: .o3SubIndex)
            pm10TwentyFourHourly = try value.decodeIfPresent(PSIReadingValues.self, forKey: .pm10TwentyFourHourly)
            pm10SubIndex = try value.decodeIfPresent(PSIReadingValues.self, forKey: .pm10SubIndex)
            coSubIndex = try value.decodeIfPresent(PSIReadingValues.self, forKey: .coSubIndex)
            pm25TwentyFourHourly = try value.decodeIfPresent(PSIReadingValues.self, forKey: .pm25TwentyFourHourly)
            so2SubIndex = try value.decodeIfPresent(PSIReadingValues.self, forKey: .so2SubIndex)
            coEightHourMax = try value.decodeIfPresent(PSIReadingValues.self, forKey: .coEightHourMax)
            no2OneHourMax = try value.decodeIfPresent(PSIReadingValues.self, forKey: .no2OneHourMax)
            so2TwentyFourHourly = try value.decodeIfPresent(PSIReadingValues.self, forKey: .so2TwentyFourHourly)
            pm25SubIndex = try value.decodeIfPresent(PSIReadingValues.self, forKey: .pm25SubIndex)
            psiTwentyFourHourly = try value.decodeIfPresent(PSIReadingValues.self, forKey: .psiTwentyFourHourly)
            o3EightHourMax = try value.decodeIfPresent(PSIReadingValues.self, forKey: .o3EightHourMax)
            
        } catch {
            print("Error reading config file: \(error.localizedDescription)")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case o3SubIndex = "o3_sub_index"
        case pm10TwentyFourHourly = "pm10_twenty_four_hourly"
        case pm10SubIndex = "pm10_sub_index"
        case coSubIndex = "co_sub_index"
        case pm25TwentyFourHourly = "pm25_twenty_four_hourly"
        case so2SubIndex = "so2_sub_index"
        case coEightHourMax = "co_eight_hour_max"
        case no2OneHourMax = "no2_one_hour_max"
        case so2TwentyFourHourly = "so2_twenty_four_hourly"
        case pm25SubIndex = "pm25_sub_index"
        case psiTwentyFourHourly = "psi_twenty_four_hourly"
        case o3EightHourMax = "o3_eight_hour_max"
    }
}

struct PSIReadingValues: Decodable {
    var regionWest: Double?
    var regionNational: Double?
    var regionEast: Double?
    var regionCentral: Double?
    var regionSouth: Double?
    var regionNorth: Double?
    
    init() {}
    
    init(from decoder: Decoder) throws {
        do {
            let value = try decoder.container(keyedBy: CodingKeys.self)
            regionWest = try value.decodeIfPresent(Double.self, forKey: .regionWest)
            regionNational = try value.decodeIfPresent(Double.self, forKey: .regionNational)
            regionEast = try value.decodeIfPresent(Double.self, forKey: .regionEast)
            regionCentral = try value.decodeIfPresent(Double.self, forKey: .regionCentral)
            regionSouth = try value.decodeIfPresent(Double.self, forKey: .regionSouth)
            regionNorth = try value.decodeIfPresent(Double.self, forKey: .regionNorth)
        } catch {
            print("Error reading config file: \(error.localizedDescription)")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case regionWest = "west"
        case regionNational = "national"
        case regionEast = "east"
        case regionCentral = "central"
        case regionSouth = "south"
        case regionNorth = "north"
    }
}

struct PSIStatus: Decodable {
    var infoStatus: String?
    
    init() {}
    
    init(from decoder: Decoder) throws {
        do {
            let value = try decoder.container(keyedBy: CodingKeys.self)
            infoStatus = try value.decodeIfPresent(String.self, forKey: .infoStatus)
        } catch {
            print("Error reading config file: \(error.localizedDescription)")
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case infoStatus = "status"
    }
}
