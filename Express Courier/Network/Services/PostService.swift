
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
    
    func cancelOrderPostData(model: CancelOrderPostRequest,  completion: @escaping Completion<CancelPostResponse>){
        request(.cancelPost(model: model), completion: completion)
    }
    
    func confirmOrderPostData(model: ConfirmPostRequest,  completion: @escaping Completion<ConfirmPostResponse>){
        request(.confrimPost(model: model), completion: completion)
    }

    func takeOrderData(model: TakeOrderPostRequest,  completion: @escaping Completion<TakeOrderPostResponse>){
        request(.takePost(model: model), completion: completion)
    }
    
    func enterTimerOrderData(model: TimerOrderPostRequest,  completion: @escaping Completion<EnterTimerOrderPostResponse>){
        request(.enterTimerPost(model: model), completion: completion)
    }



}
