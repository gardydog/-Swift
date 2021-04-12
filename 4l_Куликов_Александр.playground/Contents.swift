import UIKit

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

enum EngineState: String {
    case on = "Двигатель запущен"
    case off = "Двигатель заглушен"
}

enum WindowState: String {
    case open = "Окна открыты"
    case close = "Окна закрыты"
}

enum SpoilerState: String {
    case open = "Спойлер выдвинут"
    case close = "Спойлер задвинут"
}

enum TurboMode: String {
    case on = "Включен"
    case off = "Выключен"
}

enum GrabState: String {
    case up = "Ковш поднят"
    case down = "Ковш опущен"
}

enum GasState: String {
    case on = "Клапан с газами открыт: газ выпущен"
    case off = "Клапан с газами закрыт"
}

class ClassCar {
    let autoMark: String
    let yearofIssue: Int
    var trunkVolume: Double //Базовый объем багажника
    let bodyVolume: Double //Объем кузова
    var engine: EngineState
    var window: WindowState
    var baggage: Double //Объем перевозимого багажа
    var trunkState: Double { //Доступный объем багажника
        return trunkVolume - baggage
    }
    var carMotorSound: String {
        return "*Заглох*"
    }
    
    static var carCount = 0
    
    init(autoMark: String, yearofIssue: Int, trunkVolume: Double, bodyVolume: Double, engine: EngineState, window: WindowState, baggage: Double) {
        self.autoMark = autoMark
        self.yearofIssue = yearofIssue
        self.trunkVolume = trunkVolume
        self.bodyVolume = bodyVolume
        self.engine = engine
        self.window = window
        self.baggage = baggage
        
        ClassCar.carCount += 1
    }
    
    static func printCarCount() {
        print("Кол-во авто: \(ClassCar.carCount) штук")
    }
    
    func changeBaggage(_ value: Double) {
        if (value > self.trunkVolume) || (value < 0) {
            print("(!) Такой багаж не вместится!")
        } else {
            self.baggage = value
        }
    }
    
    func printCarInfo() {
        print("Марка авто: \(self.autoMark)")
        print("Год выпуска: \(self.yearofIssue)")
        print("Базовый объем багажника, л: \(self.trunkVolume)")
        print("Объем кузова, л: \(self.bodyVolume)")
        print("Состояние двигателя: \(self.engine.rawValue)")
        print("Состояние окон: \(self.window.rawValue)")
        print("Величина багажа, л: \(self.baggage)")
        print("Доступный объем багажника, л: \(self.trunkState)", "\n")
        print("Звук мотора: \(self.carMotorSound)")
    }
}

class SportCar: ClassCar {
    var spoiler: SpoilerState
    var turboMode: TurboMode
    override var carMotorSound: String {
        return "Уиииииу"
    }
    
    init(autoMark: String, yearofIssue: Int, trunkVolume: Double, bodyVolume: Double, engine: EngineState, window: WindowState, baggage: Double, spoiler: SpoilerState, turboMode: TurboMode) {
        
        self.spoiler = spoiler
        self.turboMode = turboMode
        
        super.init(autoMark: autoMark, yearofIssue: yearofIssue, trunkVolume: trunkVolume, bodyVolume: bodyVolume, engine: engine, window: window, baggage: baggage)
    }
    
    override func printCarInfo() {
        super.printCarInfo()
        print("Состояние спойлера: \(self.spoiler.rawValue)") //ВОПРОС: Как убрать  образующуюся лишнюю пустую строчку?
        print("Режим Turbo: \(self.turboMode.rawValue)")
        print()
        print("----------------------------------")
    }
    
    func turboMode(to state: TurboMode) {
        self.turboMode = state
    }
}

class TrunkCar: ClassCar {
    var grab: GrabState
    var gas: GasState
    override var carMotorSound: String {
        return "Бррррррр"
    }
    
    init(autoMark: String, yearofIssue: Int, trunkVolume: Double, bodyVolume: Double, engine: EngineState, window: WindowState, baggage: Double, grab: GrabState, gas: GasState) {
        
        self.grab = grab
        self.gas = gas
        
        super.init(autoMark: autoMark, yearofIssue: yearofIssue, trunkVolume: trunkVolume, bodyVolume: bodyVolume, engine: engine, window: window, baggage: baggage)
    }
    
    override func printCarInfo() {
        super.printCarInfo()
        print("Состояние ковша: \(self.grab.rawValue)") //ВОПРОС: Как убрать  образующуюся лишнюю строчку?
        print("Состояние газового клапана: \(self.gas.rawValue)")
        print()
        print("----------------------------------")
    }
    
    func gasMode(to state: GasState) {
        self.gas = state
    }
    
    override func changeBaggage(_ value: Double) {      //нет смысла вызывать эту функция, она не помогает против отрицательных значений
        super.changeBaggage(value)
    }
}


var justCar = ClassCar(autoMark: "Ford", yearofIssue: 2003, trunkVolume: 150.0, bodyVolume: 4100.0, engine: .off, window: .open, baggage: 0.0)

var sportCar = SportCar(autoMark: "Ferrari", yearofIssue: 1999, trunkVolume: 230.0, bodyVolume: 4600.0, engine: .off, window: .open, baggage: 0.0, spoiler: .open, turboMode: .off)

var trunkCar = TrunkCar(autoMark: "Mercedes", yearofIssue: 2008, trunkVolume: 30000.0, bodyVolume: 45000.0, engine: .on, window: .close, baggage: 0.0, grab: .down, gas: .on)

justCar.changeBaggage(950) //ВОПРОС: Почему здесь выполняется условие с функцией с багажом (блокирует отрицательные значения)
justCar.printCarInfo()

sportCar.turboMode(to: .on)
sportCar.baggage = 100          //А здесь нет??
sportCar.printCarInfo()

trunkCar.gasMode(to: .off)
trunkCar.baggage = 60000        //И здесь?
trunkCar.printCarInfo()

ClassCar.printCarCount()
