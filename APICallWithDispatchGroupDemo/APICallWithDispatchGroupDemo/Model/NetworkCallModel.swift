//
//  NetworkCallModel.swift
//  APICallWithDispatchGroupDemo
//
//  Created by Mantosh Kumar on 27/06/24.
//

import UIKit

struct Restaurant: Codable, Hashable{
    let name, discription, address, image: String
}

struct TopPick: Codable, Hashable{
    let name, image: String
}

struct Cuisines: Codable, Hashable{
    let name, image: String
}

enum EndPoints: String {
    case restaurants = "restaurants.json"
    case topPicks = "topPicks.json"
    case cuisines = "cuisines.json"
    
    var url: String {
        return NetworkCallModel.mainURL + self.rawValue
    }
}

class NetworkCallModel {
    
    var restaurant = [Restaurant]()
    var topPicks = [TopPick]()
    var cuisines = [Cuisines]()
    static var mainURL = "https://raw.githubusercontent.com/NukeNalin/foodData/main/"
    // FoodDeliveryDispatchGroupDemo-main
    
    func getHomeDataWithDispatchGroup(completion: @escaping ([Restaurant], [TopPick], [Cuisines], String) -> Void) {
        
        ///Create Object Of DispatchGroup
        let dispatchGroup = DispatchGroup()
        
        // First API Call  --------------------------------
        dispatchGroup.enter()
        getRestaurantsData(EndPoints.restaurants.url) { data in
            self.restaurant = data
            print(" data:- \(data[0].name)")
            // Once we get data then call Leave
            dispatchGroup.leave()
        }
        
        // Second API Call --------------------------------
        dispatchGroup.enter()
        getTopPicksData(EndPoints.topPicks.url) { data in
            self.topPicks = data
            print(" data:- \(data[0].name)")
            // Once we get data then call Leave
            dispatchGroup.leave()
        }
        
        // Third API Call --------------------------------
        dispatchGroup.enter()
        getCuisinesData(EndPoints.cuisines.url) { data in
            self.cuisines = data
            print(" data:- \(data[0].name)")
            // Once we get data then call Leave
            dispatchGroup.leave()
        }
        
        // Notify Main thread
        dispatchGroup.notify(queue: .main) {
            print("Done all notify")
            completion(self.restaurant, self.topPicks, self.cuisines, "Done all API Call nofify from Dispatch Group" )
        }
    }
    
    private func getRestaurantsData(_ url: String, completion: @escaping (_ data: [Restaurant]) -> Void) {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                let convertedData = try! JSONDecoder().decode([Restaurant].self, from: data!)
                completion(convertedData)
            }
        }.resume()
    }
    
    private func getTopPicksData(_ url: String, completion: @escaping (_ data: [TopPick]) -> Void) {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                let convertedData = try! JSONDecoder().decode([TopPick].self, from: data!)
                completion(convertedData)
            }
        }.resume()
    }
    
    private func getCuisinesData(_ url: String, completion: @escaping (_ data: [Cuisines]) -> Void) {
        let url = URL(string: url)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                let convertedData = try! JSONDecoder().decode([Cuisines].self, from: data!)
                completion(convertedData)
            }
        }.resume()
    }
}
