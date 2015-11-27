//
//  LeadingWhitespaceRule.swift
//  SwiftLint
//
//  Created by JP Simard on 2015-05-16.
//  Copyright (c) 2015 Realm. All rights reserved.
//

import SourceKittenFramework

public struct LeadingWhitespaceRule: Rule {
    public static let description = RuleDescription(
        identifier: "leading_whitespace",
        name: "Leading Whitespace",
        description: "Files should not contain leading whitespace.",
        nonTriggeringExamples: [ "//\n" ],
        triggeringExamples: [ "\n", " //\n" ]
    )

    public func validateFile(file: File) -> [StyleViolation] {
        let countOfLeadingWhitespace = file.contents.countOfLeadingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        if countOfLeadingWhitespace == 0 {
            return []
        }
        return [StyleViolation(ruleDescription: self.dynamicType.description,
            location: Location(file: file.path, line: 1),
            reason: "File shouldn't start with whitespace: " +
            "currently starts with \(countOfLeadingWhitespace) whitespace characters")]
    }
}
