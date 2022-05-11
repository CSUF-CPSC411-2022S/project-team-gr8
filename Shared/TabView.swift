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
    let tabBarImagesNames = ["house", "magnifyingglass", "person.crop.circle"]
   
}

// Creates a FullScreenModal View for the AR Search.
struct FullScreenModalView : View {
    @Environment(\.presentationMode) var presentationMode
    @SceneStorage("input") var input: String = ""
    @StateObject var tV = TabView()
    @State var text: String = ""
    @EnvironmentObject var db: ProductsDatabase
    var proxy: ScrollViewProxy?
    
    func closeModal() -> Void {
        presentationMode.wrappedValue.dismiss()
    }
    
    var body : some View {
            NavigationView {
                VStack {
                    searchView(closeModal: self.closeModal, p: proxy).environmentObject(db)
                    ScanButton(text: $input)
                    Text("Close") // Needed for x button to appear
                    // Call AR View
                    .onTapGesture{
                        self.closeModal()
                    }
                }
            }
//        .searchable(text: $input,prompt: "Search by Keyword")
        // put the search here (search bar and button)
        // when the search is pressed then "dismiss" the full screen thing and search for the item ( filter db )
        
        
    } // var body: some View
} // struct FullScreenModalView

struct ActivityIndicator: UIViewRepresentable {

    typealias UIViewType = UIActivityIndicatorView
    
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}

// Creates and Controls each tab in the navigation.
struct switchView : View {
    @ObservedObject var tV = TabView()
    @AppStorage("currentPage") var currentPage = 1
    @ObservedObject var db:ProductsDatabase = ProductsDatabase()
    let colors = ["home": Color.blue, "cameraSearch": Color.orange, "brandsFilter": Color.purple]

    var body: some View {
        
        ZStack {
            ScrollViewReader { proxy in
            Spacer() // Needed for fullScreenCover to work
                    .fullScreenCover(isPresented: $tV.isPresented, content: FullScreenModalView.init).environmentObject(db)
            
                switch tV.selectedIndex {
                    case 0:
                            // Call databaseView to display database display format
                    databaseView(proxy:proxy)
                    case 1:
                    // AR View
                        NavigationView {
                            VStack {
                                Text("hello")
                            }
        //                    ARViewContainer().edgesIgnoringSafeArea(.all)
                        }
                    case 2:
                        // Brand Filter
                        NavigationView{
                            VStack{
                                brandsView()
                            }
                        }
                    default:
                        NavigationView{
                            Text("Remaining Tabs")
                        }
                } // Switch statement
            }
            
        }.environmentObject(db) // ZStack
        
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
                    VStack {
                    // Custom Button Display
                    if num == 1 {               // AR Search Button
                        Circle()
                            .stroke(lineWidth: 5).frame(width: 40, height: 40).foregroundColor(tV.selectedIndex == num ? .black : colors["cameraSearch"]).frame(width: 30, height:30)
                        Spacer()
                        Text("Camera Search").font(.system(size: 13)).foregroundColor(tV.selectedIndex == num ? .black : colors["cameraSearch"])
                        
                    }
                    
                    if num == 0 {                    // For other buttons
                        OctacubeIcon()
                            .stroke(lineWidth: 3)
                            .foregroundColor(tV.selectedIndex == num ? colors["home"] : .init(white: 0.8))
                            .frame(width: 30, height:30)
                        Spacer()
                        Text("Home").font(.system(size: 13)).foregroundColor(tV.selectedIndex == num ? colors["home"] : .init(white: 0.8))
                    }
                    
                    if num == 2 {
                        BrandsTabIcon()
                            .stroke(lineWidth: 3)
                            .foregroundColor(tV.selectedIndex == num ? colors["brandsFilter"] : .init(white: 0.8)).frame(width: 30, height:30)
                        Spacer()
                        Text("Explore").font(.system(size: 13)).foregroundColor(tV.selectedIndex == num ? colors["brandsFilter"] : .init(white: 0.8))
                    }
                    }
                    Spacer()
                    
                }).frame(height:60) // Button
            } // ForEach
        } // HStack
        
    } // View
} // struct switchView : View

