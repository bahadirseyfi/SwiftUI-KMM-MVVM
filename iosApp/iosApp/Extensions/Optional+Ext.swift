//
//  Optional+Ext.swift
//  iosApp
//
//  Created by bahadir on 14.04.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import CoreGraphics
import Foundation

public protocol EmptyValuable {
    /// Returns an empty value of `Self`
    static var emptyValue: Self { get }
}

/// Extension of Optional. Adds following capability to String; Null/Nil handling in an elegant way.
public extension Swift.Optional where Wrapped == String {
    var orEmptyString: String {
        if let unwrappedString = self {
            return unwrappedString
        }
        return ""
    }
    func or(_ text: String) -> String {
        guard let str = self else {
            return text
        }
        return str
    }
    func or(optionalString: String?) -> String? {
        guard let str = self else {
            return optionalString
        }
        return str
    }
    var isNullOrEmpty: Bool {
        if self == Optional.none {
            return true
        }
        if let value = self {
            return value.isEmpty
        }
        return false
    }
    var isNotNullOrEmpty: Bool {
        !isNullOrEmpty
    }
}

/// Extension of Optional. Adds following capability to Double; Null/Nil handling in an elegant way.
public extension Swift.Optional where Wrapped == Double {
    var orZero: Double {
        if let unwrappedDouble = self {
            return unwrappedDouble
        }
        return 0
    }
    func or(_ value: Double) -> Double {
        guard let dbl = self else {
            return value
        }
        return dbl
    }
}

/// Extension of Optional. Adds following capability to UInt; Null/Nil handling in an elegant way.
public extension Swift.Optional where Wrapped == UInt {
    var orZero: UInt {
        if let unwrappedDouble = self {
            return unwrappedDouble
        }
        return 0
    }
    func or(_ value: UInt) -> UInt {
        guard let int = self else {
            return value
        }
        return int
    }
}

/// Extension of Optional. Adds following capability to Int; Null/Nil handling in an elegant way.
public extension Swift.Optional where Wrapped == Int {
    var orZero: Int {
        if let unwrappedInt = self {
            return unwrappedInt
        }
        return 0
    }
}

/// Extension of Optional. Adds following capability to Bool; Null/Nil handling in an elegant way.
public extension Swift.Optional where Wrapped == Bool {
    var orFalse: Bool {
        if let unwrappedBool = self {
            return unwrappedBool
        }
        return false
    }

    var orTrue: Bool {
        if let unwrappedBool = self {
            return unwrappedBool
        }
        return true
    }
}

/// Extension of Optional. Adds following capability to CGPoint; Null/Nil handling in an elegant way.
public extension Swift.Optional where Wrapped == CGPoint {
    var orZero: CGPoint {
        if let unwrappedCGPoint = self {
            return unwrappedCGPoint
        }
        return .zero
    }
}

public extension Swift.Optional where Wrapped == CGFloat {
    var orZero: CGFloat {
        if let unwrappedCGPoint = self {
            return unwrappedCGPoint
        }
        return .zero
    }
}

public extension Swift.Optional where Wrapped == Decimal {
    var orZero: Decimal {
        if let unwrappedDecimal = self {
            return unwrappedDecimal
        }
        return .zero
    }
}

public extension Swift.Optional where Wrapped: EmptyValuable {
    /// Returns an empty  of`Wrapped` type if self is nil, otherwise it returns unwrapped value.
    var orEmpty: Wrapped {
        guard let self = self else {
            return Wrapped.emptyValue
        }

        return self
    }
}

public extension Swift.Optional where Wrapped == NSAttributedString {
    var orEmptyAttributedString: NSAttributedString {
        if let unwrappedString = self {
            return unwrappedString
        }
        return NSAttributedString(string: "")
    }
}
