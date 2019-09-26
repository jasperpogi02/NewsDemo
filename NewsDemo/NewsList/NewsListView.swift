//
//  NewsListView.swift
//  NewsDemo
//
//  Created by Jasper Alain Goce on 26/09/2019.
//  Copyright © 2019 blessed. All rights reserved.
//

import UIKit

protocol NewsListViewProtocol: class {
    
}

class NewsListView: UIView {
    weak var delegate: NewsListViewProtocol?
    var viewModel = NewsList.ViewModel()
    var requestModel: NewsList.Request.NewsRequest?
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: CGRect(x: self.frame.minX,
                                              y: self.frame.minY,
                                              width: self.frame.width,
                                              height: self.frame.height))
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.addSubview(scrollView)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
