//
//  DefaultArticlesRepository.swift
//  Nosnews
//
//  Created by Arif Luthfiansyah on 25/03/20.
//  Copyright © 2020 Ayo Development. All rights reserved.
//

import Foundation

final class DefaultArticlesRepository {
    
    private let dataTransferService: DataTransferService
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
    
}

extension DefaultArticlesRepository: ArticlesRepository {
    
    func topHeadlineArticles(category: String?, country: String, sources: String?, query: String?, completion: @escaping (Result<ArticlePage, Error>) -> Void) -> Cancellable? {
        let requestDTO = ArticleRequestDTO(category: category, country: country, query: query)
        let endpoint = NewsAPIEndpoint.topHeadlineArticles(with: requestDTO)
        
        let request = self.dataTransferService.request(with: endpoint) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response.entity()))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
        
        return NetworkTask(request: request)
    }
    
}
