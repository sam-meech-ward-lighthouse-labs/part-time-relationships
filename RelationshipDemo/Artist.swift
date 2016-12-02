//
//  Artist.swift
//  RelationshipDemo
//
//  Created by Sam Meech-Ward on 2016-12-01.
//  Copyright © 2016 Sam Meech-Ward. All rights reserved.
//

import UIKit
import Parse

class Artist: PFObject, PFSubclassing {

    @NSManaged var name: String?
    
    static func parseClassName() -> String {
        return "MusicArtist"
    }
    
}
