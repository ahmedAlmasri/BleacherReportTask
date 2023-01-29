//
//  SearchPhotoScreen.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import SwiftUI

struct SearchPhotoScreen: View {
    @StateObject private var viewModel = SearchPhotosViewModel()
    private let photoColumns = [GridItem(.flexible(), spacing: 2),  GridItem(.flexible(), spacing: 2)]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                SearchView { isSearching in
                    content
                        .onChange(of: isSearching) { isSearching in
                            viewModel.didCancelSearch(isSearching)
                        }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Search Photos")
        }
        .searchable(
            text: $viewModel.keyword,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .onSubmit(of: .search) {
            Task {
                await viewModel.search()
            }
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.viewState {
            case .idle:
                SearchEmptyView()
                
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                
            case .success:
                loadedView
                
            case .notResults:
                NoResultEmptyView()
                
            case let .failure(error):
                ErrorView(error: error)
        }
    }

    
    private var loadedView: some View {
        VStack {
            LazyVGrid(columns: photoColumns, spacing: 2) {
                ForEach(viewModel.photos, id: \.id) {
                    PhotoRowView(photoDto: $0)
                }
            }
            
            loadMoreView
        }
    }
    
    private var loadMoreView: some View {
        LazyVStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .disabled(!viewModel.hasMorePages)
                .task { await viewModel.loadNextPage() }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPhotoScreen()
    }
}
#endif
