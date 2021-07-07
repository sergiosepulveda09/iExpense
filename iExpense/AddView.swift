//
//  AddView.swift
//  iExpense
//
//  Created by Sergio Sepulveda on 2021-07-06.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name: String = ""
    @State private var type = "Personal"
    @State private var amount: String = ""
    @State private var showAlert: Bool = false
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add New Expense")
            .navigationBarItems(
            trailing:
                Button("Save") {
                    if let actualAmount = Int(self.amount) {
                        let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                        self.expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    showAlert = true
                }
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Important Message"), message: Text("There can only be numbers in the Amount slot"), dismissButton: .default(Text("OK")))
                })
            )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
