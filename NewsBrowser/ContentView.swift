import SwiftUI

struct ContentView: View {
    @StateObject var newsService = NewsService()
    @State private var searchQuery = "Technology"

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search News", text: $searchQuery, onCommit: {
                    newsService.fetchNews(query: searchQuery)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                if newsService.articles.isEmpty {
                    VStack {
                        Spacer()
                        Text("No news found :(")
                            .font(.title)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .navigationTitle("News")
                } else {
                    List(newsService.articles) { article in
                        NavigationLink(destination: WebView(url: article.url)) {
                            NewsRow(article: article)
                                .onAppear {
                                    // Kiedy pojawi się ostatni element, pobieramy kolejną stronę
                                    newsService.loadMoreIfNeeded(currentItem: article)
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("News")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            newsService.fetchNews(query: searchQuery)
        }
    }
}
