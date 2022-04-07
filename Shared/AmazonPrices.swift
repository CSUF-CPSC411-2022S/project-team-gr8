
//  AmazonPrices.swift
//  skingredients (iOS)
//
//  Created by Tristan Stewart on 3/9/22
//

import Foundation
import SwiftUI


class AmazonPrices {

   func AmazonPrices(_brand: String, _item: String){
       // a search for an item in amazon
       let temp = _brand + " " + _item
       let plus = temp.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
       
       if let url = URL(string: "https://www.amazon.com/s?k=" + plus){
           UIApplication.shared.open(url)
       }
   }

   func Amazonbrand(_brand: String){
       // a general amazon search on item's brand
       let plus = _brand.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
       
       if let url = URL(string: "https://www.amazon.com/s?k=" + plus){
           UIApplication.shared.open(url)
       }
   }
   
   
   func GSearch(_brand: String, _item: String){
       // it works
       // need to add brand with item for more info
       let temp = _brand + " " + _item
       let plus = temp.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
       if let url = URL(string: "https://www.google.com/search?q=" + plus){
           UIApplication.shared.open(url)
       }
       
   }
}
