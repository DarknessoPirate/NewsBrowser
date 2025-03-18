import Foundation

class NewsService: ObservableObject {
    @Published var articles = [Article]()
    
    private var currentPage = 1
    private let pageSize = 10
    private var currentQuery: String = ""
    private var isLoading = false

    // Inicjalne pobranie newsów
    func fetchNews(query: String) {
        currentQuery = query
        currentPage = 1
        articles = [] // czyścimy poprzednie wyniki
        loadNews()
    }
    
    // Ładowanie newsów dla bieżącej strony
    private func loadNews() {
        guard !isLoading else { return }
        isLoading = true
        
        let urlString = "https://newsapi.org/v2/everything?q=\(currentQuery)&apiKey=\(Config.apiKey)&page=\(currentPage)&pageSize=\(pageSize)"
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            defer { self?.isLoading = false }
            guard let self = self, let data = data else { return }
            
            do {
                let result = try JSONDecoder().decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    // Jeśli ładowanie pierwszej strony, zastępujemy dane
                    // W przeciwnym wypadku dopisujemy nowe wyniki
                    if self.currentPage == 1 {
                        self.articles = result.articles
                    } else {
                        self.articles.append(contentsOf: result.articles)
                    }
                    self.currentPage += 1
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    // Metoda wywoływana przy pojawieniu się danego elementu w liście
    func loadMoreIfNeeded(currentItem: Article?) {
        guard let currentItem = currentItem else { return }
        let thresholdIndex = articles.index(articles.endIndex, offsetBy: -1)
        if articles.firstIndex(where: { $0.id == currentItem.id }) == thresholdIndex {
            loadNews()
        }
    }
}
