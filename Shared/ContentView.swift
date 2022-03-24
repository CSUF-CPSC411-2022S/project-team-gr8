//
//  ContentView.swift
//  Shared
//
//  Created by csuftitan on 2/21/22.
//

import SwiftUI

struct ContentView: View {
    @State private var input = ""
    @State var data: String = ""
    @ObservedObject var db = ProductsDatabase()
    @Environment(\.dismissSearch) var dismissSearch

    var body: some View {
        NavigationView {
            VStack {
                ChildView()
                Text("Welcome to SkinGredients!")
                Button(action: {
                    db.filterData(searchString: input)
                }) {
                    Text("Search")
                }
                List(db.displayedItems, id: \.id) { item in
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
        .searchable(text: $input,prompt: "Search by Keyword")
        .environmentObject(db)
    }
}

struct FilterIngredientsForm: View {
    @State private var input = ""
    @State var results = [MyResult]()
    @ObservedObject var db = ProductsDatabase()
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    db.filterData(searchString: input)
                    results = db.displayedItems
                }) {
                    Text("Search")
                }
                ForEach(results) { item in
                    HStack{
                        Text("\(item.brand) (\(item.name))")
                        Spacer()
                    }
                }
            }.padding(.bottom, 50)
                .onAppear(perform: {
                    //db.getAllData()
            })
        }
        .searchable(text: $input,prompt: "Search by Keyword")
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ChildView : View {
    @Environment(\.isSearching) var isSearching
    @EnvironmentObject var db : ProductsDatabase
    
    var body: some View {
        Text("")
            .onChange(of: isSearching) { newValue in
                if !newValue {
                    print("Searching cancelled")
                    db.displayedItems = db.items
                }
            }
    }
}
