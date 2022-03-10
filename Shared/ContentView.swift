//
//  ContentView.swift
//  Shared
//
//  Created by csuftitan on 2/21/22.
//

import SwiftUI

struct ContentView: View {
    @State var data: String = ""
    @State var searchTerm: String = ""
    @ObservedObject var db = ProductsDatabase()

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to SkinGredients!")
                InputBox(searchTerm: $searchTerm)
                Spacer()
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

struct InputBox: View {
    @Binding var searchTerm: String
    var body: some View {
        HStack {
            Spacer()
            Text("Search:").bold().padding(.leading, 20)
            TextField("Cleanser, rose water...", text: $searchTerm)
            Spacer()
        }.padding(30)
    }
}
