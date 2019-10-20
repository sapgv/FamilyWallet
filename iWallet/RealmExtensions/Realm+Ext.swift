//
//  Realm+Ext.swift
//  iWallet
//
//  Created by Grigoriy Sapogov on 24/09/2019.
//  Copyright © 2019 Grigoriy Sapogov. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

extension Reactive where Base: Realm {
    
    func save<T: Object>(entity: T, update: Bool = true) -> Observable<Void> {
        
        return Observable.create { observer -> Disposable in
            
            do {
                try self.base.write {
                    self.base.add(entity, update: .all)
                }
                observer.onNext(())
            }
            catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
        
    }
    
    func delete<T: Object>(entity: T) -> Observable<Void> {
        
        return Observable.create { (observer) -> Disposable in
            
            do {
                try self.base.write {
                    self.base.delete(entity)
                }
                observer.onNext(())
            }
            catch {
                observer.onError(error)
            }
            return Disposables.create()
            
        }
                
    }
    
    
    
//    func save<R: RealmRepresentable>(entity: R, update: Bool = true) -> Observable<Void> where R.RealmType: Object  {
//        return Observable.create { observer in
//            do {
//                try self.base.write {
//                    self.base.add(entity.asRealm(), update: update)
//                }
//                observer.onNext(())
//                observer.onCompleted()
//            } catch {
//                observer.onError(error)
//            }
//            return Disposables.create()
//        }
//    }
//
//    func delete<R: RealmRepresentable>(entity: R) -> Observable<Void> where R.RealmType: Object {
//        return Observable.create { observer in
//            do {
//                guard let object = self.base.object(ofType: R.RealmType.self, forPrimaryKey: entity.uid) else { fatalError() }
//
//                try self.base.write {
//                    self.base.delete(object)
//                }
//
//                observer.onNext(())
//                observer.onCompleted()
//            } catch {
//                observer.onError(error)
//            }
//            return Disposables.create()
//        }
//    }
}
