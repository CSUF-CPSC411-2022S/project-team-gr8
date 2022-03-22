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
                ListProducts()
            }.onAppear(perform: {
                db.getAllData()
            })
        }.navigationTitle("SkinGredients").environmentObject(db)
    }
}

struct ListProducts: View {
    @EnvironmentObject var db: ProductsDatabase
    var width_titles: CGFloat = 100
    var body: some View {
        VStack {
            List(db.items, id: \.id) { item in
                HStack {
                    Text("Brand: ").bold().frame(width: self.width_titles)
                    Text(item.brand)
                }
                HStack {
                    Text("Product: ").bold().frame(width: self.width_titles)
                    Text(item.name)
                }
                HStack(alignment: .top) {
                    Text("Ingredients: ").bold().frame(width: self.width_titles)
                    Text(item.ingredient_list.joined(separator: ", "))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
