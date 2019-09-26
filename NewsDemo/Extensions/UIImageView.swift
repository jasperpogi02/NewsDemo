//
//  UIImageView.swift
//  NewsDemo
//
//  Created by Jasper Alain Goce on 26/09/2019.
//  Copyright © 2019 blessed. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageUsingUrlString(urlString: String) {
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                if error != nil {
                    return
                }
                DispatchQueue.main.async(execute: {
                    self.image = UIImage(data: data!)
                })
            }).resume()
        }
    }
}
