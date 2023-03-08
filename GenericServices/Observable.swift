//
//  Observable.swift
//  Nativekit
//
//  Created by Joel Ramirez on 07/03/23.
//

import Foundation


//Observable
class Observable<T> {
    private var listener: [((T) -> Void)] = []
    
    var value: T {
        didSet {
            listener.forEach{$0(value)}
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        self.listener.append(listener)
    }
}
