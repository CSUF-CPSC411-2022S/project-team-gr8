//
//  ListProducts.swift
//  skingredients (iOS)
//
//  Created by csuftitan on 4/7/22.
//

import Foundation
import SwiftUI

// Creates how the database is presented.
struct databaseView : View {
    // @State private var input = ""
    @SceneStorage("input") var input: String = "" // SceneStorage on the search textbox
    @EnvironmentObject var db: ProductsDatabase
    @Environment(\.dismissSearch) var dismissSearch
    @State var searching = false
    
    var body : some View {
        VStack {
            ChildView()
            
            Button(action: {
                db.filterData(searchString: input)
            }) {
                Text("Search")
                    .foregroundColor(.orange)
                    .font(.system(size: 20, weight: .semibold))
            }
            ListProducts()
        }.onAppear(perform: {
            db.setDisplayToOriginal()
        }).navigationTitle("SkinGredients") .environmentObject(db)
            .searchable(text: $input,prompt: "Search by Keyword")
            
    }
}

struct brandsView : View {
    @EnvironmentObject var db: ProductsDatabase
    
    var body : some View {
        VStack {
            List {
                ForEach(db.brands, id: \.self) {
                    item in
                    NavigationLink(destination: ListProducts()
                                    .onAppear {db.filterData(searchString: item)}
                    )
                    {
                        Text(item)
                    }
                    
                    //Button(action: {
                    //    db.filterData(searchString: item)
                    //    NavigationLink(destination: ListProducts()) {
                    //        Text("")
                    //    }
                    //}) {
                    //    Text(item)
                    //}
                }
            }
        }.navigationTitle("Search by Brand") .environmentObject(db)
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

struct ListProducts: View {
    @EnvironmentObject var db: ProductsDatabase
    var width_titles: CGFloat = 100

    var body: some View {
        ZStack {
            List(db.displayedItems, id: \.id) { item in
                itemInfo(item: item)
                otherButtons(item: item)
            }
            if (db.loading){
                VStack {
                    ActivityIndicator(style: .large)
                }
            }
        }
    }
}
struct otherButtons : View {
    var item: MyResult
    var ap = AmazonPrices()
    
    var body: some View {
        HStack{
            // button for amazon
            Button(action: {ap.AmazonPrices(_brand: item.brand,_item: item.name)}){
                HStack{
                    Spacer()
                    Text("See Prices on Amazon")
                    Image(systemName: "dollarsign.circle.fill")
                    Spacer()
                }
            }.buttonStyle(BorderlessButtonStyle())
        }.listRowSeparator(.hidden)
        HStack{
            // button for brand shopping
            Button(action: {ap.Amazonbrand(_brand: item.brand)}){
                HStack{
                    Spacer()
                    Text("Shop for Same Brand")
                    Image(systemName: "bag.fill")
                    Spacer()
                }
            }.buttonStyle(BorderlessButtonStyle())
        }.listRowSeparator(.hidden)
        HStack{
            // button for more info (google search)
            Button(action: {ap.GSearch(_brand: item.brand, _item: item.name)}){
                HStack {
                    Spacer()
                    Text("More Information")
                    Image(systemName: "arrowshape.turn.up.right.fill")
                    Spacer()
                }
            }.buttonStyle(BorderlessButtonStyle())
        }.listRowSeparator(.hidden)
    }
}
struct itemInfo : View {
    var item: MyResult
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Brand").bold()
                Image(systemName: "person.circle")
                Spacer()
            }.overlay(
                Capsule().fill(Color.gray).frame(height: 2).offset(y: 4), alignment: .bottom).padding(5)
            Spacer()
            Text(item.brand)
            Spacer()
        }.padding(.top, 25).listRowSeparator(.hidden)
        VStack {
            HStack {
                Spacer()
                Text("Product").bold()
                Image(systemName: "rectangle.and.paperclip")
                Spacer()
            }.overlay(
                Capsule().fill(Color.gray).frame(height: 2).offset(y: 4)
                , alignment: .bottom).padding(10)
            Spacer()
            Text(item.name)
            Spacer()
        }.listRowSeparator(.hidden)
        VStack {
            HStack {
                Spacer()
                Text("Ingredients").bold()
                Image(systemName: "eyedropper")
                Spacer()
            }.overlay(
                Capsule().fill(Color.gray).frame(height: 2).offset(y: 4)
                , alignment: .bottom).padding(10)
            HStack {
                Spacer()
                Text(item.ingredient_list.joined(separator: ", "))
                Spacer()
            }.padding(10)
        }.listRowSeparator(.hidden).overlay(
            Capsule().fill(Color.gray).frame(height: 2).offset(y: 4)
            , alignment: .bottom)
    }
}
