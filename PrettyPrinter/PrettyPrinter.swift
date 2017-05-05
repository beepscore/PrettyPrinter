//
//  PrettyPrinter.swift
//  PrettyPrinter
//
//  Created by Steve Baker on 5/4/17.
//  Copyright © 2017 Beepscore LLC. All rights reserved.
//

import UIKit

class PrettyPrinter: NSObject {

    /// pretty converts Dictionary back into Data in order to use options .prettyPrinted
    /// https://pastebin.com/xaBjM0Pg
    /// http://stackoverflow.com/questions/29625133/convert-dictionary-to-json-in-swift
    /// http://stackoverflow.com/questions/24023253/how-to-initialise-a-string-from-nsdata-in-swift
    /// - parameter dict: Dictionary to convert to pretty string
    class func pretty(dict: [String:Any]) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            guard let string = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) else {
                return "Couldn't convert dict"
            }
            return string
        } catch let error {
            return "\(error)"
        }
    }
}
