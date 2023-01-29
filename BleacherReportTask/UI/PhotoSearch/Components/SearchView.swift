//
//  SearchView.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 29/01/2023.
//

import SwiftUI

struct SearchView<Content: View>: View {
    @Environment(\.isSearching) private var isSearching: Bool
    
    private let content: (Bool) -> Content
    
    init(@ViewBuilder content: @escaping (Bool) -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack {
            content(isSearching)
        }
    }
}
