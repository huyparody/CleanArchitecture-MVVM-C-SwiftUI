//
//  Publisher+Ext.swift
//  CleanArchitecture-MVVM-C-SwiftUI
//
//  Created by Huy Trinh Duc on 27/05/2023.
//

import Foundation
import Combine

class ErrorTracker {
    private let subject = PassthroughSubject<Error, Never>()
    
    var errorPublisher: AnyPublisher<Error, Never> {
        subject.eraseToAnyPublisher()
    }
    
    func track(_ error: Error) {
        subject.send(error)
    }
}

extension Publisher {
    func trackError<Tracker: ErrorTracker>(_ tracker: Tracker) -> AnyPublisher<Self.Output, Never> where Self.Failure == Error {
        self
            .catch { error -> Empty<Self.Output, Never> in
            tracker.track(error)
            return Empty()
        }
        .eraseToAnyPublisher()
    }
}

extension Publisher {
    func trackActivity(_ activityIndicator: ActivityIndicator) -> AnyPublisher<Self.Output, Self.Failure> {
        activityIndicator.trackActivity(self)
    }
}

class ActivityIndicator {
    @Published private var count = 0
    private let lock = NSRecursiveLock()
    
    var isLoadingPublisher: AnyPublisher<Bool, Never> {
        $count
            .map({$0 > 0})
            .eraseToAnyPublisher()
        
    }
    
    func trackActivity<T: Publisher>(_ source: T) -> AnyPublisher<T.Output, T.Failure> {
        return source
            .handleEvents(receiveCompletion: { _ in
                self.decrement()
            }, receiveCancel: {
                self.decrement()
            }, receiveRequest: { [weak self] _ in
                self?.increment()
            })
            .eraseToAnyPublisher()
    }
    
    private func increment() {
        lock.lock()
        defer { lock.unlock() }
        
        count += 1
    }
    
    private func decrement() {
        lock.lock()
        defer { lock.unlock() }
        
        count -= 1
    }
}
