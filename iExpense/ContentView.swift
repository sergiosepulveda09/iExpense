//
//  ContentView.swift
//  iExpense
//
//  Created by Sergio Sepulveda on 2021-07-03.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable{
    var name: String
    var type: String
    var amount: Int
    var id = UUID()
}
class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
    
}

struct ContentView: View {
    @State private var showingView: Bool = false
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment:.leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text("$\(item.amount)").customText(value: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .navigationBarItems(leading: EditButton(),
                                trailing:
                                    Button(action: {
                                    self.showingView = true
                                    }, label: {
                                        Image(systemName: "plus")
                                    }))
            .sheet(isPresented: $showingView) {
                AddView(expenses: self.expenses)
            }
        }
        
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
