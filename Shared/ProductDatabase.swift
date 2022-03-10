//
//  ProductsDatabase.swift
//  skingredients (iOS)
//
//  Created by csuftitan on 2/27/22.
//  Implementing Patricia's ProductDatabase
   
import Foundation

class ProductsDatabase: ObservableObject {
    let url = "https://skincare-api.herokuapp.com/products"
    @Published var items = [MyResult]()

    func getAllData() {
        guard let url = URL(string: self.url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if let data = data {
                    let result = try JSONDecoder().decode([MyResult].self, from: data)
                    
                    DispatchQueue.main.async{
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
    
    // TODO: Filter the data based on a keyword. We have a few options here.
    // 1. Locally sort out the items in items array. This might be costly for devices because
    //    of how many items there are.
    // 2. Create a method and another data member or something that will make a call to the API using
    //    the "Like" GET call. Check out the Skincare github for info on that.
    
}

struct MyResult: Decodable {
    let id: Int
    let brand: String
    let name: String
    let ingredient_list: [String]
}
