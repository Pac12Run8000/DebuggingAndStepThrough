import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var sourceDescription: String = ""
    @Published var nation: String = ""
    @Published var population: Int = 0

    func fetchData() {
        Task {
            await fetchDataAsync()
        }
    }

    private func fetchDataAsync() async {
        let urlString = "https://datausa.io/api/data?drilldowns=Nation&measures=Population&year=latest"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(Welcome.self, from: data)
            
            if let firstDatum = decodedData.data.first {
                DispatchQueue.main.async {
                    self.nation = firstDatum.nation
                    self.population = firstDatum.population
                }
            }
            
            if let firstSource = decodedData.source.first {
                DispatchQueue.main.async {
                    self.sourceDescription = firstSource.annotations.sourceDescription
                }
            }
            
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
}
