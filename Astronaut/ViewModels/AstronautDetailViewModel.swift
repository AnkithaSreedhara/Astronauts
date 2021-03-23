//
//  AstronautDetailViewModel.swift
//  Astronaut
//
//  Created by Anki on 23/03/21.
//

import Foundation
class AstronautDetailViewModel:NSObject{
    
    private var apiService : APIService!
    private(set) var astronaut : Result!  {
        didSet {
            self.bindViewModelToController()
        }
    }
    private(set) var totalItems : Int = 0
    private(set) var nextURL : String?
    
    var bindViewModelToController : (() -> ()) = {}

    init(path : String){
        super.init()
        self.apiService = APIService()
        self.callFuncToGetAstronauts(path: path)
    }
    func callFuncToGetAstronauts(path: String){
        self.apiService.apiToGetAstronautDetail(path: path) { (astronaut,error) in
            self.astronaut = astronaut
        }
    }

}
