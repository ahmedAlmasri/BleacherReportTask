//
//  URLImage.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 29/01/2023.
//

import SwiftUI
import Kingfisher

struct URLImage<Placeholder: View>: View {
    private var url: URL?
    private let placeholder: () -> Placeholder
    private var configure: ((Image) -> Image)?
    private var failure: ((Error) -> Void)?
    
    init(
        _ url: URL?,
        @ViewBuilder placeholder: @escaping () -> Placeholder = { EmptyView() },
        failure: ((Error) -> Void)? = nil,
        configure: ((Image) -> Image)? = nil
    ) {
        self.url = url
        self.placeholder = placeholder
        self.configure = configure
        self.failure = failure
    }
    
    var body: some View {
        KFImage(url)
            .placeholder {
                placeholder().layoutPriority(-1)
            }
            .onFailure { error in
                failure?(error)
            }
            .configure {
                guard let image = configure?($0) else {
                    return $0
                }
                return image
            }
        
    }
}
