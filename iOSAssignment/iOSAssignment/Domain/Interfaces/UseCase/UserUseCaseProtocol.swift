//
//  UserUseCaseProtocol.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/21/25.
//

import Foundation

protocol UserUseCaseProtocol {
    func isLogined() -> Bool
    func login(id: String, password: String, nickname: String) -> Bool
    func checkDuplicate(id: String) -> Bool
    func getUserInfo() -> UserInfo
    func withDraw(id: String) -> Bool
}
