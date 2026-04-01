//
//  ContentView.swift
//  A2_iOS_Ayesha_100949840
//
//  Created by Ayesha Akbar on 2026-04-01.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

       @FetchRequest(
           entity: Product.entity(),
           sortDescriptors: [NSSortDescriptor(key: "productId", ascending: true)]
       ) private var products: FetchedResults<Product>
    
    @State private var currentIndex: Int = 0
    
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
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                if products.indices.contains(currentIndex) {
                    let product = products[currentIndex]
                    Text (product.productName ?? "No Name")
                        .font(.title2)
                        .fontWeight(.semibold)
                
                    
                    Text(product.productDescription ?? "No Description")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("Price: $\(product.productPrice, specifier: "%.2f")")
                        .font(.headline)
                    
                    Text("Provider: \(product.productProvider ?? "No Provider")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        if currentIndex < products.count - 1 {
                            currentIndex += 1
                        }
                    }) {
                        Text("Next")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                } else {
                    Text("No products available.")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                    Spacer()
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

}
