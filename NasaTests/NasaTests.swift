//
//  NasaTests.swift
//  NasaTests
//
//  Created by Robert Mutai on 26/08/2022.
//

import XCTest
import RxSwift
@testable import Nasa

class NasaTests: XCTestCase {
    
    var viewmodel: ViewModel!
    private var bag:DisposeBag!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        viewmodel=ViewModel()
        bag = DisposeBag()
        
    }

//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        viewmodel=nil
//
//        try super.tearDownWithError()
//    }

    
    
    func testgetNasaItems() {
        
        //test if able to successfully access data from server
        
        let expectation = expectation(description: "Successfully get data from server")
        
        viewmodel.nasaitems.subscribe { event in
            if(event.isCompleted){
                expectation.fulfill()
            }
        }.disposed(by: bag)
        
        viewmodel.getNasaImages()
        
       waitForExpectations(timeout: 20, handler: nil)
        
    }
    
    func testcheckValidJsonParsing(){
        let bundleurl = Bundle.main.url(forResource: "MockData", withExtension: "json")!
        
        let jsondata = try! Data(contentsOf: bundleurl)
        let decoder = JSONDecoder()
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateformatter.locale = Locale(identifier: "en-US")
        dateformatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        
        decoder.dateDecodingStrategy = .formatted(dateformatter)
        
        do{
            let nasaitem = try decoder.decode(NasaItem.self, from: jsondata)
            
            //check if the data parsing of the image url from sample is accurate
            let image_url=nasaitem.collection.items[0].links[0].href

            XCTAssertEqual(image_url, "https://images-assets.nasa.gov/image/ARC-2002-ACD02-0056-22/ARC-2002-ACD02-0056-22~thumb.jpg")

            //check if the data parsing of the title from sample is accurate
            let title=nasaitem.collection.items[0].data[0].title

            XCTAssertEqual(title, "ARC-2002-ACD02-0056-22")
            
            
        }catch{
            //fail if unable to decode sample that matches server data
            XCTFail(error.localizedDescription)
        }
        
         
        
        
    }

    

}
