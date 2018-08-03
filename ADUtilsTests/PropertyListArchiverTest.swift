//
//  PropertyListArchiverTest.swift
//  ADUtils
//
//  Created by Pierre Felgines on 05/01/17.
//
//

import Foundation
import Quick
import Nimble
import ADUtils

struct User {
    let name: String
    let age: Int
}

extension User : Equatable {

    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name
            && lhs.age == rhs.age
    }
}

extension User : PropertyListReadable {

    private struct Constants {
        static let name = "name"
        static let age = "age"
    }

    init?(propertyListRepresentation: NSDictionary?) {
        guard let values = propertyListRepresentation else {
            return nil
        }
        guard let name = values[Constants.name] as? String,
            let age = values[Constants.age] as? Int else {
                return nil
        }
        self.name = name
        self.age = age
    }

    func propertyListRepresentation() -> NSDictionary {
        return [
            Constants.age: age,
            Constants.name: name
        ]
    }
}

class PropertyListArchiverTest: QuickSpec {

    override func spec() {

        var defaults: UserDefaults!
        var archiver: PropertyListArchiver!

        beforeEach {
            defaults = UserDefaults()
            archiver = PropertyListArchiver(defaults: defaults)
        }

        it("should save and read one value") {
            // Given
            let user = User(name: "Georges", age: 40)

            // When
            archiver.save(value: user, forKey: "user")
            let readUser: User? = archiver.readValue(forKey: "user")

            // Then
            expect(readUser).toNot(beNil())
            if let readUser = readUser {
                expect(readUser).to(equal(user))
            }

            let defaultValue: Any? = defaults.value(forKey: "user")
            expect(defaultValue).toNot(beNil())
        }

        it("should save and read multiple values") {
            // Given
            let users = [
                User(name: "Georges", age: 40),
                User(name: "Abitbol", age: 39)
            ]

            // When
            archiver.save(values: users, forKey: "users")
            let readUsers: [User] = archiver.readValues(forKey: "users")

            // Then
            expect(readUsers.count).to(equal(2))
            expect(readUsers).to(equal(users))

            let defaultValue: Any? = defaults.value(forKey: "users")
            expect(defaultValue).toNot(beNil())
        }

        it("should delete value") {
            // Given
            let user = User(name: "Georges", age: 40)

            // When
            archiver.save(value: user, forKey: "user")
            archiver.deleteValue(forKey: "user")
            let readUser: User? = archiver.readValue(forKey: "user")

            // Then
            expect(readUser).to(beNil())

            let defaultValue: Any? = defaults.value(forKey: "user")
            expect(defaultValue).to(beNil())
        }

    }
}
