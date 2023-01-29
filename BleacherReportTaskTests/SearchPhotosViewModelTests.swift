//
//  SearchPhotosViewModelTests.swift
//  BleacherReportTaskTests
//
//  Created by Ahmad Almasri on 28/01/2023.
//

import Combine
import XCTest
@testable import BleacherReportTask

@MainActor
final class SearchPhotosViewModelTests: XCTestCase {
    private func makeViewModel(with result: Result<PhotosResponse, Error>) -> SearchPhotosViewModel {
        let httpClientMock = HttpClientMock()
        httpClientMock.decodableResult = Result { try result.get() }
        let dataSource = PhotosDataSourceImpl(httpClient: httpClientMock)
        let repository = PhotosRepositoryImpl(dataSource: dataSource)
        let useCase = SearchPhotosUseCase(repository: repository)
        let viewModel = SearchPhotosViewModel(useCase: useCase)
        return viewModel
    }
    
    func test_search_load_photos_success() async {
        // Given
        let response = photosResponse
        let dto = response.toPhotoDtoList
        var cancelBag = Set<AnyCancellable>()
        var viewStates: [SearchPhotosViewModel.ViewState] = []
        let viewModel = makeViewModel(with: .success(response))
        viewModel.$viewState.sink { viewStates.append($0) }.store(in: &cancelBag)
        
        // When
        await viewModel.search()
        
        // Then
        XCTAssertEqual(viewModel.photos, dto.photos)
        XCTAssertEqual(viewStates, [
            .idle,
            .loading,
            .success
        ])
    }
    
    func test_search_load_photos_load_next_success() async {
        // Given
        let response = photosResponse
        var cancelBag = Set<AnyCancellable>()
        var viewStates: [SearchPhotosViewModel.ViewState] = []
        let viewModel = makeViewModel(with: .success(response))
        viewModel.$viewState.sink { viewStates.append($0) }.store(in: &cancelBag)
        
        // When
        await viewModel.search()
        await viewModel.loadNextPage()
        // Then
        XCTAssertEqual(viewModel.page, 2)
        XCTAssertEqual(viewStates, [
            .idle,
            .loading,
            .success,
            .success
        ])
        
    }
    
    func test_search_load_photos_empty() async {
        // Given
        let response = emptyPhotosResponse
        let dto = response.toPhotoDtoList
        var cancelBag = Set<AnyCancellable>()
        var viewStates: [SearchPhotosViewModel.ViewState] = []
        let viewModel = makeViewModel(with: .success(response))
        viewModel.$viewState.sink { viewStates.append($0) }.store(in: &cancelBag)
        
        // When
        await viewModel.search()
        
        // Then
        XCTAssertEqual(viewModel.photos, dto.photos)
        XCTAssertEqual(viewStates, [
            .idle,
            .loading,
            .notResults
        ])
    }
    
    func test_search_load_failed() async {
        // Given
        let error = MockError.valueNotSet
        var cancelBag = Set<AnyCancellable>()
        var viewStates: [SearchPhotosViewModel.ViewState] = []
        let viewModel = makeViewModel(with: .failure(error))
        viewModel.$viewState.sink { viewStates.append($0) }.store(in: &cancelBag)
        
        // When
        await viewModel.search()
        
        // Then
        XCTAssertEqual(viewStates, [
            .idle,
            .loading,
            .failure(RequestErrorMapper(error: error))
        ])
    }
    
    func test_cancel_search_when_keyword_empty() async {
        // Given
        let response = photosResponse
        var cancelBag = Set<AnyCancellable>()
        var viewStates: [SearchPhotosViewModel.ViewState] = []
        let viewModel = makeViewModel(with: .success(response))
        viewModel.$viewState.sink { viewStates.append($0) }.store(in: &cancelBag)
        
        // When
        await viewModel.search()
        await viewModel.loadNextPage()
        viewModel.didCancelSearch(false)
        
        // Then
        XCTAssertEqual(viewModel.page, 1)
        XCTAssertEqual(viewStates, [
            .idle,
            .loading,
            .success,
            .success,
            .idle
        ])
    }
    
    func test_cancel_search_when_keyword_not_empty() async {
        // Given
        let response = photosResponse
        var cancelBag = Set<AnyCancellable>()
        var viewStates: [SearchPhotosViewModel.ViewState] = []
        let viewModel = makeViewModel(with: .success(response))
        viewModel.$viewState.sink { viewStates.append($0) }.store(in: &cancelBag)
        
        // When
        viewModel.keyword = "test"
        viewModel.didCancelSearch(false)
        
        // Then
        XCTAssertEqual(viewModel.page, 1)
        XCTAssertEqual(viewStates, [
            .idle
        ])
    }
}

extension SearchPhotosViewModel.ViewState: Equatable {
    public static func == (lhs: BleacherReportTask.SearchPhotosViewModel.ViewState, rhs: BleacherReportTask.SearchPhotosViewModel.ViewState) -> Bool {
        // Should not be used in production, this is suffice for unit tests.
        String(describing: lhs) == String(describing: rhs)
    }
}

let photosResponse = try! JSONDecoder().decode(PhotosResponse.self, from: Data("""
{
    "photos": {
        "page": 1,
        "pages": 9548,
        "perpage": 3,
        "total": 28643,
        "photo": [
            {
                "id": "52653232239",
                "owner": "146918744@N08",
                "secret": "c27f3639d1",
                "server": "65535",
                "farm": 66,
                "title": "Royal Aircraft Factory S.E.5",
                "ispublic": 1,
                "isfriend": 0,
                "isfamily": 0
            },
            {
                "id": "52649820837",
                "owner": "143002258@N03",
                "secret": "37fb5393cb",
                "server": "65535",
                "farm": 66,
                "title": "100 idées de business rentables en Afrique",
                "ispublic": 1,
                "isfriend": 0,
                "isfamily": 0
            },
            {
                "id": "52640639703",
                "owner": "86584394@N03",
                "secret": "de6485e3c5",
                "server": "65535",
                "farm": 66,
                "title": "Citroën 5 cv Torpedo (1919)",
                "ispublic": 1,
                "isfriend": 0,
                "isfamily": 0
            }
        ]
    },
    "stat": "ok"
}
""".utf8)
)

let emptyPhotosResponse = try! JSONDecoder().decode(PhotosResponse.self, from: Data("""
{
    "photos": {
        "page": 1,
        "pages": 9548,
        "perpage": 3,
        "total": 28643,
        "photo": []
    },
    "stat": "ok"
}
""".utf8)
)
