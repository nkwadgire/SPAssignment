//
/**
 *  * *****************************************************************************
 *  * Filename: Webservice.swift                                                  *
 *  * Author  : Nagraj Wadgire                                                    *
 *  * Creation Date: 19/12/19                                                     *
 *  * *
 *  * *****************************************************************************
 *  * Description:                                                                *
 *  * Webservice will make the URLSession service call to retrieve the PSI values.*
 *  *                                                                             *
 *  * *****************************************************************************
 */

import Foundation
import Combine

class Webservice: NSObject {
    // MARK: Webservice methods
    
    /**
    This method is returns the current date_time in yyyy-MM-dd'T'HH:mm:ss format
    */
    func currentDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDateString = formatter.string(from: Date())
        let currentDateTime = formatter.date(from: currentDateString)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let currentDateTimeString = formatter.string(from: currentDateTime!)
        return currentDateTimeString
    }
    
    /**
     This method is invoked if the iOS version is 13 and above.
     */
    func fetchPSIndex() -> AnyPublisher<PSIndex?, Error> {
        let requestURL = String(format: "%@?date_time=%@", URLList.PSIUrl, currentDateTime())
        guard let psiURL = URL(string: requestURL) else {
            fatalError("Invalid URL")
        }
        var request = URLRequest(url: psiURL)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        return URLSession.shared.dataTaskPublisher(for: psiURL)
            .map { $0.data }
            .decode(type: PSIndex.self, decoder: JSONDecoder())
            .map {$0}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    /**
     This method is invoked if the iOS version is less than 13.
     */
    func getPSIndex(completion: @escaping(PSIndex) -> Void) {
        let requestURL = String(format: "%@?date_time=%@", URLList.PSIUrl, currentDateTime())
        let url = URL(string: requestURL)!
        
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(PSIndex())
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error: invalid HTTP response code")
                return
            }
            guard let data = data else {
                print("Error: missing response data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode(PSIndex.self, from: data)
                completion(posts)
            } catch {
                print("Error: \(error.localizedDescription)")
                completion(PSIndex())
            }
        }
        task.resume()
    }
}
