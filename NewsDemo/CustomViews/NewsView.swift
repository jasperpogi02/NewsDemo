//
//  NewsView.swift
//  NewsDemo
//
//  Created by Jasper Alain Goce on 26/09/2019.
//  Copyright © 2019 blessed. All rights reserved.
//

import UIKit

class NewsView: UIView {
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    
    var viewDetails: NewsList.Response.Card? {
        didSet {
            if let imgURL = self.viewDetails?.imageURL {
                newsImg.loadImageUsingUrlString(urlString: imgURL)
                newsLbl.frame = CGRect(x: self.newsImg.frame.maxX + 16, y: self.newsImg.center.y - 40, width: self.frame.width - 158, height: 80)
            } else {
                newsLbl.frame = CGRect(x: 16, y: self.newsImg.center.y - 40, width: self.frame.width - 32, height: 80)
            }
            if let desc = self.viewDetails?.cardDescription,
                let company = self.viewDetails?.source,
                let date = self.viewDetails?.publishedAt {
                newsLbl.text = desc
                companyLbl.text = company
                companyLbl.frame = CGRect(x: 16, y: self.newsImg.frame.maxY + 16, width: self.companyLbl.intrinsicContentSize.width, height: self.companyLbl.intrinsicContentSize.height)
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                if let newDate = dateFormatter.date(from: date) {
                    // compute hours from current date
                    let computedDate = Date().timeIntervalSince(newDate)
                    var dateStr = ""
                    let hoursAgo = Int(computedDate / 60)
                    let daysAgo = Int(hoursAgo / 24)
                    if hoursAgo < 24 {
                        dateStr = "\(hoursAgo)hrs ago"
                    } else if daysAgo < 365 {
                        dateFormatter.dateFormat = "dd MMM"
                        dateStr = dateFormatter.string(from: newDate)
                    }
                    dateLbl.text = dateStr
                    dateLbl.frame = CGRect(x: companyLbl.intrinsicContentSize.width + 25, y: self.newsImg.frame.maxY + 16, width: self.dateLbl.intrinsicContentSize.width, height: self.dateLbl.intrinsicContentSize.height)
                }
            }
        }
    }
    
    lazy var newsImg: UIImageView = {
        let imgView = UIImageView(frame: CGRect(x: 16, y: 16, width: 110, height: 70))
        return imgView
    }()
    
    lazy var newsLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var companyLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1)
        return lbl
    }()
    
    lazy var dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(red: 178.0/255.0, green: 178.0/255.0, blue: 178.0/255.0, alpha: 1)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(newsImg)
        self.addSubview(newsLbl)
        self.addSubview(companyLbl)
        self.addSubview(dateLbl)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
