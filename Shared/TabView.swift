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
    @StateObject var tV = TabView()
    
    var body : some View {
        //Spacer() // Needed for x button to appear
        // Call AR View
        ARViewContainer()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture{
            presentationMode.wrappedValue.dismiss()
        }
        
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
    @ObservedObject var db = ProductsDatabase()
    
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
                    VStack {
                        Text("hello")
                    }
                    ARViewContainer().edgesIgnoringSafeArea(.all)
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
                    
                    // Custom Button Display
                    if num == 1 {               // AR Search Button
                        Image(systemName: tV.tabBarImagesNames[num])
                            .font(.system(size: 35, weight: .bold))
                            .foregroundColor(.orange)
                        
                    }
                    
                    if num == 0 {                    // For other buttons
                        Image(systemName: tV.tabBarImagesNames[num])
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(tV.selectedIndex == num ? Color(.black) : .init(white: 0.8))
                    }
                    
                    if num == 2 {
                        BrandsTabIcon()
                            .stroke(lineWidth: 3)
                            .foregroundColor(tV.selectedIndex == num ? Color(.black) : .init(white: 0.8))
                            .frame(width: 30, height:30)
                    }
                    
                    Spacer()
                    
                }) // Button
            } // ForEach
        } // HStack
        
    } // View
} // struct switchView : View

struct BrandsTabIcon: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.maxX / 2, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 4))
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.maxY/2))
        path.addLine(to: CGPoint(x: rect.maxX/2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: (rect.maxY) * (3/4)))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY / 4))
    
        path.move(to: CGPoint(x: rect.maxX / 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: (rect.maxY) * (3/4)))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY / 4))
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: rect.maxY/2))
        path.move(to: CGPoint(x: 0, y: rect.maxY/4))
        path.addLine(to: CGPoint(x: rect.maxX / 2, y: 0))
        
        return path
    }
}
