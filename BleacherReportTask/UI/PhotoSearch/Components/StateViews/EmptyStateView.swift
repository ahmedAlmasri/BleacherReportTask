//
//  EmptyStateView.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 29/01/2023.
//

import SwiftUI

struct EmptyStateView: View {
    private let image: Image
    private let title: LocalizedStringKey
    private let subtitle: LocalizedStringKey
    
    init(image: Image, title: LocalizedStringKey, subtitle: LocalizedStringKey) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack(spacing: 12) {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 48)
            
            Text(title)
                .font(.headline)
            
            Text(subtitle)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
