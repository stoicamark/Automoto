//
//  CoffeeDataManager.swift
//  Automoto
//
//  Created by Stoica Mark on 2017. 10. 22..
//  Copyright © 2017. Stoica Mark. All rights reserved.
//

import Foundation
import FirebaseDatabase

class CoffeeDataManager{
    
    var coffees = [Coffee]()
    var ref : DatabaseReference?
    
    init(delegate: CoffeeDataDelegate){
        self.ref = Database.database().reference()
        
        ref?.child("Coffees").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot{
                    if let dict = snap.value as? [String : AnyObject]{
                        let coffee = Coffee()
                        coffee.name = dict["name"] as? String
                        coffee.acidity = dict["acidity"] as? Int
                        coffee.aromaticFamily = dict["aromatic family"] as? String
                        coffee.aromaticProfile = dict["aromatic profile"] as? String
                        coffee.bitterness = dict["bitterness"] as? Int
                        coffee.body = dict["body"] as? Int
                        coffee.cupSize = dict["cup size"] as? String
                        coffee.description = dict["description"] as? String
                        coffee.intensity = dict["intensity"] as? Int
                        coffee.price = dict["price"] as? Float
                        coffee.roasting = dict["roasting"] as? Int
                        coffee.imageUrl = dict["image"] as? String
                        self.coffees.append(coffee);
                    }
                }
            }
            delegate.onDataReceived(coffees: self.coffees)
        })
    }
}

protocol CoffeeDataDelegate{
    func onDataReceived(coffees: [Coffee]) -> Void
}
