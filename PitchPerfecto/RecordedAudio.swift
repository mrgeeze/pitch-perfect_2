//
//  RecordedAudio.swift
//  PitchPerfecto
//
//  Created by Bob Bauer on 3/13/15.
//  Copyright (c) 2015 Bob Bauer. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject
{
    //TODO add initializer/constructor
    var filePathUrl:NSURL!
    var title:String!
    init(filePathUrl: NSURL, title: String)
    {
        self.filePathUrl = filePathUrl
        self.title = title
        
    }
}