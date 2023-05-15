//
//  LocalAuthorizationService.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 15.05.2023.
//

import Foundation
import LocalAuthentication

final class LocalAuthorizationService {
    
    // MARK: - Enum
    
    enum BiometricError: LocalizedError {
        case authenticationFailed
        case userCancel
        case biometryLockout
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .authenticationFailed:
                return "Не удалось верифицироваться"
            case .userCancel:
                return "Вы отменили верификацию"
            case .biometryLockout:
                return "Слишком много неудачных попыток авторизации"
            case .unknown:
                return "Неизветная ошибка"
                // С описание ошибок сильно не заморачивался
            }
        }
        
    }
    
    // MARK: - Private properties
    
    private let context = LAContext()
    private let policy: LAPolicy = .deviceOwnerAuthentication
    
    private var error: NSError?
    
    
    // MARK: - Init
    
    init() {
        self.context.localizedFallbackTitle = "Использовать пароль"
        self.context.localizedCancelTitle = "Отмена"
        
    }
    
    
    
    // MARK: - Public methods
    
    func canEvaluate(completion: (Bool, LABiometryType, BiometricError?) -> Void) {
        
        guard self.context.canEvaluatePolicy(self.policy, error: &self.error) else {
            return completion(false, self.context.biometryType, self.getBiometricError(from: self.error))
        }
        
        completion(true, self.context.biometryType, nil)
    }
    
    func evaluate(completion: @escaping (Bool, BiometricError) -> Void) {
        self.context.evaluatePolicy(
            self.policy,
            localizedReason: "Введите пароль для верификации") { [weak self] isSuccess, error in
                guard let self = self else { return }
                DispatchQueue.main.async {
//                    if isSuccess {
//                        completion(true, nil)
//                    } else {
//                        guard let error = error else {
//                            return completion(false, nil)
//                        }
//                        completion(false, self?.getBiometricError(from: error as NSError))
//                    }
                    
                    completion(isSuccess, self.getBiometricError(from: error as NSError?))
                }
                
            }
    }
    
    
    
    // MARK: - Private methods
    
    private func getBiometricError(from nsError: NSError?) -> BiometricError {
        guard let nsError = nsError else {
            return .unknown
        }
        
        let error: BiometricError
        
        switch nsError {
        case LAError.authenticationFailed:
            error = .authenticationFailed
        case LAError.userCancel:
            error = .userCancel
        case LAError.biometryLockout:
            error = .biometryLockout
        default:
            error = .unknown
        }
        
        return error
    }
    
}
