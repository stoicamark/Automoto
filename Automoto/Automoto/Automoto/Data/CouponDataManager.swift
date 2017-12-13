//
//  CouponDataManager.swift
//  Automoto
//
//  Created by Stoica Mark on 2017. 11. 09..
//  Copyright © 2017. Stoica Mark. All rights reserved.
//

import Foundation
import FirebaseDatabase

class CouponDataManager{
    
    var coupons = [Coupon]()
    var ref : DatabaseReference?
    
    init(delegate: CouponDataDelegate){
        self.ref = Database.database().reference()
        
        ref?.child("Coupons").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot{
                    if let dict = snap.value as? [String : AnyObject]{
                        let coupon = Coupon()
                        coupon.title = dict["title"] as? String
                        coupon.price = dict["price"] as? Float
                        coupon.saving = dict["saving"] as? Float
                        coupon.imageUrl = dict["imageUrl"] as? String
                        coupon.serial = dict["serial"] as? String
                        coupon.coffeeName = dict["coffeeName"] as? String
                        self.coupons.append(coupon);
                    }
                }
            }
            delegate.onDataReceived(coupons: self.coupons)
        })
    }
}

protocol CouponDataDelegate{
    func onDataReceived(coupons: [Coupon])->Void
}
