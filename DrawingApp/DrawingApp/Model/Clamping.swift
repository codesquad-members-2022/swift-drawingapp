
@propertyWrapper
struct Clamping<V: Comparable> {
    private var value: V
    private let min: V
    private let max: V
    
    init(wrappedValue: V, min: V, max: V) {
        self.value = wrappedValue
        self.min = min
        self.max = max

        assert(value >= min && value <= max)
    }
    
    var wrappedValue: V {
        get { return value}
        set {
            if newValue < min {
                value = min
            }else if newValue > max {
                value = max
            }else {
                value = newValue
            }
        }
    }
}
