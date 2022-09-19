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
    
    private var viewmodel: ViewModel!
    private var bag: DisposeBag!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        
        viewmodel = ViewModel(service: MockAPIController())
        bag = DisposeBag()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewmodel = nil

        try super.tearDownWithError()
    }

    
    
    func testParseNasaItems() {
        
        //test if able to successfully parse data items from mock api
        
        let expectation = expectation(description: "Successfully parse data from mock api")
        
        viewmodel.nasaitems.subscribe(onNext: { nasaitem in
          
         
            
            let image_url=nasaitem[0].links[0].href
            
            
            //check if the data parsing of the imageurl from sample is accurate
            XCTAssertEqual(image_url, "https://images-assets.nasa.gov/image/ARC-2002-ACD02-0056-22/ARC-2002-ACD02-0056-22~thumb.jpg")

            //check if the data parsing of the title from sample is accurate
            let title=nasaitem[0].data[0].title

            XCTAssertEqual(title, "ARC-2002-ACD02-0056-22")
            
            
            expectation.fulfill()
           
        }).disposed(by: bag)
        
       
        viewmodel.getNasaImages()
        
       waitForExpectations(timeout: 20, handler: nil)
        
    }
    
   

    

}
