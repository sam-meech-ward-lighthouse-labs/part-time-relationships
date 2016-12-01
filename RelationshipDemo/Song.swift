//
//  Song.swift
//  RelationshipDemo
//
//  Created by Sam Meech-Ward on 2016-12-01.
//  Copyright © 2016 Sam Meech-Ward. All rights reserved.
//

import UIKit
import Parse

class Song: PFObject, PFSubclassing {

    @NSManaged var title: String
    
    var artists: PFRelation<PFObject>! {
        return relation(forKey: "artists")
    }
    
    
    static func parseClassName() -> String {
        return "Song"
    }
}
