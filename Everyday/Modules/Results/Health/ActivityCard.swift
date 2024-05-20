//
//  ActivityCard.swift
//  Everyday
//
//  Created by Yaz on 19.05.2024.
//

import SwiftUI

struct Activity {
    let id: Int
    let title: String
    let timeInterval: String
    let image: String
    let amount: String
    let measure: String?
}

struct ActivityCard: View {
    @State var activity: Activity
    
    var body: some View {
        ZStack {
            Color(uiColor: .gray.withAlphaComponent(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 15))
            VStack(spacing: 10) {
                HStack {
                    Text(activity.title)
                        .font(.system(size: 16))
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: activity.image)
                        .foregroundColor(.green)
                        .frame(width: 24, height: 24, alignment: .trailing)
                }
                
                Text(activity.timeInterval)
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                ZStack {
                    Text(activity.amount)
                        .font(.system(size: 24))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 10)
                    
                    if let measure = activity.measure {
                        HStack {
                            Spacer()
                            Text(measure)
                                .font(.system(size: 14))
                                .foregroundStyle(.gray)
                                .padding(.bottom, 10)
                        }
                        .frame(alignment: .bottom)
                    }
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
    }
}
