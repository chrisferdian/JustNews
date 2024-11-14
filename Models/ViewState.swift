//
//  ViewState.swift
//  JustNews

enum ViewState: Equatable {
    
    case success
    case loading
    case error((() -> Void))
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success), (.loading, .loading), (.error, .error):
            return true
        default:
            return false
        }
    }
}
