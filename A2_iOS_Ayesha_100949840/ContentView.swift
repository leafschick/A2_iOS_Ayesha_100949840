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
                
                NavigationLink(destination: AllProductsView()) {
                    Text("View All Products")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                NavigationLink(destination: AddProductView()) {
                    Text("Add Product")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
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
                    
                    HStack {
                        
                        // PREVIOUS
                        Button(action: {
                            if currentIndex > 0 {
                                currentIndex -= 1
                            }
                        }) {
                            Text("Previous")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 8)
                                .background(Color.gray.opacity(0.15))
                                .clipShape(Capsule())
                        }
                        .foregroundColor(currentIndex > 0 ? .black : .gray)
                        .disabled(currentIndex == 0)

                        Spacer()

                        // NEXT
                        Button(action: {
                            if currentIndex < products.count - 1 {
                                currentIndex += 1
                            }
                        }) {
                            Text("Next")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 18)
                                .padding(.vertical, 8)
                                .background(Color.blue.opacity(0.2))
                                .clipShape(Capsule())
                        }
                        .foregroundColor(currentIndex < products.count - 1 ? .green : .gray)
                        .disabled(currentIndex >= products.count - 1)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 25)
                    
                } else {
                    Text("No products available.")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                    Spacer()
            }
                        .navigationTitle("Home")
                        .onAppear {
                            refreshCurrentIndex()
                        }
                        .onChange(of: products.count) {
                            if !products.isEmpty {
                                currentIndex = products.count - 1
                            } else {
                                currentIndex = 0
                            }
                        }
                    }
                }
    
    private func refreshCurrentIndex() {
        if products.isEmpty {
            currentIndex = 0
        } else if currentIndex >= products.count {
            currentIndex = 0
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

}
