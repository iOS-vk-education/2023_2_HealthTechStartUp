//
//  PhotoLibraryView.swift
//  Everyday
//
//  Created by Alexander on 20.05.2024.
//

import SwiftUI

struct PhotoLibraryView: View {
    @StateObject private var viewModel = PhotoLibraryViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            if !viewModel.imageUrls.isEmpty {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(viewModel.imageUrls, id: \.self) { imageUrl in
                            AsyncImage(url: imageUrl) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .controlSize(.large)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                case .failure:
                                    Text("Loading error")
                                        .foregroundStyle(Color.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 400, height: 600)
                            .background(
                                Rectangle()
                                    .fill(Color(uiColor: .gray.withAlphaComponent(0.1)))
                                    .cornerRadius(8)
                            )
                        }
                    }
                    .scrollTargetLayout()
                }
                .onAppear {
                    viewModel.fetchImageUrls()
                }
                .scrollTargetBehavior(.viewAligned)
                .background(Color.background)
            } else {
                Text("No saved photos")
                    .font(.title)
            }
        }
    }
}

struct PhotoLibraryLinkView: View {
    var body: some View {
        NavigationLink(destination: PhotoLibraryView()) {
            HStack {
                VStack {
                    Text("Photo Library")
                }
                Spacer()
                VStack {
                    Image(systemName: "arrow.forward")
                }
            }
            .padding()
            .background(
                Rectangle()
                    .fill(Color(uiColor: .gray.withAlphaComponent(0.1)))
                    .cornerRadius(8)
            )
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    PhotoLibraryLinkView()
}
