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
                
                Spacer().frame(height: 30)
                
                Text("Starbucks")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("This is an instore app for Starbucks to view products and add more products.")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                if products.indices.contains(currentIndex) {
                    let product = products[currentIndex]
                    
                    VStack(spacing: 12) {
                        Text(product.productName ?? "No Name")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(product.productDescription ?? "No Description")
                            .multilineTextAlignment(.center)
                        
                        Text("Price: $\(product.productPrice, specifier: "%.2f")")
                            .font(.headline)
                        
                        Text("Provider: \(product.productProvider ?? "No Provider")")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.05), radius: 5)
                    .padding(.horizontal)
                    
                    HStack {
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
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    
                } else {
                    Text("No products available.")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                
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
                
                Text("© 2026 Ayesha Akbar")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.top, 10)

                
                Spacer()
            }
            .navigationBarHidden(true)
            .onAppear {
                if !products.isEmpty {
                    currentIndex = products.count - 1
                } else {
                    currentIndex = 0
                }
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
