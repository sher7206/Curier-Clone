//
//  LoginService.swift
//  Nation
//
//  Created by Sherzod on 04/12/22.
//
import Alamofire

struct AuthService: BaseService {
    
    typealias Convertible = AuthRouter
    
    
    func register(model: RegisterRequest, completion: @escaping Completion<RegisterResponse>) {
        request(.register(model: model), completion: completion)
    }
    
    //    func authLogin(model: LoginRequest, completion: @escaping Completion<LoginResponse>) {
    //        request(.authLogin(model: model), completion: completion)
    //    }
    
    
    
    //    func sendFcmToken(model: FcmTokenRequest, completion: @escaping Completion<FcmTokenResponse>){
    //        request(.sendFcmToken(model: model), completion: completion)
    //    }
    
}

