//
//  ProductsDatabase.swift
//  skingredients (iOS)
//
//  Created by csuftitan on 2/27/22.
//

import Foundation

class ProductsDatabase: ObservableObject {
    let url = "https://skincare-api.herokuapp.com/products"
    @Published var items: [MyResult] = []

    func getAllData() {
        guard let url = URL(string: self.url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if let data = data {
                    var result = try JSONDecoder().decode([MyResult].self, from: data)
                    
                    DispatchQueue.main.async{
                        self.capitalizeNames(of: &result)
                        self.items = result
                    }
                }
                else {
                    print("no data")
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
    
    func capitalizeNames(of arr: inout [MyResult]) {
        for index in arr.indices {
            arr[index].brand = arr[index].brand.capitalized
            arr[index].name = arr[index].name.capitalized
            for ingred_index in arr[index].ingredient_list.indices {
              arr[index].ingredient_list[ingred_index] = arr[index].ingredient_list[ingred_index].capitalized
            }
        }
    }
    // TODO: Filter the data based on a keyword. We have a few options here.
    // 1. Locally sort out the items in items array. This might be costly for devices because
    //    of how many items there are.
    // 2. Create a method and another data member or something that will make a call to the API using
    //    the "Like" GET call. Check out the Skincare github for info on that.
    
}

struct MyResult: Decodable, Identifiable {
    var id: Int
    var brand: String
    var name: String
    var ingredient_list: [String]
}
