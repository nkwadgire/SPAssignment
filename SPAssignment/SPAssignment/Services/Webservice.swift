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
    
    // fetchPSIndex : This method is invoked if the iOS version is 13 and above
    func fetchPSIndex() -> AnyPublisher<PSIndex?, Error> {
        
        guard let psiURL = URL(string: URLList.PSIUrl) else {
            fatalError("Invalid URL")
        }
        return URLSession.shared.dataTaskPublisher(for: psiURL)
            .map { $0.data }
            .decode(type: PSIndex.self, decoder: JSONDecoder())
            .map {$0}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    // getPSIndex : This method is invoked if the iOS version is less than 13
    func getPSIndex(completion: @escaping(PSIndex) -> Void) {
        let url = URL(string: URLList.PSIUrl)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                fatalError("Error: invalid HTTP response code")
            }
            guard let data = data else {
                fatalError("Error: missing response data")
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
