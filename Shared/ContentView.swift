//
//  ContentView.swift
//  Shared
//
//  Created by csuftitan on 2/21/22.
//

import SwiftUI

struct ContentView: View {
    @State var data: String = ""
    @ObservedObject var db = ProductsDatabase()

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to SkinGredients!")
                List(db.items, id: \.id) { item in
                    HStack {
                        Text("DB ID: ").bold()
                        Text(String(item.id))
                    }
                    HStack {
                        Text("Brand: ").bold()
                        Text(item.brand)
                    }
                    HStack {
                        Text("Product: ").bold()
                        Text(item.name)
                    }
                    HStack {
                        Text("Ingredients: ").bold()
                        Text(item.ingredient_list.joined(separator: ", "))
                    }
                }
            }.onAppear(perform: {
                db.getAllData()
            })
        }.navigationTitle("SkinGredients")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
