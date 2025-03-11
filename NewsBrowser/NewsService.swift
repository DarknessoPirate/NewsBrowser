//
//  NewsService.swift
//  NewsBrowser
//
//  Created by RMS on 11/03/2025.
//


import Foundation

class NewsService: ObservableObject {
    @Published var articles = [Article]()

    func fetchNews(query: String) {
        
        let urlString = "https://newsapi.org/v2/everything?q=\(query)&apiKey=\(Config.apiKey)"
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.articles = result.articles
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}
