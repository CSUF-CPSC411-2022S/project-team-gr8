//
//  ContentView.swift
//  Shared
//
//  Created by csuftitan on 2/21/22.
//

import SwiftUI

struct ContentView: View {
    @State var data: String = ""
    
    var body: some View {
        // Tab view, Ref: https://www.youtube.com/watch?v=9IVLFlyaiq4
        VStack(spacing: 0) {
             
            // Controls the tab views using a switch statement.
            switchView()
            
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

