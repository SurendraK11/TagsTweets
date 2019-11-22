//
//  CustomError.swift
//  Tags
//
//  Created by Surendra on 13/11/2019.
//  Copyright © 2019 Surendra. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case urlError
    case dataNotFoundError
    case dataParsingError
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .urlError:
            return NSLocalizedString("URL error!", comment: "Invalid URL")
        case .dataNotFoundError:
            return NSLocalizedString("Data not found!", comment: "Data not found")
        case .dataParsingError:
            return NSLocalizedString("Not expected data!", comment: "Data error")
        }
    }
}

