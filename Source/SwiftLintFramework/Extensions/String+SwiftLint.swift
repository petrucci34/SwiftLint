//
//  String+SwiftLint.swift
//  SwiftLint
//
//  Created by JP Simard on 2015-05-16.
//  Copyright (c) 2015 Realm. All rights reserved.
//

import Foundation
import SourceKittenFramework
import SwiftXPC

extension String {
    func hasTrailingWhitespace() -> Bool {
        if isEmpty {
            return false
        }

        if let character = utf16.suffix(1).first {
            return NSCharacterSet.whitespaceCharacterSet().characterIsMember(character)
        }

        return false
    }

    func isUppercase() -> Bool {
        return self == uppercaseString
    }

    public var chomped: String {
        return stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
    }

    public func nameStrippingLeadingUnderscoreIfPrivate(dict: XPCDictionary) -> String {
        let privateACL = "source.lang.swift.accessibility.private"
        if dict["key.accessibility"] as? String == privateACL && characters.first == "_" {
            return self[startIndex.successor()..<endIndex]
        }
        return self
    }

    internal subscript (range: Range<Int>) -> String {
        let nsrange = NSRange(location: range.startIndex, length: range.endIndex - range.startIndex)
        return substringWithRange(nsrangeToIndexRange(nsrange))
    }

    func substring(from: Int, length: Int? = nil) -> String {
        if let length = length {
            return self[from..<from + length]
        }
        return substringFromIndex(startIndex.advancedBy(from, limit: endIndex))
    }

    public func lastIndexOf(search: String) -> Int? {
        if let range = rangeOfString(search, options: [.LiteralSearch, .BackwardsSearch]) {
            return startIndex.distanceTo(range.startIndex)
        }
        return nil
    }

    internal func nsrangeToIndexRange(nsrange: NSRange) -> Range<Index> {
        let start = startIndex.advancedBy(nsrange.location, limit: endIndex)
        let end = start.advancedBy(nsrange.length, limit: endIndex)
        return start..<end
    }
}
