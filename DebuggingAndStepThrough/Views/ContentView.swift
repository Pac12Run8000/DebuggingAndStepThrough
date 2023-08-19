import SwiftUI
import Foundation

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
   

    var body: some View {
        VStack(spacing: 20) {
                   Text("Source Description: \(viewModel.sourceDescription)")
                   Text("Nation: \(viewModel.nation)")
                   Text("Population: \(viewModel.population)")
                   
                   Button("Fetch Data") {
                       viewModel.fetchData()
                   }
                   .padding()
                   .background(Color.blue)
                   .foregroundColor(.white)
                   .cornerRadius(8)
            Text("https://datausa.io/api/data?drilldowns=Nation&measures=Population")
               }
               .padding()
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
