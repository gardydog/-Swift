import UIKit

// Задание 1. Решить квадратное уравнение: 2x^2 + 5x - 3 = 0; В общем виде: ax^2 + bx + c = 0

let a: Double = 2
let b: Double = 5 //Вопрос: почему, если я поставлю здесь тип Int вместо Double, то будет ошибка??
let c: Double = -3

let discriminant = pow(b, 2) - 4*a*c

let x1 = (-b + sqrt(discriminant))/(2*a)
let x2 = (-b - sqrt(discriminant))/(2*a)

print("Задача 1: ","\n", "x1 =", x1, "\n", "x2 =", x2, "\n") // Вопрос: как можно убрать эти лишние пробелы на второй и третьей строчке?(


// Задание 2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

let firstSide: Double = 3
let secondSide: Double = 4
let thirdSide: Double = sqrt(pow(firstSide, 2) + pow(secondSide, 2))

let perimetr: Double = firstSide + secondSide + thirdSide
let square: Double = 0.5*firstSide*secondSide

print("Задача 2: ","\n", "Гипотенуза треугольника = ", thirdSide, "\n", "Периметр треугольника = ", perimetr, "\n", "Площадь треугольника = ", square, "\n")


// Задание 3. *Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.

var summa: Double = 1_000_000
var percent: Double = 8
percent = 1 + (percent / 100)
var time: Double = 5

while time > 0 {
    summa = summa*percent
    time -= 1
    print("У вас на балансе: ", summa, "рублей", ", оставшийся срок вклада: ", time, "года")
}
// ВОПРОС: Как можно сократить число после точки? (Округлить)


