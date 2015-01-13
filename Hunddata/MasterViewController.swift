//
//  MasterViewController.swift
//  Hunddata
//
//  Created by Han Lin Yap on 2015-01-09.
//  Copyright (c) 2015 Han Lin Yap. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var regnrTextField: UITextField!
    
    var detailViewController: DetailViewController? = nil


    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Passing nameTextField to DetailViewController
        let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
        
        var dogMeta = HunddataDog()
        dogMeta.dogName = nameTextField.text
        dogMeta.regnr = regnrTextField.text
        
        controller.detailItem = dogMeta
        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        controller.navigationItem.leftItemsSupplementBackButton = true
    }

}

