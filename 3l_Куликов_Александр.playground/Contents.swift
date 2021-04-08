import UIKit
// MARK: - Task 1 -
//1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

enum EngineState: String {
    case on = "Двигатель запущен"
    case off = "Двигатель заглушен"
}

enum WindowState: String {
    case open = "Окна открыты"
    case close = "Окна закрыты"
}

enum TrunkQuality {
    case Большой, Средний, Маленький
}

struct Transport {
    let autoMark: String
    let yearofIssue: Int
    private var trunkVolume: Double //Базовый объем багажника
    var trunkQuality: TrunkQuality {
        if trunkVolume < 200 {
            return TrunkQuality.Маленький
        } else if trunkVolume < 1000 {
            return .Средний
        } else {
            return .Большой
        }
    }
    let bodyVolume: Double //Объем кузова
    var engine: EngineState
    {
        willSet {
            if newValue == .on {
            print("Двигатель заводится...")
        } else {
            print("Выключаем двигатель")
        }
    }
}
    var window: WindowState
    {
        willSet {
            if newValue == .open {
            print("Окна сейчас откроются") //ВОПРОС: Не совсем корректно выводится для одновременного запуска двух экземпляров, как можно исправить?
        } else {
            print("Окна сейчас закроются.")
        }
    }
}
    private var baggage: Double //Объем перевозимого багажа
    private var trunkState: Double { //Доступный объем багажника
          return trunkVolume - baggage
    }
    func printCarInfo() {
        print("Марка авто: \(self.autoMark)")
        print("Год выпуска: \(self.yearofIssue)")
        print("Базовый объем багажника, л: \(self.trunkVolume)")
        print("Класс багажника: \(self.trunkQuality)")
        print("Объем кузова, л: \(self.bodyVolume)")
        print("Состояние двигателя: \(self.engine.rawValue)")
        print("Состояние окон: \(self.window.rawValue)")
        print("Величина багажа, л: \(self.baggage)")
        print("Доступный объем багажника, л: \(self.trunkState)", "\n")
    }
    
    mutating func changeBaggage(_ value: Double) {
        if (value > self.trunkVolume) || (value < 0) {
            print("(!) Такой багаж не вместится!")
        } else {
            self.baggage = value
        }
    }
    
    mutating func takeOutBaggage(_ value: Double) {
        if (value > baggage) || (value < 0) {
            print("(!) Такого багажа здесь нет!")
        } else {
            baggage -= value
        }
    }
    
    mutating func startEngine(to state: EngineState) {
        self.engine = state
    }
    
    mutating func closeWindow() {
        window = .close
    }
    
    mutating func openWindow() {
        window = .open
    }
    
    init(autoMark: String, yearofIssue: Int, trunkVolume: Double, bodyVolume: Double, engine: EngineState, window: WindowState, baggage: Double) {
        self.autoMark = autoMark
        self.yearofIssue = yearofIssue
        self.trunkVolume = trunkVolume
        self.bodyVolume = bodyVolume
        self.engine = engine
        self.window = window
        self.baggage = baggage
    }
}

// ВОПРОС: Почему выдаёт ошибку?
//init?(autoMark: String, yearofIssue: Int, trunkVolume: Double, bodyVolume: Double, engine: EngineState, window: WindowState, bag: Double) {
//    self.autoMark = autoMark
//    self.yearofIssue = yearofIssue
//    self.trunkVolume = trunkVolume
//    self.bodyVolume = bodyVolume
//    self.engine = engine
//    self.window = window
//    self.baggage = bag
//}

var sportCar = Transport(autoMark: "Ferrari", yearofIssue: 1999, trunkVolume: 230.0, bodyVolume: 4600.0, engine: .off, window: .open, baggage: 0.0)
var trunkCar = Transport(autoMark: "Mercedes", yearofIssue: 2008, trunkVolume: 30000.0, bodyVolume: 45000.0, engine: .on, window: .close, baggage: 0.0)

//sportCar.baggage = 50.0
sportCar.changeBaggage(60) //Кладем багаж в машину
trunkCar.changeBaggage(21000)

sportCar.takeOutBaggage(10) //Убираем багаж из машины
trunkCar.takeOutBaggage(900)

//sportCar.engine = .off
sportCar.startEngine(to: .on)
trunkCar.startEngine(to: .off)

//sportCar.window = .open
sportCar.closeWindow()
trunkCar.openWindow()

sportCar.printCarInfo()
trunkCar.printCarInfo()





