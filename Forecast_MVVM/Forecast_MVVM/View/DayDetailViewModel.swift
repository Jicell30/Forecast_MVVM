//
//  DayDetailViewModel.swift
//  Forecast_MVVM
//
//  Created by Jicell on 10/18/22.
//

import Foundation

protocol DayDetailViewDelegate: AnyObject {
    func updateViews()
}


class DayDetailViewModel {
   //MARK: - Properties
    var forcastData: TopLevelDictionary?
    var days: [Day] {
        self.forcastData?.days ?? []
    }
    //declare a delegate to inform the views when to update
     weak var delegate: DayDetailViewDelegate?
    private let networkingController: NetworkingController
    
    // Initialization of the delegate
    init(delegate: DayDetailViewDelegate, networkingController: NetworkingController = NetworkingController()) {
        self.delegate = delegate
        self.networkingController = networkingController
        fetchForescastData()
    }
    
    private func fetchForescastData() {
        networkingController.fetchDays { result in
            switch result {
            case .success(let forcastData):
                self.forcastData = forcastData
                self.delegate?.updateViews()
            case .failure(let error):
                print("Error fetching the data!",
                      error.errorDescription!)
            }
            
        }
    }
    
}// End of class
