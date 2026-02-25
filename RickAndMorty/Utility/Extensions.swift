//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Parthiv Ganguly on 2/25/26.
//

import SwiftUI

extension View {
    
    // MARK: - Parse and Format Date
    
    func parseAndFormatDate(_ dateString: String) -> String {
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        guard let date = isoFormatter.date(from: dateString) else {
            return "Invalid date"
        }
        
        let readableFormatter = DateFormatter()
        readableFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        readableFormatter.timeZone = TimeZone.current
        
        return readableFormatter.string(from: date)
    }
}
