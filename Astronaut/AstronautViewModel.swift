//
//  AstronautViewModel.swift
//  Astronaut
//
//  Created by Anki on 22/03/21.
//

import Foundation
import os.log

class AstronautViewModel:NSObject{
    
    private var apiService : APIService!
    private(set) var astronauts : [Result]! = [] {
        didSet {
            self.bindViewModelToController()
        }
    }
    private(set) var totalItems : Int = 0
    private(set) var nextURL : String?
    let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "network")
    var bindViewModelToController : (() -> ()) = {}

    override init() {
        super.init()
        self.apiService = APIService()
        callFuncToGetAstronauts(path: Strings.baseURL)
    }
    func callFuncToGetAstronauts(path: String){
        self.apiService.apiToGetAstronauts(path: path) { (astronauts, error) in
            guard let results = astronauts?.results else {
                os_log("empty response", log: self.log)
                return
            }
            //Appending the response to Array.
            self.astronauts.append(contentsOf: results)
            self.totalItems = astronauts?.count ?? 0
            self.nextURL = astronauts?.next
        }
    }
    func sortByNameWithOrder(ascending : Bool){
        //NOTE : - Implementing this method because /3.5.0/astronaut/?order=name did not sort.
        if ascending {
            self.astronauts = self.astronauts.sorted(by:{ $0 < $1 })
        }else{
            self.astronauts = self.astronauts.sorted(by:{ $0 > $1 })
        }
    }
    
}
