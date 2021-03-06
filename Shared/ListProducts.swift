//
//  ListProducts.swift
//  skingredients (iOS)
//
//  Created by csuftitan on 4/7/22.
//

import Foundation
import SwiftUI

// Creates how the database is presented.

struct searchView: View {
    @SceneStorage("input") var input: String = ""
    @EnvironmentObject var db: ProductsDatabase
    var closeModal: (()->Void)?
    var p: ScrollViewProxy?
    
    var body: some View {
        VStack {
            ChildView(p: p)
            
            Button(action: {
                db.filterData(searchString: input)
                if let proxy = p {
                    if db.displayedItems.count > 0 {
                        proxy.scrollTo(db.displayedItems[0].id, anchor: .top)
                    }
                }
                if let closeModal = closeModal {
                    closeModal()
                }
            }) {
                Text("Search")
                    .foregroundColor(.orange)
                    .font(.system(size: 20, weight: .semibold))
            }
        }.searchable(text: $input,prompt: "Search by Keyword")
    }
    
}
struct databaseView : View {
    // @State private var input = ""
     // SceneStorage on the search textbox
    @EnvironmentObject var db: ProductsDatabase
    @Environment(\.dismissSearch) var dismissSearch
    @State var searching = false
    var proxy: ScrollViewProxy?
    var body : some View {
        NavigationView {
           
                VStack {
                    searchView(p:proxy)
                    ListProducts()
                }.onAppear(perform: {
                    db.setDisplayToOriginal()
                }).navigationTitle("SkinGredients").environmentObject(db)
            }
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
                                    .onAppear {
                        db.filterData(searchString: item)
                    }
                    ) {
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
    var p: ScrollViewProxy?
    
    var body: some View {
        Text("")
            .onChange(of: isSearching) { newValue in
                if !newValue {
                    print("Searching cancelled")
                    db.displayedItems = db.items
                    if let proxy = p {
                        if db.items.count > 0 {
                            proxy.scrollTo(db.items[0].id, anchor: .top)
                        }
                    }
                    
                }
            }
    }
}

struct ListProducts: View {
    @EnvironmentObject var db: ProductsDatabase
    var width_titles: CGFloat = 100
    @SceneStorage("input") var input: String = ""

    var body: some View {
        ZStack {
            List(db.displayedItems, id: \.id) { item in
                if !db.loading {
                    itemInfo(item: item)
                    otherButtons(item: item)
                }
            }
            if (db.loading){
                VStack {
                    ActivityIndicator(style: .large)
                }
            }
            else {
                if (db.displayedItems.isEmpty) {
                    VStack {
                        Text("Sorry, nothing about that was found!")
                    }
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
                    ShopBrandIcon()
                        .stroke(lineWidth: 2)
                        .frame(width: 22, height:22)
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


struct ShopBrandIcon: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: (rect.maxX) * 5/12, y: 0))
        path.addLine(to: CGPoint(x: (rect.maxX) * 7/12, y: 0))
        path.addLine(to: CGPoint(x: (rect.maxX) * 3/4, y: rect.maxY/3))
        path.addLine(to: CGPoint(x: (rect.maxX) * 2/3, y: rect.maxY/3))
        path.addLine(to: CGPoint(x: (rect.maxX) * 1/2, y: 0))
        path.addLine(to: CGPoint(x: (rect.maxX) * 1/3, y: rect.maxY/3))
        path.addLine(to: CGPoint(x: (rect.maxX) * 1/4, y: rect.maxY/3))
        path.addLine(to: CGPoint(x: (rect.maxX) * 5/12, y: 0))
    
        path.move(to: CGPoint(x: 0, y: rect.maxY/3))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY/3))
        path.addLine(to: CGPoint(x: (rect.maxX) * 5/6, y: rect.maxY))
        path.addLine(to: CGPoint(x: (rect.maxX) * 1/6, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY/3))
        
        path.move(to: CGPoint(x: 0, y: rect.maxY/3))
        path.addLine(to: CGPoint(x: (rect.maxX) * 1/12, y: (rect.maxY) * 2/3))
        path.addLine(to: CGPoint(x: (rect.maxX) * 11/12, y: (rect.maxY) * 2/3))
        
        path.move(to: CGPoint(x: (rect.maxX) * 1/3, y: rect.maxY/3))
        path.addLine(to: CGPoint(x: (rect.maxX) * 1/3, y: rect.maxY))

        path.move(to: CGPoint(x: (rect.maxX) * 2/3, y: rect.maxY/3))
        path.addLine(to: CGPoint(x: (rect.maxX) * 2/3, y: rect.maxY))
        
        return path
    }
}
