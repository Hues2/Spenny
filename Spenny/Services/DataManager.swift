//
//  DataManager.swift
//  Spenny
//
//  Created by Greg Ross on 12/09/2022.
//

import Foundation
import Combine


class DataManager: ObservableObject{
    
    @Published var spennyData: SpennyData? = nil
    
    init(){
        
    }
    
}
