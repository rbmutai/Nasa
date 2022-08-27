//
//  NasaItem.swift
//  Nasa
//
//  Created by Robert Mutai on 26/08/2022.
//

import Foundation


struct NasaItem: Decodable {
    var collection: Item
}

struct Item: Decodable {
    var items: [Items]
}

struct Items: Decodable {
    var data: [DataItem]
    var links: [LinksItem]
}

struct DataItem: Decodable {
    var title: String
    var description: String
    var photographer: String?
    var date_created: Date
}

struct LinksItem: Decodable {
    var href: String
}



