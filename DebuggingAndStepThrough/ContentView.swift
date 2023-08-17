import SwiftUI
import Foundation

struct ContentView: View {
    @State private var sourceDescription: String = ""
    @State private var nation: String = ""
    @State private var population: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Source Description: \(sourceDescription)")
            Text("Nation: \(nation)")
            Text("Population: \(population)")
            
            Button("Fetch Data") {
                Task {
                    await fetchData()
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }

    func fetchData() async {
        let urlString = "https://datausa.io/api/data?drilldowns=Nation&measures=Population&year=latest"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedData = try JSONDecoder().decode(Welcome.self, from: data)
            
            if let firstDatum = decodedData.data.first {
                nation = firstDatum.nation
                population = firstDatum.population
            }
            
            if let firstSource = decodedData.source.first {
                sourceDescription = firstSource.annotations.sourceDescription
            }
            
        } catch {
            print("Failed to fetch data: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
