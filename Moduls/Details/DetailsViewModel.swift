
//
//  DetailsViewModel.swift
//  JustNews
//

import Foundation

protocol IDetailsViewModel: AnyObject {
    var post: Post { get }
}

class DetailsViewModel: IDetailsViewModel {
    
    let post: Post
    
    init(post: Post) {
        self.post = post
    }
}
