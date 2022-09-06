//
//  APIController.swift
//  Nasa
//
//  Created by Robert Mutai on 26/08/2022.
//

import Foundation
class APIController: APIServiceProtocol{
    
    let nasasearchurl = "https://images-api.nasa.gov/search?q=%22%22"
    
    func fetchNasaImages(completion:@escaping (Any?, Error?) -> Void ){
        guard let url=URL(string: nasasearchurl)else{return}
        
        let task=URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, error)
        }
        task.resume()
    }
    
}
