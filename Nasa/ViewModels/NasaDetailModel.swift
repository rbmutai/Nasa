//
//  NasaDetailModel.swift
//  Nasa
//
//  Created by Robert Mutai on 26/08/2022.
//

import Foundation
class NasaDetailModel{
    var nasaitem:Items!
    
    init( item:Items) {
        nasaitem = item
    }
    func displayDateFormat(date:Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd MMM, yyyy"
        return dateformatter.string(from: date)
    }
    
}
