//
//  CustomError.swift
//  Spenny
//
//  Created by Greg Ross on 04/11/2022.
//

import Foundation


enum CustomError: String, Error{
    case spennyEntityWasNil = "Returned Spenny entity was nil"
    
    case couldNotFetchEntity = "Error fetching desired entity"
}
