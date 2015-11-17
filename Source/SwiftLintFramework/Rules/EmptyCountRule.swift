//
//  EmptyCountRule.swift
//  SwiftLint
//
//  Created by JP Simard on 2015-11-17.
//  Copyright (c) 2015 Realm. All rights reserved.
//

import SourceKittenFramework

public struct EmptyCountRule: Rule {
    public init() {}

    public static let description = RuleDescription(
        identifier: "empty_count",
        name: "Empty Count",
        description: "Prefer checking `isEmpty` over comparing `count` to zero.",
        nonTriggeringExamples: [
            "[Int]().isEmpty\n",
            "[Int]().count > 1\n",
            "[Int]().count == 1\n"
        ],
        triggeringExamples: [
            "[Int]().count == 0\n",
            "[Int]().count > 0\n",
            "[Int]().count != 0\n"
        ]
    )

    public func validateFile(file: File) -> [StyleViolation] {
        let pattern = "count\\s*[!<=>]+\\s*0"
        let excludingKinds = SyntaxKind.commentAndStringKinds()
        return file.matchPattern(pattern, excludingSyntaxKinds: excludingKinds).map {
            StyleViolation(ruleDescription: self.dynamicType.description,
                severity: .Error, location: Location(file: file, offset: $0.location))
        }
    }
}
