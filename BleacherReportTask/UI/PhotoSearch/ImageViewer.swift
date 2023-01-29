//
//  ImageViewer.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 29/01/2023.
//

import SwiftUI

struct ImageViewer: View {
    @Environment(\.presentationMode) private var presentationMode
    
    let photoDto: PhotoDtoList.PhotoDto
    
    var body: some View {
        NavigationView {
            URLImage(
                photoDto.largeUrl,
                placeholder: { smallThumbnail },
                configure: { $0 .resizable() }
            )
            .aspectRatio(contentMode: .fit)
            .ignoresSafeArea()
            .navigationBarItems(leading: closeButton)
        }
    }
    
    private var smallThumbnail: some View {
        URLImage(
            photoDto.smallUrl,
            placeholder: { Color.gray },
            configure: { $0 .resizable() }
        )
    }
    
    private var closeButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            ZStack {
                Circle()
                    .fill(Color.black.opacity(0.5))
                    .frame(width: 32, height: 32)
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.white)
            }
        }
    }
}

#if DEBUG
struct ImageViewer_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewer(photoDto: .preview)
    }
}
#endif
