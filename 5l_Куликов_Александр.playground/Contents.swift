import UIKit
// MARK: - -
//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль.

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

protocol CarProtocol: class {
    var autoMark: String {get}
    var yearofIssue: Int {get}
    var trunkVolume: Double {get}       //Базовый объем багажника
    var baggage: Double {get}           //Объем перевозимого багажа
    var carMotorSound: String {get}
    
    func changeBaggage() -> Double
}

extension CarProtocol {
    func closeWindow() {}
}

extension CarProtocol {
    func openWindow() {}
}

extension CarProtocol {
    func offEngine() {}
}

extension CarProtocol {
    func onEngine() {}
}

class SportCar: CarProtocol {
    
    var autoMark: String
    var yearofIssue: Int
    var trunkVolume: Double
    var baggage: Double
    
    var spoiler: SpoilerState
    var turboMode: TurboMode
    var carMotorSound: String {
        return "Уиииииу"
    }
    
    init(autoMark: String, yearofIssue: Int, trunkVolume: Double, baggage: Double, spoiler: SpoilerState, turboMode: TurboMode) {
        self.autoMark = autoMark
        self.yearofIssue = yearofIssue
        self.trunkVolume = trunkVolume
        self.baggage = baggage
        self.spoiler = spoiler
        self.turboMode = turboMode
    }
    
    func changeBaggage() -> Double {
        let trunkState = self.trunkVolume - self.baggage
        print("Доступный объем багажника: \(trunkState)")
        return trunkState
    }
    
    //    func changeBaggage(_ value: Double) {
    //        if (value > self.trunkVolume) || (value < 0) {                //ВОПРОС: Где я могу теперь реализовать данную проверку?
    //            print("(!) Такой багаж не вместится!")
    //        } else {
    //            self.baggage = value
    //        }
    //    }
    
    func openWindow() {
        print("Окна открыты")
    }
    
    func closeWindow() {
        print("Окна закрыты")
    }
    
    func onEngine() {
        EngineState.on
    }
    
    func offEngine() {
        EngineState.off
    }
    
    func spoilerMode(to state: SpoilerState) {
        self.spoiler = state
    }
    
    func turboMode(to state: TurboMode) {
        self.turboMode = state
    }
}

extension SportCar: CustomStringConvertible {
    
    var description: String {
        """
        Марка автомобиля: \(autoMark)
        Год выпуска автомобиля: \(yearofIssue)
        Базовый объем багажника: \(trunkVolume)
        Величина багажа: \(baggage)
        Состояние спойлеров: \(spoiler.rawValue)
        Режим Турбо: \(turboMode.rawValue)
        Звук авто: \(carMotorSound)

        """
    }
}

class TrunkCar: CarProtocol {
    
    var autoMark: String
    var yearofIssue: Int
    var trunkVolume: Double
    var baggage: Double
    
    var grab: GrabState
    var gas: GasState
    var carMotorSound: String {
        return "брррр"
    }
    
    init(autoMark: String, yearofIssue: Int, trunkVolume: Double, baggage: Double, grab: GrabState, gas: GasState) {
        self.autoMark = autoMark
        self.yearofIssue = yearofIssue
        self.trunkVolume = trunkVolume
        self.baggage = baggage
        self.grab = grab
        self.gas = gas
    }
    
    func changeBaggage() -> Double {
        let a = self.trunkVolume - self.baggage
        print("Доступный объем багажника: \(a)")
        return a
    }
    
    func openWindow() {
        print("Окна открыты")
    }
    
    func closeWindow() {
        print("Окна закрыты")
    }
    
    func offEngine() {
        EngineState.off
    }
    
    func onEngine() {
        EngineState.on
    }
    
    func gasMode(to state: GasState) {
        self.gas = state
    }
    
    func grabMode(to state: GrabState) {
        self.grab = state
    }
    
    //    func winDow() {
    //        print("Открой окна!!!")
    //    }
    
}

extension TrunkCar: CustomStringConvertible {
    
    var description: String {
        """
        Марка автомобиля: \(autoMark)
        Год выпуска автомобиля: \(yearofIssue)
        Базовый объем багажника: \(trunkVolume)
        Величина багажа: \(baggage)
        Положение ковша: \(grab.rawValue)
        Состояние газового отсека: \(gas.rawValue)
        Звук авто: \(carMotorSound)

        """
    }
}

let sportCar = SportCar(autoMark: "Porsche", yearofIssue: 2009, trunkVolume: 600, baggage: 150, spoiler: .close, turboMode: .off)
sportCar.changeBaggage()
sportCar.openWindow()
sportCar.spoilerMode(to: .open)
sportCar.turboMode(to: .on)
print(sportCar)

let trunkCar = TrunkCar(autoMark: "Volvo", yearofIssue: 1999, trunkVolume: 30000, baggage: 6000, grab: .down, gas: .off)
trunkCar.changeBaggage()
//trunkCar.winDow()
trunkCar.openWindow()
trunkCar.gasMode(to: .on)
trunkCar.grabMode(to: .up)
print(trunkCar)

let trunkCar2 = TrunkCar(autoMark: "Mercedes", yearofIssue: 2003, trunkVolume: 25000, baggage: 700, grab: .down, gas: .on)
trunkCar2.changeBaggage()
trunkCar2.gasMode(to: .off)
print(trunkCar2)

//Код получился СУПЕР объемным, я терялся в процессе поиска нужной информации.. ВОПРОС: Возможно ли как-то глобально оптимизировать (Уменьшить) код? Но основной вопрос остается про проверку на строчке 95.
//Комментарий: честно говоря, задание мне показалось сложнее, чем с классом родителем и его наследниками. Там все гораздо понятнее. А здесь все равно до конца не понимаю - зачем я использовал здесь протоколы, и каким образом он упростил мне жизнь? От чего он может меня в конкретном примере (моем) защитить меня? Я так понимаю, что он меня защищает только от того, что пользователь не может создать автомобиль, не включив те свойства, который я задаю в протоколе. Это хорошо. Но какой смысл методов, которые я создавал в протоколе? Я так же создал доп. методы для каждого класса отдельно, а методы с окнами я также спокойно создаю отдельно на примере строчки 195.
//Также вопрос про реализацию set в протоколах, пересмотрев вебинар, до меня все равно не дошло, зачем нам нужен set. С get вроде понятно.
//По моему, у меня снова съехала табуляция в коде, однако когда я нажимая (cmd + a) + (ctrl + i), как вы меня учили, у меня ничего не выравнивается. Почему так?(





//(Это для себя заметка)Для того, чтобы получилась билеберда, можно написать и оставить просто вот так. Но чтобы было все норм, мы пользуемся методом выше!
//    var trunkCar = TrunkCar(autoMark: "Volvo", yearofIssue: 1999, trunkVolume: 30000, baggage: 6000, grab: .down, gas: .off)
//    print(trunkCar)


