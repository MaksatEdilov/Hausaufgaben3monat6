//
//  NetworkService.swift
//  Hausaufgaben3monat6
//
//  Created by Maksat Edil on 18/1/24.
//

import Foundation

struct NetworkService {
    
    enum HTTPMethod: String {
        case GET, POST, PUT, DELETE
    }
    
    private var baseURL = URL(string: "https://dummyjson.com/products")!
    
    private let decoder = JSONDecoder()

    private let encoder = JSONEncoder()
    
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let request = URLRequest(url: baseURL)
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
            }
            if let data {
                do {
                    let productsNotArr = try decoder.decode(Products.self, from: data).products
                    completion(.success(productsNotArr))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        urlSession.resume()
    }
    
    func addNewProduct(with product: Product, completion: @escaping (Result<String, Error>) -> Void) {
        do {
            var request = URLRequest(url: baseURL)
            request.httpMethod = HTTPMethod.POST.rawValue
            request.httpBody = try encoder.encode(product)
            let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    completion(.failure(error))
                }
                if data != nil {
                    completion(.success("products added"))
                }
            }
            urlSession.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
    
    func updateProduct(with product: Product, completion: @escaping (Result<String, Error>) -> Void) {
        do {
            let updateProduct = Product(
                id: product.id,
                title: product.title,
                description: product.description,
                price: product.price
            )
            _ = baseURL.appendingPathComponent("\(product.id)")
            var request = URLRequest(url: baseURL)
            request.httpMethod = HTTPMethod.PUT.rawValue
            request.httpBody = try encoder.encode(updateProduct)
            let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    completion(.failure(error))
                }
                if data != nil {
                    completion(.success("products updated"))
                }
            }
            urlSession.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    func deleteProduct(with product: Product, completion: @escaping (Result<String, Error>) -> Void) {
        _ = baseURL.appendingPathComponent("\(product.id)")
            var request = URLRequest(url: baseURL)
            request.httpMethod = HTTPMethod.DELETE.rawValue
            let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error {
                    completion(.failure(error))
                }
                if data != nil {
                        completion(.success("products deleted"))
                }
            }
            urlSession.resume()
    }
}
