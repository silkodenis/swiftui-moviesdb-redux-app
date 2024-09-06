typealias Command = () -> Void
typealias CommandWith<T> = (T) -> Void

func nop() {}
func nop<T>(_ value: T) {}
