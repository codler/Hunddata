//
//  DetailViewController.swift
//  Hunddata
//
//  Created by Han Lin Yap on 2015-01-09.
//  Copyright (c) 2015 Han Lin Yap. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var objects = Array<HunddataDog>()

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: HunddataDog = self.detailItem as? HunddataDog {
            // Search for Hunddata
            var hunddata = Hunddata()
            hunddata.ready({ () -> Void in
                hunddata.dogs(detail, callback: { (data, err) -> Void in
                    dispatch_async(dispatch_get_main_queue()) {
                        let dogs: Array<HunddataDog> = data
                        // Display in tableview
                        self.objects = dogs
                        self.tableView.reloadData()
                    }
                })
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Passing selected HunddataDog to DogViewController
        if let indexPath = self.tableView.indexPathForSelectedRow() {
            let object = objects[indexPath.row] as HunddataDog
            let controller = (segue.destinationViewController as UINavigationController).topViewController as DogViewController
            controller.dog = object
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }

    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let object = objects[indexPath.row] as HunddataDog
        cell.textLabel!.text = object.dogName
        cell.detailTextLabel!.text = object.regnr
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

