//
//  NoResultEmptyView.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import SwiftUI

struct NoResultEmptyView: View {
    var body: some View {
        EmptyStateView(
            image: Image("empty_state_no_results"),
            title: "No Result found",
            subtitle: "Please enter another keyword"
        )
    }
}

#if DEBUG
struct NoResultEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        NoResultEmptyView()
    }
}
#endif
