//
//  DogViewController.swift
//  Hunddata
//
//  Created by Han Lin Yap on 2015-01-11.
//  Copyright (c) 2015 Han Lin Yap. All rights reserved.
//

import UIKit

class DogViewController: UITableViewController {
    
    @IBOutlet weak var hund: UILabel!
    @IBOutlet weak var mor: UILabel!
    
    var dog: HunddataDog? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if self.hund != nil {
            self.hund.text = self.dog?.regnr
            
            // Search for additional data on specific dog
            self.dog?.fetch({ () -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    // Display in view
                    self.mor.text = self.dog?.morName
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
}