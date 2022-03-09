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
    init() {
        
    }
    func getData() {
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
}


//struct Response: Codable {
//    let results: MyResult
//    let status: String
//}

struct MyResult: Decodable {
    let id: Int
    let brand: String
    let name: String
    let ingredient_list: [String]
}
