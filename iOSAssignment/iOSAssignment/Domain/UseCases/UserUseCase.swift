//
//  UserUseCase.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import Foundation

final class UserUseCase: UserUseCaseProtocol {
    private let userCoreDataReponsitory: UserCoreDataRepositoryProtocol
    
    init(userCoreDataReponsitory: UserCoreDataRepositoryProtocol) {
        self.userCoreDataReponsitory = userCoreDataReponsitory
    }
    
    func isLogined() -> Bool {
        userCoreDataReponsitory.getUserInfo() != nil
    }
    
    func login(id: String, password: String, nickname: String) -> Bool {
        userCoreDataReponsitory.saveUserInfo(id: id, password: password, nickname: nickname)
    }
    
    func getUserInfo() -> UserInfo {
        guard let userInfo = userCoreDataReponsitory.getUserInfo() else {
            return UserInfo(id: "", password: "", nickname: "알 수 없는 오류")
        }
        
        return userInfo
    }
    
    func checkDuplicate(id: String) -> Bool {
        userCoreDataReponsitory.checkDuplicate(id: id)
    }
    
    func withDraw(id: String) -> Bool {
        userCoreDataReponsitory.deleteUserInfo(id: id)
    }
}
