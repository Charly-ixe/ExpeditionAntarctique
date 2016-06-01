//
//  FirstViewController.swift
//  expedition
//
//  Created by J.C Gigonnet on 20/04/2016.
//  Copyright © 2016 KLCT. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewMap: UIImageView!
    var imageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "terre-danger2.png"))
        scrollView.addSubview(imageView)
        print(imageView.frame.size)
        scrollView.contentSize = imageView.bounds.size
        scrollView.contentOffset = imageView.center
        scrollView.minimumZoomScale = 0.3
        scrollView.maximumZoomScale = 1
        
//        var elt = MapElementUIView(frame: CGRectMake(1000, 850, 80, 80), name: "Dumont", eltDescription: "Base Française")
//        elt.backgroundColor = nunatakBlack
//        imageView.addSubview(elt)
//        print(elt.elementDescription)
        
        
//        let point = CGPointMake(1000, 1000)
//        let frame = CGRectMake(point.x, point.y, 20, 20)
//        let viewtest = UIView(frame: frame)
//        viewtest.backgroundColor = UIColor.redColor()
//        imageView.addSubview(viewtest)
        
        scrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        
    }


}

