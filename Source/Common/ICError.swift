//
//  ValidationError.swift
//  punkpin
//
//  Created by James on 2021/04/21.
//  Copyright © 2021 Blueshift. All rights reserved.
//

import Foundation

enum ICError: Error {
    enum Validation {
        case invalidEmailFormat
        case invalidPasswordFormat
        case notMatchRePassword
    }
    
    enum Registeration {
        case alreadyRegisterd
        case realNameAuth
    }
    
    enum Login {
        case notRegistered
        case notMatchPassword
        case bioAuth
    }
}

extension ICError.Validation: LocalizedError {
    public var localizedDescription: String? {
        switch self {
        case .invalidEmailFormat:           return "이메일 형식이 올바르지 않습니다."
        case .invalidPasswordFormat:        return "비밀번호 형식이 올바르지 않습니다."
        case .notMatchRePassword:           return "재확인 비밀번호가 일치하지 않습니다."
        }
    }
}

extension ICError.Registeration: LocalizedError {
    public var localizedDescription: String? {
        switch self {
        case .alreadyRegisterd:             return "이미 가입된 이메일입니다."
        case .realNameAuth:                 return "실명확인 중 오류가 발생했습니다.\n잠시 후 다시 시도해주십시오."
        }
    }
}

extension ICError.Login: LocalizedError {
    public var localizedDescription: String? {
        switch self {
        case .notRegistered:                return "입력하신 이메일로 가입된 정보가 없습니다."
        case .notMatchPassword:             return "아이디 혹은 이메일 정보가 맞지 않습니다."
        case .bioAuth:                      return "생체인증 중 오류가 발생했습니다.\n다른 방법으로 로그인해주세요."
        }
    }
}
