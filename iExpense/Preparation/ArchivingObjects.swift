//
//  ArchivingObjects.swift
//  iExpense
//
//  Created by Sergio Sepulveda on 2021-07-06.
//

import SwiftUI

struct ArchivingObjects: View {
    @State private var user: User1 = User1(name: "Sergio", lastName: "Sepulveda")
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(self.user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}
struct User1: Codable {
    var name: String
    var lastName: String
}

struct ArchivingObjects_Previews: PreviewProvider {
    static var previews: some View {
        ArchivingObjects()
    }
}
