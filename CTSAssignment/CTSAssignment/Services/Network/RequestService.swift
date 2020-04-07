//
//  RequestService.swift
//  CTSAssignment
//
//  Created by Kamlesh Kumar on 02/04/20.
//  Copyright © 2020 Kamlesh Kumar. All rights reserved.
//

import Foundation

final class RequestService {
    
    
    ///  Calling or requesting APi call for URLSession
    /// - Parameters:
    ///   - urlString: Api url ie drop box api
    ///   - session: urlseeion with default configuratin even user can create there custom session and tey pass as paramater to it
    ///   - completion: Result of Api model as Model
    /// - Returns: Void
    func loadData(urlString: String, session: URLSession = URLSession(configuration: .default), completion: @escaping (Result<Data, ErrorResult>) -> Void) -> URLSessionTask? {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.network(string: "Wrong url format")))
            return nil
        }
        // creating request
        let request = RequestFactory.request(method: .GET, url: url)
        // calling api on shared session
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                return
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }
}
