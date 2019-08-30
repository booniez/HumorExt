import Foundation
import RxSwift
import RxCocoa

public extension ObservableType {
    
    func ignoreAll() -> Observable<Void> {
        return map { _ in }
    }
    
    func unwrap<T>() -> Observable<T> where E == Optional<T> {
        return filter { $0 != nil }.map { $0! }
    }
    
    func execute(_ selector: @escaping (E) -> Void) -> Observable<E> {
        return flatMap { result in
            return Observable
                .just(selector(result))
                .map { _ in result }
                .take(1)
        }
    }
    
    func count() -> Observable<(E, Int)>{
        var numberOfTimesCalled = 0
        let result = map { _ -> Int in
            numberOfTimesCalled += 1
            return numberOfTimesCalled
        }
        
        return Observable.combineLatest(self, result)
    }
    
    func merge(with other: Observable<E>) -> Observable<E> {
        return Observable.merge(self.asObservable(), other)
    }
    
}
public extension Observable where Element == String {
    
    func mapToURL() -> Observable<URL> {
        return map { URL(string: $0) }
            .filter { $0 != nil }
            .map { $0! }
    }
}
public extension Observable where Element == Data {
    func map<D: Decodable>( _ type: D.Type) -> Observable<D>  {
        return map { try JSONDecoder().decode(type, from: $0) }
    }
}

public extension Observable where Element == Bool {
    
    func negate() -> Observable<Bool> {
        return map { !$0 }
    }
    
}

public extension Observable where Element: Sequence, Element.Iterator.Element: Comparable {
    
    /**
     Transforms an observable of sequences into an observable of ordered arrays by using the sequence element's
     natural comparator.
     */
    
    func sorted<T>() -> Observable<[T]> where Element.Iterator.Element == T {
        return map { $0.sorted() }
    }
    
    func sorted<T>(_ areInIncreasingOrder: @escaping (T, T) -> Bool) -> Observable<[T]>
        where Element.Iterator.Element == T {
            return map { $0.sorted(by: areInIncreasingOrder) }
    }
}


public extension ObservableType where E: Collection {
    
    func mapMany<T>(_ transform: @escaping (Self.E.Element) -> T) -> Observable<[T]> {
        return self.map { collection -> [T] in
            collection.map(transform)
        }
    }
}


