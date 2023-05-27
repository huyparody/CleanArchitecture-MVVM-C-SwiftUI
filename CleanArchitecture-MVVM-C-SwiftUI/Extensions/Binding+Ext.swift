//
//  Binding+Ext.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import SwiftUI

extension Binding {
    public func defaultValue<T>(_ value: T) -> Binding<T> where Value == Optional<T> {
        Binding<T> {
            wrappedValue ?? value
        } set: {
            wrappedValue = $0
        }
    }
    
}

extension Binding where Value == Optional<String> {
    public var orEmpty: Binding<String> {
        Binding<String> {
            wrappedValue ?? ""
        } set: {
            wrappedValue = $0
        }
    }
}

extension Binding where Value == Optional<Bool> {
    public var orEmpty: Binding<Bool> {
        Binding<Bool> {
            wrappedValue ?? false
        } set: {
            wrappedValue = $0
        }
    }
}

extension Binding where Value == Optional<Int> {
    public var orEmpty: Binding<Int> {
        Binding<Int> {
            wrappedValue ?? 0
        } set: {
            wrappedValue = $0
        }
    }
}
