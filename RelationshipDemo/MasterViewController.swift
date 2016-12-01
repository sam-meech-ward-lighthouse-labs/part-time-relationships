//
//  MasterViewController.swift
//  RelationshipDemo
//
//  Created by Sam Meech-Ward on 2016-12-01.
//  Copyright © 2016 Sam Meech-Ward. All rights reserved.
//

import UIKit
import Parse

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Song]()
    
    let songTitles = [
        "Starboy",
        "I Feel It Coming",
        "Party Monster",
        "False Alarm",
        "Reminder",
        "Rockin’",
        "Secrets",
        ]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let artist = Artist()
//        artist.name = "The Weeknd"
//        
//        artist.saveInBackground()
//        
//        for songTitle in songTitles {
//            let song = Song()
//            
//            song.title = songTitle
//            song.artist = artist;
//            
//            song.saveInBackground()
//        }
        
        if let artistQuery = Artist.query() {
            artistQuery.whereKey("name", equalTo: "The Weeknd")
            
            artistQuery.getFirstObjectInBackground(block: { (artist: PFObject?, error: Error?) in
                
                if let query = Song.query() {
                    query.whereKey("artist", equalTo: artist!)
                    
                    query.findObjectsInBackground(block: { (songs: [PFObject]?, error: Error?) in
                        
                        self.objects = songs as! [Song]
                        
                        OperationQueue.main.addOperation {
                            self.tableView.reloadData()
                        }
                    })
                }
                
            })
        }
        
        
        

    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Segues

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                let object = objects[indexPath.row] as! NSDate
//                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
//                controller.detailItem = object
//            }
//        }
//    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let song = objects[indexPath.row];
        cell.textLabel?.text = song.title
        
        return cell
    }


}

