//
//  UserCoreDataRepository.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/21/25.
//

import Foundation
import CoreData

final class UserCoreDataRepository: UserCoreDataRepositoryProtocol {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveUserInfo(id: String, password: String, nickname: String) -> Bool {
        let user = User(context: context)
        user.id = id
        user.password = password
        user.nickName = nickname
        
        do {
            try context.save()
            print("✅ 저장 성공 아이디: \(id)")
            return true
        } catch {
            print("❌ 삭제 실패: \(error.localizedDescription)")
            return false
        }
    }
    
    func deleteUserInfo(id: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let users = try context.fetch(fetchRequest)
            users.forEach { context.delete($0) }
            try context.save()
            print("✅ 삭제 성공 아이디: \(id)")
            return true
        } catch {
            print("❌ 삭제 실패: \(error.localizedDescription)")
            return false
        }
    }
    
    func checkDuplicate(id: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let count = try context.count(for: fetchRequest)
            print("✅ 중복 검사 결과: \(count > 0)")
            return count > 0
        } catch {
            print("❌ 중복 검사 실패: \(error.localizedDescription)")
            return false
        }
    }
    
    func getUserInfo() -> UserInfo? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            guard let user = results.first,
                  let id = user.id,
                  let password = user.password,
                  let nickname = user.nickName else {
                print("✅ User 없음")
                return nil
            }
            
            print("✅ 저장된 유저 id:\(id), password: \(password), nickname: \(nickname)")
            return UserInfo(id: id, password: password, nickname: nickname)
        } catch {
            print("❌ 유저 정보 가져오기 실패: \(error.localizedDescription)")
            return nil
        }
    }
}
