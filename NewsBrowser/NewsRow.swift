//
//  NewsRow.swift
//  NewsBrowser
//
//  Created by RMS on 11/03/2025.
//


import SwiftUI

struct NewsRow: View {
    let article: Article

    var body: some View {
        HStack {
            if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFit()
                } placeholder: {
                    Color.gray.frame(width: 80, height: 80)
                }
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            }
            
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2)
                Text(article.publishedAt)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
