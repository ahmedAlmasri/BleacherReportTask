//
//  ErrorView.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 29/01/2023.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    
    var body: some View {
        VStack(spacing: 12) {
            Image("error_empty")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 48)
            
            Text("Oops something wrong".uppercased())
                .font(.headline)
            
            Text(error.localizedDescription)
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
    }
}
#if DEBUG
struct ErrorView_Previews: PreviewProvider {
    enum PreviewError: LocalizedError {
        case preview
        
        var errorDescription: String? {
            return "Parameterless searches have been disabled. Please use flickr.photos.getRecent instead."
        }
    }
    static var previews: some View {
        ErrorView(error: PreviewError.preview)
    }
}
#endif
