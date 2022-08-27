//
//  RemoteImage.swift
//  Nasa
//
//  Created by Robert Mutai on 26/08/2022.
//

import Foundation
import UIKit
extension UIImageView {
    func downloadedFrom(link:String, contentMode mode: UIView.ContentMode) {
        self.image=nil
        guard
            let url = URL(string: link)
            else {return}
        contentMode = mode
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async { () -> Void in
                self.image = image
            }
        }).resume()
    }
}
