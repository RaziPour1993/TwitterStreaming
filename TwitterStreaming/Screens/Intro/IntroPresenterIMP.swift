//
//  IntroPresenterIMP.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

class IntroPresenterIMP {
    
    weak var view: IntroPresentingView?
    weak var delegate: IntroScreenDelegate?
    
    init(_ delegate: IntroScreenDelegate) {
        self.delegate = delegate
    }
    
    deinit {
        print(self)
    }
    
}

extension IntroPresenterIMP: IntroPresenter {
    
    func present() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.delegate?.preparationDone()
        }
    }
    
    func set(view: IntroPresentingView) {
        self.view = view
    }
    
}
