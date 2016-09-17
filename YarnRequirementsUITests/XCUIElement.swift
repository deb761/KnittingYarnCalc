//
//  XCUIElement.swift
//  YarnRequirements
//
//  Created by Deborah Engelmeyer on 8/6/16.
//  Copyright © 2016 The Inquisitive Introvert. All rights reserved.
//

import XCTest

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(_ text: String) -> Void {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        
        let deleteString = stringValue.characters.map { _ in "\u{8}" }.joined(separator: "")
        self.typeText(deleteString)
        
        self.typeText(text)
    }
}
