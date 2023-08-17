//
//  ContentView.swift
//  DebuggingAndStepThrough
//
//  Created by Michelle Grover on 8/17/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    var body: some View {
            VStack {
                Button(action: {
                    Task {
                        await fetchData()
                    }
                }) {
                    Text("Fetch Data")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        
        func fetchData() async {
            guard let url = URL(string: "https://datausa.io/api/data?drilldowns=Nation&measures=Population&year=latest") else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let jsonString = String(data: data, encoding: .utf8) {
                    print(jsonString)
                }
            } catch {
                print("HTTP Request Failed \(error)")
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
