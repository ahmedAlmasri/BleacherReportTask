//
//  SearchEmptyView.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import SwiftUI

struct SearchEmptyView: View {
    var body: some View {
        EmptyStateView(
            image: Image("empty_state_search"),
            title: "Lets get started",
            subtitle: "Start your search now to find your lovely photos"
        )
    }
}

#if DEBUG
struct SearchEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        SearchEmptyView()
    }
}
#endif


