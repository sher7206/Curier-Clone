
//  PostService.swift
//  Express Courier
//  Created by apple on 17/01/23.

import Foundation
struct PostService: BaseService {
    
    typealias Convertible = PostRouter
    func getPostResponse(model: PostRequest, completion: @escaping Completion<GetPostResponse>) {
        request(.getPost(model: model), completion: completion)
    }
    func acceptPostResponse(model: PostAcceptRequest, completion: @escaping Completion<PostAcceptResponse>){
        request(.acceptPost(model: model), completion: completion)
    }
    
    func getOnePostResponse(model: PostIdRequest, completion: @escaping Completion<GetOnePostResponse>){
        request(.getOnePost(model: model), completion: completion)
    }
    
    func createChatPost(model: PostChatRequest,  completion: @escaping Completion<CreateChatResonse>){
        request(.createChaPost(model: model), completion: completion)
    }
    func getChatExpressData(model: PostGetChatRequest,  completion: @escaping Completion<CreateChatResonse>){
        request(.getChatPost(model: model), completion: completion)
    }

}
