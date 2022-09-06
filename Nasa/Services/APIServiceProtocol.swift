//
//  API.swift
//  Nasa
//
//  Created by Robert Mutai on 06/09/2022.
//

import Foundation

protocol APIServiceProtocol {
    func fetchNasaImages(completion:@escaping (Any?, Error?) -> Void )
}
