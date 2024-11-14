//
//  MainViewModel.swift
//  JustNews
//
//  Created by Indo Teknologi Utama on 14/11/24.
//

import Foundation

protocol IMainViewModel: AnyObject {
    func fetchNews()
    var posts: Observable<[Post]> { get }
    var state: Observable<ViewState> { get }
}
enum ViewState {
    case success
    case loading
    case error((() -> Void))
}
class MainViewModel: IMainViewModel {
    
    
    let posts: Observable<[Post]> = .init([])
    var state: Observable<ViewState> = .init(.loading)
    
    func fetchNews() {
        self.state.value = .loading
        NetworkingManager.shared.request(.posts, method: .get) { [weak self] (result: Result<[Post], Error>) in
            switch result {
            case .success(let result):
                self?.state.value = .success
                self?.posts.value = result
            case .failure(let failure):
                print(failure.localizedDescription)
                self?.state.value = .error({
                    self?.state.value = .loading
                    self?.fetchNews()
                })
            }
        }
    }
}
