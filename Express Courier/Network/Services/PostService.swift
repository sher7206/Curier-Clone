
//  PostService.swift
//  Express Courier
//  Created by apple on 17/01/23.


import Foundation
struct PostService: BaseService {
    typealias Convertible = PostRouter
    func getPostResponse(model: PostRequest, completion: @escaping Completion<GetPostResponse>) {
        request(.getPost(model: model), completion: completion)
    }
}
