//
//  RequestErrorMapper.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 29/01/2023.
//

import Foundation
import Networking

struct RequestErrorMapper: LocalizedError {
    let message: String
    
    var errorDescription: String? {
        message
    }

    init(error: Error) {
        guard let error = error as? RequestError else {
            message = error.localizedDescription
            return
        }
        
        switch error {
            case let .decodingError(_, data, _):
                message = data.toErrorMessage
                
            case let .inlineError(data, _):
                message = data.toErrorMessage
                
            default:
                message = error.localizedDescription
        }
    }
    
}

fileprivate extension Data {
    var toErrorMessage: String {
        let encoder = JSONDecoder.default
        do {
            let errorResponse = try encoder.decode(ErrorResponse.self, from: self)
            return errorResponse.message
        } catch {
            return error.localizedDescription
        }
    }
}
