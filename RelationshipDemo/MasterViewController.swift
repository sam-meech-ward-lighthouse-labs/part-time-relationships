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


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getData()
        
//        createData()
    }
    
    func getData() {
        if let artistQuery = Artist.query() {
            artistQuery.whereKey("name", equalTo: "Canzino")
            
            if let query = Song.query() {
                
                query.whereKey("artists", matchesQuery: artistQuery)
                
                query.findObjectsInBackground(block: { (songs: [PFObject]?, error: Error?) in
                    if let error = error {
                        print("error \(error)")
                        
                    } else {
                        
                        self.objects = songs as! [Song]
                        
                        if let song1 = songs?[0] {
                            song1.deleteEventually()
                            self.tableView.reloadData()
                        }
                        
                        self.tableView.reloadData()
                    }
                    
                })
            }
        }
    }
    
    func createData() {
        let artist = Artist()
        artist.name = "firey sausage"
        
        let artist2 = Artist()
        artist2.name = "Canzino"
        
        Artist.saveAll(inBackground: [artist, artist2]) {(success: Bool, error: Error?) -> Void in
            
            if let error = error {
                print("error \(error)")
                
            } else {
                
                let fierySausageSongTitles = ["beans", "tacos", "pencil", "bananas", "mangoes", "peppers", "soup", "cactus", "snake", "trump"]
                
                for songTitle in fierySausageSongTitles {
                    
                    let song = Song()
                    song.title = songTitle
                    song.artists.add(artist)
                    
                    song.saveInBackground()
                }
                
                let songTitles = ["pizza", "donair", "sam is awesome", "joe is awesomer"]
                
                for songTitle in songTitles {
                    
                    let song = Song()
                    song.title = songTitle
                    song.artists.add(artist)
                    song.artists.add(artist2)
                    
                    song.saveInBackground()
                }
                
            }
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

        let song = self.objects[indexPath.row]
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.banana?.name
        
        return cell
    }


}

