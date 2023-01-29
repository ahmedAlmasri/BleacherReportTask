//
//  PhotoRowView.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import SwiftUI

struct PhotoRowView: View {
    let photoDto: PhotoDtoList.PhotoDto
    @State private var showFullImageViewer = false
    
    var body: some View {
        VStack {
            URLImage(
                photoDto.smallUrl,
                placeholder: { Color.gray },
                configure: { $0.resizable() }
            )
            .overlay(titleOverlay, alignment: .bottom)
            .frame(height: 150)
            .onTapGesture {
                showFullImageViewer = true
            }
            .fullScreenCover(isPresented: $showFullImageViewer) {
                ImageViewer(photoDto: photoDto)
            }
        }
    }
    
    private var titleOverlay: some View {
        ZStack {
            Text(photoDto.title)
                .font(.caption)
                .padding(6)
                .foregroundColor(.white)
                .lineLimit(1)
                .frame(maxWidth: .infinity)
        }
        .background(Color.black.opacity(0.5))
    }
}

#if DEBUG
struct PhotoRowView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoRowView(photoDto: .preview)
    }
}
#endif
