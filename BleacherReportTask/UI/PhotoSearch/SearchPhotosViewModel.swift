//
//  SearchPhotosViewModel.swift
//  BleacherReportTask
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Foundation

@MainActor
final class SearchPhotosViewModel: ObservableObject {
    enum ViewState {
        case idle
        case loading
        case success
        case failure(Error)
        case notResults
    }
    
    @Published var keyword: String = ""
    @Published private(set) var viewState: ViewState = .idle
    @Published private(set) var photos: [PhotoDtoList.PhotoDto] = []
    @Published private(set) var hasMorePages = false
    
    private(set) var page: UInt = 1
    private var totalPages: UInt = 0
    private let useCase: SearchPhotosUseCase
    
    init(useCase: SearchPhotosUseCase = SearchPhotosUseCase()) {
        self.useCase = useCase
    }
    
    func search() async {
        resetPaging()
        viewState = .loading
        await loadPage()
    }
    
    func loadNextPage() async {
        if page < totalPages {
            hasMorePages = true
            await loadPage()
        }
    }
    
    func didCancelSearch(_ isSearching: Bool) {
        guard !isSearching && keyword.isEmpty else { return }
        resetPaging()
        viewState = .idle
    }
    
    private func loadPage() async {
        do {
            let photoDtoList = try await useCase.call(keyword: keyword, page: page)
            totalPages = photoDtoList.pageInfo.totalPages
            page = photoDtoList.pageInfo.currentPage + 1
            photos.append(contentsOf: photoDtoList.photos)
            viewState = photos.isEmpty ? .notResults : .success
        } catch {
            viewState = .failure(error)
        }
    }
    
    private func resetPaging() {
        self.page = 1
        self.totalPages = 0
        self.photos.removeAll()
    }
}
