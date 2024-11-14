//
//  MainViewModel.swift
//  JustNews
//
//  Created by Indo Teknologi Utama on 14/11/24.
//

import Foundation

// ViewModel Protocol and Implementation
protocol IMainViewModel: AnyObject {
    func fetchNews()
    var posts: Observable<[Post]> { get }
    var state: Observable<ViewState> { get }
}

class MainViewModel: IMainViewModel {
    let posts: Observable<[Post]> = .init([])
    var state: Observable<ViewState> = .init(.loading)
    
    func fetchNews() {
        setState(with: .loading)
        NetworkingManager.shared.request(.posts, method: .get) { [weak self] (result: Result<[Post], Error>) in
            switch result {
            case .success(let result):
                self?.setState(with: .success)
                self?.posts.value = result
            case .failure:
                self?.state.value = .error {
                    self?.fetchNews()
                }
            }
        }
    }
    
    private func setState(with newState: ViewState) {
        guard state.value != newState else { return }
        state.value = newState
    }
}
