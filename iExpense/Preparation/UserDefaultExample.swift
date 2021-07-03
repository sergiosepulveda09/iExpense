//
//  UserDefaultExample.swift
//  iExpense
//
//  Created by Sergio Sepulveda on 2021-07-03.
//

import SwiftUI

struct UserDefaultExample: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    var body: some View {
        Button("Increase tap count: \(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
    }
}

struct UserDefaultExample_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultExample()
    }
}
