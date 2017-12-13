//
//  CoffeeViewController.swift
//  Automoto
//
//  Created by Stoica Mark on 2017. 11. 10..
//  Copyright © 2017. Stoica Mark. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CapsulesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    
    var coffeeDataManager : CoffeeDataManager?
    let imageManager = ImageManager()
    var coffees = [Coffee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 120
        activityIndicator.startAnimating()
        tableView.dataSource = self
        coffeeDataManager = CoffeeDataManager(delegate: self)
    }
}

// MARK: - Table view data source

extension CapsulesViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CoffeeCell = tableView.dequeueReusableCell(withIdentifier: "CoffeeCell", for: indexPath) as! CoffeeCell
        
        let coffee = coffees[indexPath.row]
        
        cell.title.text = coffee.name
        cell.price.text = String(format: "%.0f", coffee.price!)
        
        if let url = URL(string: coffee.imageUrl!) {
            imageManager.downloadImage(url: url, setImageFor: {
                image in
                cell.coffeeImage.image = image
            })
        }
        
        return cell
    }
}

extension CapsulesViewController : CoffeeDataDelegate{
    func onDataReceived(coffees: [Coffee]) {
        self.coffees = coffees
        self.activityIndicator.stopAnimating()
        self.alphaView.removeFromSuperview()
        self.tableView.reloadData()
    }
}

