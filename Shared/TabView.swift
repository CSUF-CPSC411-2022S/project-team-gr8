//
//  TabView.swift
//  skingredients (iOS)
//
//  Created by csuftitan on 3/10/22.

import Foundation
import SwiftUI

class TabView : ObservableObject {
    @Published var selectedIndex = 0
    @Published var isPresented = false //shouldShowModal
    
    // House = 1, Magnifyingglass AR = 2 , Magnifyingglass Text = 3,
    let tabBarImagesNames = ["house", "1.magnifyingglass.ar", "text.magnifyingglass"]
   
}

// Creates a FullScreenModal View for the AR Search.
struct FullScreenModalView : View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var tV = TabView()
    
    var body : some View {
        Spacer() // Needed for x button to appear
        VStack{
            Button(action: {tV.isPresented.toggle()}, label: {
                 Image(systemName: "x.circle.fill")
                     .foregroundColor(.orange)
                     .font(.system(size: 20, weight: .bold))
                     .onTapGesture{
                         presentationMode.wrappedValue.dismiss()
                     }
             })
            
            NavigationView {
                    ARViewContainer().edgesIgnoringSafeArea(.all)
                    ScrollView {
//                        Text("Insert AR Content")
//                            .italic()
                    }
                    .navigationTitle("AR Search")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
    
}

// Creates how the database is presented.
struct databaseView : View {
    @State private var input = ""
    @ObservedObject var db = ProductsDatabase()
    @Environment(\.dismissSearch) var dismissSearch
    
    var body : some View {
        VStack {
            ChildView()
            Text("Welcome to SkinGredients!")
            Button(action: {
                db.filterData(searchString: input)
            }) {
                Text("Search")
            }
            ListProducts()
        }.onAppear(perform: {
            db.getAllData()
        }).navigationTitle("SkinGredients") .environmentObject(db)
            .searchable(text: $input,prompt: "Search by Keyword")
    }
}
struct ActivityIndicator: UIViewRepresentable {

    typealias UIViewType = UIActivityIndicatorView
    
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>){
        uiView.startAnimating()
    }
}
struct ListProducts: View {
    @EnvironmentObject var db: ProductsDatabase
    var width_titles: CGFloat = 100
    var body: some View {
        ZStack {
            List(db.displayedItems, id: \.id) { item in
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
            if (db.loading){
                VStack {
                    ActivityIndicator(style: .large)
                }
            }
        }
    }
}

// Creates and Controls each tab in the navigation. 
struct switchView : View {
    @ObservedObject var tV = TabView()
    
    var body: some View {
        ZStack {
            Spacer() // Needed for fullScreenCover to work
                .fullScreenCover(isPresented: $tV.isPresented, content: FullScreenModalView.init)
            
            switch tV.selectedIndex {
            case 0:
                NavigationView {
                    // Call databaseView to display database display format
                    databaseView()
                }
            case 1:
            // AR View
                NavigationView {
                    ARViewContainer().edgesIgnoringSafeArea(.all)
                    Text("AR Search")
                        .navigationTitle("AR Search")
                }
            case 2:
            // Search Text View
                NavigationView {
                    ScrollView{
                        Text("Insert Search Bar")
                            .italic()
                            
                    }
                    .navigationTitle("Text Search")
                }
            default:
                NavigationView{
                    Text("Remaining Tabs")
                }
            } // Switch statement
            
        } // ZStack
        
        // Divider to separate Content and Nav Bar
        Divider()
            .padding(.bottom, 8)
        
        // Setting up the 3 control buttons.
        HStack {
            ForEach(0..<3) { num in
                Button(action: {
                    // Actions for the buttons
                    if num == 1 {                   // AR Search Button
                        tV.isPresented.toggle()
                        return
                    }
                    
                    tV.selectedIndex = num
                }, label: {
                    Spacer()
                    
                    // Custom Button Display
                    if num == 1 {               // AR Search Button
                        Image(systemName: tV.tabBarImagesNames[num])
                            .font(.system(size: 35, weight: .bold))
                            .foregroundColor(.orange)
                        
                    } else {                    // For other buttons
                        Image(systemName: tV.tabBarImagesNames[num])
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(tV.selectedIndex == num ? Color(.black) : .init(white: 0.8))
                    }
                    
                    Spacer()
                    
                }) // Button
            } // ForEach
        } // HStack
        
    } // View
} // struct switchView : View


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
