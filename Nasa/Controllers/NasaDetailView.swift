//
//  NasaDetailView.swift
//  Nasa
//
//  Created by Robert Mutai on 26/08/2022.
//

import UIKit

class NasaDetailView: UIViewController {

    @IBOutlet weak var imnasaImage: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbPhotographer: UILabel!
    @IBOutlet weak var lbSeparator: UILabel!
    @IBOutlet weak var lbDetails: UITextView!
    
     var nasadetailmodel: NasaDetailModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbTitle.text = nasadetailmodel.nasaitem.data[0].title
        
        if let photographer = nasadetailmodel.nasaitem.data[0].photographer {
            lbPhotographer.text = photographer
        }else{
            lbPhotographer.text = ""
            lbSeparator.text = ""
        }
        
        lbDate.text = nasadetailmodel.displayDateFormat(date: nasadetailmodel.nasaitem.data[0].date_created)
        
        lbDetails.text = nasadetailmodel.nasaitem.data[0].description
        
        imnasaImage.downloadedFrom(link: nasadetailmodel.nasaitem.links[0].href, contentMode: .scaleToFill)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
