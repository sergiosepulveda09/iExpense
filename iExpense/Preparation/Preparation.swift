//
//  ContentView.swift
//  iExpense
//
//  Created by Sergio Sepulveda on 2021-07-02.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var numbers: [Int] = [Int]()
    @State private var currentNumber : Int = 1
    var name: String
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello \(name)")
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add A number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Dismiss")
                })
            }
            .navigationBarItems(leading: EditButton())
        }
    }
    
    func removeRows(at offset: IndexSet) {
        numbers.remove(atOffsets: offset)
    }
    
}

struct FirstView: View {
    @State private var showingSheet: Bool = false
    @ObservedObject private var user = User()
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            TextField("FirstName", text: $user.firstName)
            TextField("LastName", text: $user.lastName)
            Button(action: {
                self.showingSheet.toggle()
            }, label: {
                Text("Show Sheet")
            })
            .sheet(isPresented: $showingSheet) {
                SecondView(name: user.firstName)
            }
        }
    }
}

class User: ObservableObject {
    @Published var firstName = "Sergio"
    @Published var lastName = "Sepulveda"
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
