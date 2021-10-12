//
//  UIKit+Extensions.swift
//  Starships
//
//  Created by Vimukthi Vishvanath on 10/10/21.
//

import Foundation

extension String{
    func localizedString() -> String {
        return NSLocalizedString(self, tableName: "Localization", bundle: Bundle.main, value: "", comment: "")
    }
    
    func localizedString(withComment:String) -> String {
        return NSLocalizedString(self, tableName: "Localization", bundle: Bundle.main, value: "", comment: withComment)
    }
    
}
