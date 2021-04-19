import UIKit

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//Стек (представьте стопку тарелок):
//- объекты заходят с конца
//- объекты выходят с конца (то есть последний, вошедший в стек, выйдет первым)
//Очередь (как обычная очередь на кассе):
//- объекты заходят с конца
//- объекты выходят из начала (то есть последний, вошедший в очередь, выйдет последним)
//
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//Вам нужно придумать метод, который будет описан внутри "очереди". Этот метод в качестве одного из аргументов должен принимать замыкание (либо это будет единственный аргумент). Замыкание будет описано в основном коде и будешь лишь передаваться в метод очереди при вызове.
//
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
//Не забудьте проверить индекс, переданный в subscript. Можно для начала попробовать не усложнять логику и просто вернуть элемент из очереди по переданному индексу, а потом уже сделать реализацию сложнее, если есть желание.


protocol MileAgeProtocol {                      // Говорим, что у каждой машины должен быть пробег
    var mileAge: Double { get }
}

class SportCar: MileAgeProtocol, CustomStringConvertible {                  // Имплементируем протокол спортивной машине
    var description: String {
        """
        Базовый объем багажника: \(trunkVolume)
        Величина багажа: \(baggage)
        Пробег машины: \(mileAge)


        """
    }
    var trunkVolume: Double
    var baggage: Double
    var mileAge: Double
    
    func calculateFreeTrunkVolume () -> Double {                // Здесь считаем свободное место в багажнике
        return trunkVolume - baggage
    }
    
    init(trunkVolume: Double, baggage: Double, mileAge: Double) {
        self.trunkVolume = trunkVolume
        self.baggage = baggage
        self.mileAge = mileAge
    }
}

class TrunkCar: MileAgeProtocol, CustomStringConvertible {                          // Имплементируем протокол грузовой машине
    var description: String {
        """
        Базовый объем багажника: \(truckBody)
        Величина багажа: \(cargo)
        Пробег машины: \(mileAge)


        """
    }
    var truckBody: Double
    var cargo: Double
    var mileAge: Double
    
    func calculateFreeTruckBody() -> Double {                   // Считаем свободное место для груза в кузове
        return truckBody - cargo
    }
    
    init(truckBody: Double, cargo: Double, mileAge: Double) {
        self.truckBody = truckBody
        self.cargo = cargo
        self.mileAge = mileAge
    }
}

struct Queue<T: MileAgeProtocol> {     //Здесь делаю очередь из автомобилей

    private var someCars: [T] = []
    
    mutating func push(_ car: T) {
        someCars.append(car)
    }
    
    mutating func pop() -> T? {
        guard someCars.count > 0 else { return nil }
        return someCars.removeFirst()
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        someCars.map { "\($0)" }.joined(separator: "\n")
    }
}

extension Queue {
    
    func myFilter(prediction: (MileAgeProtocol) -> Bool) -> [T] {
        var resultArray: [T] = []
        
        for car in someCars {
            if prediction(car) {
                resultArray.append(car)
            }
        }
        return resultArray
    }
}

extension Queue {

    subscript(index: Int) -> Double? {
        guard index >= 0 && index < someCars.count else { return nil }
        return someCars[index].mileAge
    }
}

enum SomeCar: MileAgeProtocol, CustomStringConvertible {
    case sport(SportCar)
    case trunk(TrunkCar)
    
    var description: String {
        switch self {
        case .sport(let sportCar):
            return sportCar.description
        case .trunk(let trunkCar):
            return trunkCar.description
        }
    }
    
    var mileAge: Double {
        switch self {
        case .sport(let sportCar):
            return sportCar.mileAge
        case .trunk(let trunkCar):
            return trunkCar.mileAge
        }
    }
}

var queue1 = Queue<SomeCar>()

queue1.push(.sport(SportCar(trunkVolume: 200, baggage: 100, mileAge: 1000))) //Для этих двух мы уже сделали pop, поэтому их нет в конце
queue1.push(.trunk(TrunkCar(truckBody: 300, cargo: 100, mileAge: 2000)))

let someCar1 = queue1.pop()
switch someCar1 {
case .sport(let sportCar):
    print(sportCar.calculateFreeTrunkVolume())
case .trunk(let trunkCar):
    print(trunkCar.calculateFreeTruckBody())
default: break
}

let someCar2 = queue1.pop()
switch someCar2 {
case .sport(let sportCar):
    print(sportCar.calculateFreeTrunkVolume())
case .trunk(let trunkCar):
    print(trunkCar.calculateFreeTruckBody())
default: break
}

queue1.push(.sport(SportCar(trunkVolume: 200, baggage: 100, mileAge: 400)))
queue1[0] // - Для сабскриптов
queue1.push(.sport(SportCar(trunkVolume: 400, baggage: 200, mileAge: 800)))
queue1.push(.sport(SportCar(trunkVolume: 600, baggage: 300, mileAge: 900)))


//let oldCars: (MileAgeProtocol) -> Bool = { $0.mileAge >= 500 }
//let oldCars2 = queue1.myFilter(prediction: {$0.mileAge >= 500 })
let oldCars2 = queue1.myFilter {$0.mileAge >= 700 }
print(oldCars2)


