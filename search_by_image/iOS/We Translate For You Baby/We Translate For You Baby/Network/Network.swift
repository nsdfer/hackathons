//
//  Network.swift
//  We Translate For You Baby
//
//  Created by Andy Yeung on 6/1/19.
//  Copyright © 2019 AHJT. All rights reserved.
//

import Alamofire

struct NetworkEndPoints {
    static let userEndpoint = "https://cse-121-tony.herokuapp.com/v0/users"
    
    static var signUpEndPoint = NetworkEndPoints.userEndpoint
    static var getPhoneNumberEndpoint = NetworkEndPoints.userEndpoint
    
    static func sendCodeEndPoint(userId: String) -> String {
        return NetworkEndPoints.userEndpoint + "/\(userId)/verify"
    }
}

struct Network {
    static func signUp(firstName: String,
                       lastName: String,
                       number: String,
                       language: String,
                       completion: @escaping (Bool) -> Void) {
        let parameters: [String: Any] = ["first_name": firstName,
                                          "last_name": lastName,
                                          "phone_number": "+1" + number,
                                          "language": language]
        
        request(NetworkEndPoints.signUpEndPoint, method: .post, parameters: parameters).validate().responseJSON { response in
            guard response.result.isSuccess else {
                print("Failed to Sign Up: \(response.error.debugDescription)")
                completion(false)
                return
            }
            
            guard
                let value = response.result.value as? [String: Any],
                let userId = value["id"] as? String
                else {
                    print("No User ID in response")
                    completion(false)
                    return
            }
            
            Myself(id: userId).save()
            completion(true)
        }
    }
    
    static func sendCode(userId: String, code: Double, completion: @escaping (Bool) -> Void) {
        let parameters: [String: Any] = ["code": code]
        
        request(NetworkEndPoints.sendCodeEndPoint(userId: userId), method: .post, parameters: parameters).validate().responseJSON { response in
            guard response.response?.statusCode == 200 else {
                print("Failed to send code: \(response.error.debugDescription)")
                completion(false)
                return
            }
            
            let myself = Myself.current
            myself?.setVerified()
            myself?.save()
            
            completion(true)
        }
    }
    
    static func getPhoneNumber(number: String, language: LanguageType, completion: @escaping (String?) -> Void) {
        let parameters: [String: Any] = ["phone_number": "+1" + number,
                                         "language": language.rawValue]
        
        request(NetworkEndPoints.getPhoneNumberEndpoint, method: .get, parameters: parameters).validate().responseJSON { response in
            guard response.result.isSuccess else {
                print("Failed to get phone number: \(response.error.debugDescription)")
                completion(nil)
                return
            }
            
            guard let value = response.result.value as? [String: Any],
                let number = value["phone_number"] as? String
            else {
                print("No number in response")
                completion(nil)
                return
            }
            
            completion(number)
        }
    }
}
