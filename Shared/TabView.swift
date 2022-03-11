//
//  tabView.swift
//  skingredients (iOS)
//
//  Created by csuftitan on 3/10/22.
//

import Foundation
import SwiftUI

class TabView : ObservableObject {
    @Published var selectedIndex = 0
    @Published var isPresented = false //shouldShowModal
    
    // House = 1, Magnifyingglass AR = 2 , Magnifyingglass Text = 3,
    let tabBarImagesNames = ["house", "1.magnifyingglass.ar", "text.magnifyingglass"]
   
}

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
                    ScrollView {
                        Text("Insert AR Content")
                            .italic()
                    }
                    .navigationTitle("AR Search")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct databaseView : View {
    @ObservedObject var db = ProductsDatabase()
    
    var body : some View {
        VStack {
            Text("Welcome to SkinGredients!")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.orange)
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
        }).navigationTitle("SkinGredients")
    }
}

struct buttonActions : View {
    @ObservedObject var tV = TabView()
    
    var body : some View {
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
    } // var body : some View
} // buttonActions : View
