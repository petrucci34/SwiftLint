//
//  Region.swift
//  SwiftLint
//
//  Created by JP Simard on 8/29/15.
//  Copyright © 2015 Realm. All rights reserved.
//

import Foundation
import SourceKittenFramework

public struct Region {
    let start: Location
    let end: Location
    let disabledRuleIdentifiers: Set<String>

    public init(start: Location, end: Location, disabledRuleIdentifiers: Set<String>) {
        self.start = start
        self.end = end
        self.disabledRuleIdentifiers = disabledRuleIdentifiers
    }

    public func contains(location: Location) -> Bool {
        return start <= location && end >= location
    }

    public func isRuleEnabled(rule: Rule) -> Bool {
        return !isRuleDisabled(rule)
    }

    public func isRuleDisabled(rule: Rule) -> Bool {
        return disabledRuleIdentifiers.contains(rule.dynamicType.description.identifier)
    }
}
