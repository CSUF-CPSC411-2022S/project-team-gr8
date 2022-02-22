//
//  filterIngredients.swift
//  skingredients (iOS)
//
//  Created by csuftitan on 2/21/22.
//

import Foundation

class Ingredients {
    var ingredients_arr: [String] = []
    
    func filterIngredients(using filter: ([String]) -> [String],
                           _ hello: String,
                           _ world: () -> String) -> String {
        
        self.ingredients_arr = filter(self.ingredients_arr)
        
        for i in 0...self.ingredients_arr.count-1 {
            print("\(i+1)th element: \(self.ingredients_arr[i])")
        }
        
        if let lastEle = self.ingredients_arr.last {
            return hello + world() + lastEle
        }
        
        return "No ingredients here"
    }
}
