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
    
    // Tab view, Ref: https://www.youtube.com/watch?v=9IVLFlyaiq4
    
    @State var selectedIndex = 0
    @State var shouldShowModal = false
    
    // House = 1, Magnifyingglass AR = 2 , Magnifyingglass Text = 3,
    let tabBarImagesNames = ["house", "1.magnifyingglass.ar", "text.magnifyingglass"]

    var body: some View {
        
        // Tab view, Ref: https://www.youtube.com/watch?v=9IVLFlyaiq4
        VStack(spacing: 0){
            ZStack {
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowModal, content: {
                        // To dismiss the fullscreen cover
                        Button(action: {shouldShowModal.toggle()}, label: {
                            Text("Insert AR Function")
                        })
                        
                    })
                
                switch selectedIndex {
                case 0:
                // Database View --- HOME Button
                    NavigationView{
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
                        })
                        .navigationTitle(" SkinGredients")
                    }
                case 1:
                    NavigationView{
                        Text("AR Search")
                            .navigationTitle("AR Search")
                    }
                case 2:
                    ScrollView{
                        Text("Search Bar")
                        .navigationTitle("Text Search")
                    }
                default:
                    NavigationView{
                        Text("Remaining Tabs")
                    }

                }
            }
            // Spacer()
            // Divider to separate Content and Nav Bar
            Divider()
                .padding(.bottom, 8)
            
            HStack{
                ForEach(0..<3) { num in
                    Button(action: {
                        // Action for the button
                        if num == 1 {
                            shouldShowModal.toggle()
                            return
                        }
                        
                        selectedIndex = num
                    }, label: {
                        Spacer()
                        
                        // For AR Button, Most Important Feature
                        if num == 1 {
                            Image(systemName: tabBarImagesNames[num])
                                .font(.system(size: 35, weight: .bold))
                                .foregroundColor(.orange)
                            
                        } else {
                            // For other tab buttons, if we decide to add more
                            Image(systemName: tabBarImagesNames[num])
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                        }
                        
                        Spacer()
                        
                    })
                    
                }
            }
            // Bottom Tab Bar
        }
        
    }
}

// TODO: Need a tabview with a search page, and an AR page for the user. This is mainly
//       just user interface for now. Check out https://www.youtube.com/watch?v=TgvYFfCjDMo

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
