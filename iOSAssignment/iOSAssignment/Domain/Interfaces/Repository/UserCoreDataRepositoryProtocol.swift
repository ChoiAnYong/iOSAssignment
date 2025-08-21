//
//  UserCoreDataRepositoryProtocol.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/21/25.
//

import Foundation

protocol UserCoreDataRepositoryProtocol {
    func saveUserInfo(id: String, password: String, nickname: String) -> Bool
    func deleteUserInfo(id: String) -> Bool
    func checkDuplicate(id: String) -> Bool
    func getUserInfo() -> UserInfo?
}
