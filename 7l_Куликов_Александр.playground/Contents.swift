import UIKit

//MARK: - TASK - 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.

struct Product {
    let name: String
}

struct Item {
    var price: Double
    var count: UInt
    var product: Product
}

enum ShopError {

    case outofStock // Нет в наличии
    case invalidSelection // Нет в ассортименте
    case noMoneynoHoney(moneyNeeded: Double) // Недостаточно денег

    var localizedDescription: String {
        switch self {
        case .outofStock: return "Нет в наличии"
        case .invalidSelection: return "Нет в ассортименте"
        case .noMoneynoHoney(let money): return "Недостаточно денег: \(money)"
        }
    }
}

class ClothesShop {                                 // Магазин одежды

    var wareHouse = [
        "Jeans": Item(price: 99, count: 35, product: Product(name: "Джинсы")),
        "Jackets": Item(price: 299, count: 21, product: Product(name: "Куртка")),
        "Hats": Item(price: 49, count: 6, product: Product(name: "Шляпа"))
    ]

    var deposit = 0.0

    func buy(itemName name: String) -> (Product?, ShopError?) {

        guard let item = wareHouse[name] else {
            return (nil, .invalidSelection)
        }

        guard item.count > 0 else {
            return (nil, .outofStock)
        }

        guard item.price <= deposit else {
            return (nil, .noMoneynoHoney(moneyNeeded: item.price - deposit))
        }

        var newItem = item
        newItem.count -= 1
        wareHouse[name] = newItem

        deposit -= item.price

        return (item.product, nil)

    }
}

let purchasing = ClothesShop()

purchasing.deposit = 300

let sale = purchasing.buy(itemName: "Hats")

if let product = sale.0 {
    print("Вы купили:", product.name, "\n", "--->", "На вашем счету осталось:", purchasing.deposit, "$")
    print("Остаток товара: ", purchasing.wareHouse.count, "шт.")
    print()

} else if let error = sale.1 {
    print(error.localizedDescription)
    print()
}

//MARK: - TASK - 2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

struct Product1 {
    let name: String
}

struct Item1 {
    var price: Double
    var count: UInt
    var product: Product1
}

enum CarShopError: Error {  //ВОПРОС: Зачем мы использовали протокол Error? Без него конструкция Tru/Catch будет работать некорректно, да?

    case outofStock // Нет в наличии
    case invalidSelection // Нет в ассортименте
    case noMoneynoHoney(moneyNeeded: Double) // Недостаточно денег

    var localizedDescription: String {
        switch self {
        case .outofStock: return "Нет в наличии"
        case .invalidSelection: return "Нет в ассортименте"
        case .noMoneynoHoney(let money): return "Недостаточно денег: \(money) $"
        }
    }
}

class CarShop {                                                 //Магазин автомобилей
    
    var wareHouse = [
        "LADA": Item1(price: 1300, count: 470, product: Product1(name: "Жигули: Девятка")),
        "BMW": Item1(price: 18000, count: 2, product: Product1(name: "BMW: M5")),
        "Toyota": Item1(price: 5000, count: 12, product: Product1(name: "Toyota: Auris"))
    ]
    
    var depositCar = 0.0
    
    func buyTry(itemName name: String) throws -> Product1 {
        
        guard let item = wareHouse[name] else {
            throw CarShopError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw CarShopError.outofStock
        }
        
        guard item.price <= depositCar else {
            throw CarShopError.noMoneynoHoney(moneyNeeded: item.price - depositCar)
        }
        
        var newItem = item
        newItem.count -= 1
        wareHouse[name] = newItem
        
        depositCar -= item.price
        
        return item.product
        
    }
}



let purchasingCar = CarShop()

purchasingCar.depositCar = 30000

do {
    let sale1 = try purchasingCar.buyTry(itemName: "Toyota")
    print("Вы купили:", sale1.name, "\n", "--->", "На вашем счету осталось:", purchasingCar.depositCar, "$")
    print("Остаток товара: ", purchasingCar.wareHouse.count, "шт.") //ВОПРОС: Почему здесь работает некорректно? В первом классе тоже сломался этот счётчик...
} catch CarShopError.outofStock {
    print(CarShopError.outofStock.localizedDescription)
    
} catch CarShopError.invalidSelection {
    print(CarShopError.invalidSelection.localizedDescription)
    
} catch CarShopError.noMoneynoHoney(let money){
    print(CarShopError.noMoneynoHoney(moneyNeeded: money).localizedDescription)
    
} catch {
    print("До свидания!")
}
    
    
    
//{ if let error = error as? CarShopError {             //Так тоже можно очень удобно вывести информацию об ошибке
//        print(error.localizedDescription) }


