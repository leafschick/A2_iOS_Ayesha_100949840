//
//  AllProductsView.swift
//  A2_iOS_Ayesha_100949840
//
//  Created by Ayesha Akbar on 2026-04-01.
//

import SwiftUI
import CoreData

struct AllProductsView: View {
    
    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(key: "productId", ascending: true)]
    ) private var products: FetchedResults<Product>
    
    @State private var searchText = ""
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return Array(products)
        } else {
            return products.filter {
                ($0.productName ?? "").localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack {
            TextField("Search by product name", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            List {
                ForEach(filteredProducts, id: \.objectID) { product in
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(product.productName ?? "No Name")
                            .font(.headline)
                        
                        Text(product.productDescription ?? "No Description")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Text("Price: $\(product.productPrice, specifier: "%.2f")")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Text("Provider: \(product.productProvider ?? "Unknown")")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .navigationTitle("All Products")
    }
}

#Preview {
    AllProductsView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
