import Foundation
import XCTest

public func AssertThrowsSpecific<E:ErrorProtocol>( expression: @autoclosure () throws -> Void, expectedError: E, _ message: String = "",_ file: StaticString = #file,_ line: UInt = #line) {
    do {
        try expression()
        FailAssertion(#function, message, file, line)
    } catch let caughtError {
        guard caughtError is E else {
            FailAssertion(#function, message, file, line)
            return
        }
    }
}

public func AssertThrowsSpecific<E where E: ErrorProtocol, E: Equatable>( expression: @autoclosure () throws -> Void, expectedError: E, _ message: String = "",_ file: StaticString = #file,_ line: UInt = #line) {
    do {
        try expression()
        FailAssertion(#function, message, file, line)
    } catch let caughtError as E {
        if caughtError != expectedError {
            FailAssertion(#function, message, file, line)
        }
    } catch {
        FailAssertion(#function, message, file, line)
    }
}

public func AssertThrowsSpecific<E: NSError>( expression: @autoclosure () throws -> Void, expectedError: E, _ message: String = "",_ file: StaticString = #file,_ line: UInt = #line) {
    do {
        try expression()
        FailAssertion(#function, message, file, line)
    } catch let caughtError as E {
        if !caughtError.isEqual(expectedError)  {
            FailAssertion(#function, message, file, line)
        }
    } catch {
        FailAssertion(#function, message, file, line)
    }
}

public func AssertNoThrowSpecific<E:ErrorProtocol>( expression: @autoclosure () throws -> Void, expectedError: E, _ message: String = "",_ file: StaticString = #file,_ line: UInt = #line) {
    do {
        try expression()
        FailAssertion(#function, message, file, line)
    } catch let caughtError {
        guard caughtError is E else {
            FailAssertion(#function, message, file, line)
            return
        }
    }
}

public func AssertNoThrowSpecific<E where E: ErrorProtocol, E: Equatable>( expression: @autoclosure () throws -> Void, expectedError: E, _ message: String = "",_ file: StaticString = #file,_ line: UInt = #line) {
    do {
        try expression()
    } catch let caughtError as E {
        if caughtError == expectedError {
            FailAssertion(#function, message, file, line)
        }
    } catch {}
}

public func AssertNoThrowSpecific<E: NSError>( expression: @autoclosure () throws -> Void, expectedError: E, _ message: String = "",_ file: StaticString = #file,_ line: UInt = #line) {
    do {
        try expression()
    } catch let caughtError as E {
        if caughtError.isEqual(expectedError)  {
            FailAssertion(#function, message, file, line)
        }
    } catch {}
}

public func AssertThrows( expression: @autoclosure () throws -> Void, _ message: String = "",_ file: StaticString = #file,_ line: UInt = #line) {
    if let _ = try? expression() {
        FailAssertion(#function, message, file, line)
    }
}

public func AssertNoThrow( expression: @autoclosure () throws -> Void, _ message: String = "",_ file: StaticString = #file,_ line: UInt = #line) {
    guard let _ = try? expression() else {
        FailAssertion(#function, message, file, line)
        return
    }
}

internal func FailAssertion(_ function: String, _ message: String = "",_ file: StaticString = #file,_ line: UInt = #line) {
    XCTFail("\(function) failed: \(message)",file: file, line: line)
}
