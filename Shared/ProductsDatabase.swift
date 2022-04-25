//
//  ProductsDatabase.swift
//  skingredients (iOS)
//
//  Created by csuftitan on 2/27/22.
//

import Foundation

class ProductsDatabase: ObservableObject {
    let url = "https://skincare-api.herokuapp.com/products"
    @Published var items = [MyResult]()
    @Published var loading = true
    @Published var displayedItems = [MyResult]()
    @Published var brands = Array<String>()
    
    init() {
        getAllData()
    }
    
    func getAllData() {
        self.loading = true
        guard let url = URL(string: self.url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if let data = data {
                    var result = try JSONDecoder().decode([MyResult].self, from: data)
                    self.capitalizeNames(of: &result)
                    DispatchQueue.main.async{
                        self.items = result
                        self.displayedItems = result
                        self.loading = false
                        for item in self.items {
                            if !self.brands.contains(item.brand) {
                                self.brands.append(item.brand)
                            }
                        }
                        self.brands = self.brands.sorted()
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
    func filterData(searchString: String) {
        if searchString.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return
        }
        var filteredItems = [MyResult]()
        for item in items {
            var all_str = item.brand + " " + item.name + " "
            all_str += item.ingredient_list.joined(separator: " ")
            
            if all_str.lowercased().contains(searchString.lowercased()){
                filteredItems.append(item)
            }
        }
        displayedItems = filteredItems
    }
}

struct MyResult: Decodable, Equatable {
    let id: Int
    var brand: String
    var name: String
    var ingredient_list: [String]
}
