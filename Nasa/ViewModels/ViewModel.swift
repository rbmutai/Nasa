//
//  ViewModel.swift
//  Nasa
//
//  Created by Robert Mutai on 26/08/2022.
//

import Foundation
import RxSwift

class ViewModel{
    
   //data items from server
    var nasaitems = PublishSubject<[Items]>()
    
    //variable indicating error and notify UI to display it
    var error_received = PublishSubject<String>()
    
    //service object for making network calls
    var service: APIServiceProtocol?
    
    init(service: APIServiceProtocol){
        self.service = service
       
    }
    func getNasaImages() {
       
        service?.fetchNasaImages { response, error in
            guard error == nil else{
                self.error_received.onNext(error!.localizedDescription)
               
                return
            }
            let decoder = JSONDecoder()
            
            //dateformatter to convert string to date
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            dateformatter.locale = Locale(identifier: "en-US")
            dateformatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            
            decoder.dateDecodingStrategy = .formatted(dateformatter)
            
            guard let items = try? decoder.decode(NasaItem.self, from: response as! Data)else{
                self.error_received.onNext("Error Parsing Result")
               
                return
            }
            
            self.nasaitems.onNext(items.collection.items)
            self.nasaitems.onCompleted()
           
        }
    }
    func displayDateFormat(date:Date) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd MMM, yyyy"
        return dateformatter.string(from: date)
    }
    
    
}
