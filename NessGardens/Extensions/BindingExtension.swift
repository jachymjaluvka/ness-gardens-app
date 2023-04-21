//
//  BindingExtension.swift
//  NessGardens
//
//  Created by Jachym Jaluvka on 20.04.2023.
//

import Foundation
import SwiftUI

extension Binding {
    
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(get: { self.wrappedValue},
                set: { newValue in
            self.wrappedValue = newValue
            handler(newValue) })
    }
}
