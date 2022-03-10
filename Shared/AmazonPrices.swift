
 //  AmazonPrices.swift
 //  skingredients (iOS)
 //
 //  Created by Tristan Stewart on 3/9/22
 //

 import Foundation
 import SwiftUI
 

class AmazonPrices {
//TODO:
    // modify the following methods in order to search for a specific Item
    // parameters take in a string that contains brand and/or item
    // implemented through the use of buttons
    // Options are either find an alternative means of searching the web from application or
    // add specific links to the productDatabase for easier access
    // find a way around the UI error when using classes
    func AmazonPrices(_item: String){
        // not working yet
        if let url = URL(string: "https://www.amazon.com/" + _item){
            UIApplication.shared.open(url)
        }
    }

    func GSearch(_item: String){
        // not working yet
        if let url = URL(string: "https://www.google.com/" + _item){
            UIApplication.shared.open(url)
        }
        
    }
}
