

import Alamofire
import SwiftyJSON



struct ResponseMonitor<T> where T: Codable {
    
    private let response: DataResponse<T, AFError>
    
    public init(response: DataResponse<T, AFError>) {
        self.response = response
    }
    
    /**
     Analyzes response object and decodes decodable object concluding on success or error
     
     - Parameters:
     - type: The type of the value to decode from the supplied JSON object.
     - completion: The callback called after monitor finish
     */
    internal func monitor(completion: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            // Get status code.
            let statusCode = try inspectStatusCode()
            // Log.
            NetworkLogger.log(response)
            
            // Check status code.
            if statusCode >= 200 && statusCode < 300 {
                try inspectResult(completion: completion)
               
            } else {
                guard let resposeData = response.data else {return}
                let json = JSON(try JSONSerialization.jsonObject(with: resposeData, options: []))
                throw NetworkError.unexpected(description: json["message"].stringValue)
            }
        } catch {
            guard let error = error as? NetworkError else { return }
            DispatchQueue.main.async {
//                print("error =", error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    private func inspectResult(completion: @escaping (Result<T, NetworkError>) -> Void) throws {
        switch response.result {
        case .success:
            // Generate decodable model from response data.
            let model = try NetworkDecoder<T>().decode(from: response.data)
            // Complete monitor operation.
            DispatchQueue.main.async {
                completion(.success(model))
            }
            
        case .failure(let error):
            // Handle result failure.
            NetworkLogger<T>.responseErrorMessage(response.data) { errorMsg, statusCode in
                DispatchQueue.main.async {
                    print(errorMsg)
                    completion(.failure(.unexpected(description: error.localizedDescription)))
                }
            }
        }
    }
    
    /// The response’s HTTP status code.
    private func inspectStatusCode() throws -> Int {
        guard let statusCode = response.response?.statusCode else {
            //            Utils.shared.dismissLoading()
            throw NetworkError.unexpected(description: "Internet bilan aloqa uzildi")
        }
        
        return statusCode
    }
}
