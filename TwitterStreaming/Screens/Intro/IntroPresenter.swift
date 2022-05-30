//
//  IntroPresenter.swift
//  TwitterStreaming
//
//  Created by Mohammad on 5/30/22.
//

import Foundation

protocol IntroPresenter: Presenter {
    func set(view: IntroPresentingView)
}

protocol IntroPresentingView: PresentingView {
    
}

protocol IntroScreenDelegate: ScreenDelegate {
    func preparationDone()
}
