import Dispatch

final class Atomic<T> {
    private let queue = DispatchQueue(label: "com.atomic.queue")
    private var _value: T
    
    init(_ value: T) {
        self._value = value
    }
    
    var value: T {
        set { queue.sync { _value = newValue } }
        get { queue.sync { _value } }
    }
}
