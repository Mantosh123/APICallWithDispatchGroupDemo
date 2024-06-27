//
//  ViewController.swift
//  APICallWithDispatchGroupDemo
//
//  Created by Mantosh Kumar on 27/06/24.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = NetworkCallModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel.getHomeDataWithDispatchGroup { (restaurants, topPick, cuisines, nofifyValue) in
            print("restaurants[0].name - \(restaurants[0].name)")
            print("topPick[0].name - \(topPick[0].name)")
            print("cuisines[0].name - \(cuisines[0].name)")
            print("\(nofifyValue)")
        }
    }
    
}

