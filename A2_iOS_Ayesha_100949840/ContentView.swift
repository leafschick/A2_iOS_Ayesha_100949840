//
//  ContentView.swift
//  A2_iOS_Ayesha_100949840
//
//  Created by Ayesha Akbar on 2026-04-01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Starbucks")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .font(Font.largeTitle.weight(.bold))
                    .foregroundColor(.black)
                    .padding()
                
                

                Text("This is an instore app for Starbucks managers to view products and add more products.")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding()
                    
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView()
}
