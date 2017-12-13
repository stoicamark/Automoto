//
//  CouponsViewController.swift
//  Automoto
//
//  Created by Stoica Mark on 2017. 11. 09..
//  Copyright © 2017. Stoica Mark. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CouponsViewController: UIViewController{

    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    @IBOutlet weak var profileBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var slideScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides = [Slide]()
    let imageManager = ImageManager()
    var couponDataManager : CouponDataManager?
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        
        slideScrollView.delegate = self
        couponDataManager = CouponDataManager(delegate: self)
        
        if user == nil {
            profileBarButtonItem.isEnabled = false
        }
        
        pageControl.currentPage = 0
        view.bringSubview(toFront: pageControl)
    }
    
    func setupSlideScrollView(slides: [Slide]){
        slideScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        slideScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        
        slideScrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            slides[i].dynamicCouponIndicator.startAnimating()
            slideScrollView.addSubview(slides[i])
        }
        pageControl.numberOfPages = slides.count
    }
}

extension CouponsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        scrollView.contentOffset.y = 0
        
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

extension CouponsViewController: CouponDataDelegate{
    func onDataReceived(coupons: [Coupon]) {
        for coupon in coupons{
            let slide: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
            slide.price.text = String(format: "%.0f", coupon.price!)
            slide.saving.text = String(format: "%.0f", coupon.saving!)
            slide.title.text = coupon.title
            slide.serial.text = coupon.serial
            
            
            
            if let url = URL(string: coupon.imageUrl!) {
                imageManager.downloadImage(url: url, setImageFor: {image in
                    slide.couponImage.image = image
                    //slide.title.textColor = image.averageColor()?.contrastColor()
                })
            }
            
            if let barcodeImage = Barcode.fromString(string: coupon.serial!){
                slide.barcodeImage.image = barcodeImage
            }
            
            slides.append(slide)
        }
        
        setupSlideScrollView(slides: slides)
        activityIndicator.stopAnimating()
    }
}

extension CouponsViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ProfileViewController else{
            return
        }
        destinationVC.user = user
    }
}
