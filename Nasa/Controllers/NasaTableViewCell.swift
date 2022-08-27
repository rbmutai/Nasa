//
//  NasaTableViewCell.swift
//  Nasa
//
//  Created by Robert Mutai on 26/08/2022.
//

import UIKit

class NasaTableViewCell: UITableViewCell {

    @IBOutlet weak var imnasaImage: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPhotographer: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbseparator: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
