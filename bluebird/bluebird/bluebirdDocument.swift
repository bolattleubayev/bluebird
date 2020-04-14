//
//  bluebirdDocument.swift
//  bluebird
//
//  Created by macbook on 1/22/20.
//  Copyright © 2020 bolattleubayev. All rights reserved.
//

import UIKit

class bluebirdDocument: UIDocument {
    
    var bluebird: bluebirdModel?
    var thumbnail: UIImage?
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return bluebird?.json ?? Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        if let json = contents as? Data {
            bluebird = bluebirdModel(json: json)
        }
    }
    
    // adding thumbnail to app files
    override func fileAttributesToWrite(to url: URL, for saveOperation: UIDocument.SaveOperation) throws -> [AnyHashable : Any] {
        var attributes = try super.fileAttributesToWrite(to: url, for: saveOperation)
        if let thumbnail = self.thumbnail {
            attributes[URLResourceKey.thumbnailDictionaryKey] = [URLThumbnailDictionaryItem.NSThumbnail1024x1024SizeKey:thumbnail]
        }
        return attributes
    }
}

