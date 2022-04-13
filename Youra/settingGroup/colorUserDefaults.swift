//
//  colorUserDefaults.swift
//  Youra
//
//  Created by Hansel Matthew on 13/04/22.
//

import Foundation

struct colorUserDefaults{
    static var colorshared = colorUserDefaults()
    
    var theme: Theme{
        get{
            return Theme(rawValue: UserDefaults.standard.integer(forKey: "selectedTheme")) ?? .device
        }
        set{
            UserDefaults.standard.set(newValue.rawValue,forKey: "selectedTheme")
        }
    }
}
