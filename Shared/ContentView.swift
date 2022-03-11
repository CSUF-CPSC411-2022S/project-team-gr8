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
    @ObservedObject var tV = TabView()
    
    var body: some View {
        // Tab view, Ref: https://www.youtube.com/watch?v=9IVLFlyaiq4
        VStack(spacing: 0){
            ZStack {
                Spacer() // Needed for fullScreenCover to work
                    .fullScreenCover(isPresented: $tV.isPresented, content: FullScreenModalView.init)
                
           // Controls Different Pages
                switch tV.selectedIndex {
                case 0:
                    NavigationView {
                        // Call databaseView to display database display format
                        databaseView()
                    }
                case 1:
                // AR View
                    NavigationView {
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
                }
            }
    
            // Divider to separate Content and Nav Bar
            Divider()
                .padding(.bottom, 8)
            
            // Call buttonActions for the behavior of the buttons.
                buttonActions()
            
        } // VStack (spacing: 0)
        
    } // var body : some View
        
} // struct ContentView : View

// TODO: Need a tabview with a search page, and an AR page for the user. This is mainly
//       just user interface for now. Check out https://www.youtube.com/watch?v=TgvYFfCjDMo

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
