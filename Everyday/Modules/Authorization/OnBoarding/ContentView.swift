//
//  ContentView.swift
//  SlidingIntroScreen
//
//  Created by Federico on 18/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - properties
    
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    
    var onFinish: (() -> Void)?
    
    // MARK: - body
    
    var body: some View {
        TabView(selection: $pageIndex) {
            ForEach(pages.indices, id: \.self) { index in
                    PageView(viewModel: PageViewModel(page: pages[index]),
                             onNext: {
                                incrementPage()
                                   },
                             onSkip: {
                                skipToProfileSetup()
                             })
                    .tag(index)
            }
            
            ProfileSetupView(onNext: {
                        incrementPage()
                    })
            .tag(3)
            
            AgeView(onNext: {
                        incrementPage()
                    })
            .tag(4)
            
            GenderView(onNext: {
                        incrementPage()
                    })
            .tag(5)
            
            WeightView(onNext: {
                        incrementPage()
                    })
            .tag(6)
            
            ProfileAcknowledgementView(onFinish: onFinish)
            .tag(7)
        }
        .animation(.easeInOut, value: pageIndex)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            dotAppearance.currentPageIndicatorTintColor = .black
            dotAppearance.pageIndicatorTintColor = .gray
        }
        .background(Color.background) 
    }
    
    // MARK: - actions
    
    private func incrementPage() {
        pageIndex += 1
    }
    
    private func skipToProfileSetup() {
            pageIndex = 3
        }
}
