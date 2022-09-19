//
//  MockAPIController.swift
//  Nasa
//
//  Created by Robert Mutai on 06/09/2022.
//

import Foundation
class MockAPIController: APIServiceProtocol {
    
     func fetchNasaImages(completion:@escaping (Any?, Error?) -> Void ){
       
       //fetch data from local json file, that mirrors API response
        do{
            let bundleurl = Bundle.main.url(forResource: "MockData", withExtension: "json")!
            
            let jsondata = try Data(contentsOf: bundleurl)
            
            completion(jsondata,nil)
        }catch{
            completion(nil, error)
        }
        
        
    }
    
}
