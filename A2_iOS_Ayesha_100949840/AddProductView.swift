//
//  AddProductView.swift
//  A2_iOS_Ayesha_100949840
//
//  Created by Ayesha Akbar on 2026-04-01.
//

import SwiftUI
import CoreData

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var productName = ""
    @State private var productDescription = ""
    @State private var productPrice = ""
    @State private var productProvider = ""

    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [NSSortDescriptor(key: "productId", ascending: true)]
    ) private var products: FetchedResults<Product>

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Information")) {
                    TextField("Product Name", text: $productName)
                    TextField("Product Description", text: $productDescription)
                    TextField("Product Price", text: $productPrice)
                        .keyboardType(.decimalPad)
                    TextField("Product Provider", text: $productProvider)
                }

                Section {
                    Button("Save Product") {
                        saveProduct()
                    }
                }
            }
            .navigationTitle("Add Product")
        }
    }

    private func saveProduct() {
        let newProduct = Product(context: viewContext)
        let nextId = (products.last?.productId ?? 0) + 1
        newProduct.productId = nextId
        newProduct.productName = productName
        newProduct.productDescription = productDescription
        newProduct.productPrice = Double(productPrice) ?? 0.0
        newProduct.productProvider = productProvider

        do {
            try viewContext.save()
            dismiss()
        } catch {
            print("Error saving product: \(error)")
        }
    }
}

#Preview {
    AddProductView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
