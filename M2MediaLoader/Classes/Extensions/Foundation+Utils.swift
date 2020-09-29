//
//  Foundation+Utils.swift
//  LiveCollage
//
//  Created by Matias Fernandez on 18/10/2017.
//  Copyright © 2017 M2Media. All rights reserved.
//

/*
 There is no straight forward way to handle CF classes and bridging them into new swift classes,
 hence this extension to ease up the pain
 */

import Foundation

//MARK: Utility Methods
public extension URL {
    func CFURL() -> CFURL? {
        let ns = self as NSURL
        return ns as CFURL
    }
}

public extension Dictionary {
    func CFDictionary() -> CFDictionary? {
        return NSDictionary(dictionary: self) as CFDictionary
    }
}

public extension Data {
    func CFData() -> CFData? {
        let data = NSData(data: self) as CFData
        return data
    }
}

