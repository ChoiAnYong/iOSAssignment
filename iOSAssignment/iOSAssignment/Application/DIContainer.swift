//
//  DIContainer.swift
//  iOSAssignment
//
//  Created by 최안용 on 8/20/25.
//

import UIKit
import CoreData

final class DIContainer {
    static let shared = DIContainer()
    
    private let context: NSManagedObjectContext
    private let userCoreDataRepository: UserCoreDataRepositoryProtocol
    private let userUseCase: UserUseCaseProtocol
    
    private init() {
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.userCoreDataRepository = UserCoreDataRepository(context: context)
        self.userUseCase = UserUseCase(userCoreDataReponsitory: self.userCoreDataRepository)
    }
    
    func makeStartViewController() -> StartViewController {
        let startVC = StartViewController(viewModel: .init(userUseCase: userUseCase))
        
        return startVC
    }
    
    func makeSignUpViewController() -> SignUpViewController {
        return SignUpViewController(viewModel: .init(userUseCase: userUseCase))
    }
    
    func makeLoginSuccessViewController() -> UIViewController {
        return LoginSuccessViewController(viewModel: .init(userUseCase: userUseCase))
    }
}
