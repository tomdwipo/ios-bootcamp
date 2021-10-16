import UIKit

// MARK: - Constants and Variables

let maxJumlahPercobaanLogin = 10
var jumlahPercobaanLogin = 0

jumlahPercobaanLogin = 2
//maxJumlahPercobaanLogin = 7


// Deklarasi multiple variabel dalam satu baris
var x = 0.0, y = 0.0, z = 0.0

// Type Annotations
var pesan: String
pesan = "Hello"

var merah, hijau, biru: Double

//Int, Double, String, Bool

//Naming Constants and Variables
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"
let isActive = true

//String Interpolation
print(pesan + " saya adalah " + "\(🐶🐮)")

//Semicolons
let cat = "🐱"; print(cat)

//Type Aliases
typealias BilanganBulat = Int
//typealias Completion = (Result<Int, Error>) -> Void

let angka: BilanganBulat = 1
//var completion: Completion

//Tuples
let httpError = (404, "Not Found", true)
print("\(httpError.0): \(httpError.1)")

let responseStatus = (code: 200, message: "OK")
print("\(responseStatus.code): \(responseStatus.message)")


//Optionals
var i: Int = 0
let numberString = "123"
let number: Int? = Int(numberString)
// convertedNumber is inferred to be of type "Int?", or "optional Int”
print(number)


//Implicitly Unwrapped Optionals
//let unwarpedNumber: Int = number!

//If Statements and Forced Unwrapping
//if number != nil {
//    print("Nilai variable number: \(number!)")
//}
//else {
//    print("Nilai variable number: nil")
//}

if let uNumber = number {
    print("Nilai variable number: \(uNumber)")
}


//Basic Operators
// = + - * / %

//Comparison Operators
// (==) (!=) (>) (<) (>=) (<=)


//Range Operators
//Closed Range Operator (a...b)
//for index in 1...5 {
//    print("\(index) times 5 is \(index * 5)")
//}

//Half-Open Range Operator (a..<b)
//for index in 1..<5 {
//    print("\(index) times 5 is \(index * 5)")
//}

let names = ["Anna", "Alex", "Brian", "Jack"]
//let count = names.count
////for i = 0; i < count; i++ {
//for i in 0..<count {
//    print("Person \(i + 1) is called \(names[i])")
//}

//One-Sided Ranges
//for name in names[2...] {
//    print(name)
//}

//for name in names[...2] {
//    print(name)
//}

//for name in names[..<2] {
//    print(name)
//}

//Logical Operators
// NOT (!a)
// AND (a && b)
// OR (a || b)

let a = true
let b = false
print(!a)
print(a && b)
print(a || b)


//Dictionary
var profile: [String: Any] = [
    "name": 123,
    "gender": 1,
    "isActive": true
]

let name = profile["name"]
if let name = profile["name"] as? String {
    let username: String = name
    print(username)
}
else {
    print("Tipe data salah")
}

let data = ["1": "a", "2": "b", "3": "c"]
let d = data["1"]
if let d = data["1"] {
    let username: String = d
    print(d)
}
else {
    print("Tipe data salah")
}

//Classes
class Kendaraan {
    var jumlahRoda: Int = 0

    func maju() {

    }

    func jenisBahanBakar() -> String {
        return "Bensin"
    }
}

class KendaraanTurbo: Kendaraan {

}

class Mobil: Kendaraan {
    override init() {
        super.init()
        self.jumlahRoda = 4
    }
}

class Motor: Kendaraan {

    override init() {
        super.init()
        self.jumlahRoda = 2
    }
}

class Truck: Kendaraan {
    convenience init(jumlahRoda: Int) {
        self.init()
        self.jumlahRoda = jumlahRoda
    }
}

let mobil = Mobil()
let truck = Truck(jumlahRoda: 6)

//Struct
struct Vehicle {
    var jumlahRoda: Int

    func maju() {

    }

    func jenisBahanBakar() -> String {
        return "Bensin"
    }
}

let v = Vehicle(jumlahRoda: 0)
v.maju()

//Extension
extension Mobil {
    func turbo() {
        print("Turboooo!")
    }
}

let motor = Motor()


let password: String = "qwerty1234"

extension String {
    func MD5() -> String {
        return "asdf5678"
    }

    func asd() {

    }

    func date(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.date(from: self)
    }
}

let encryptedPassword = password.MD5()
encryptedPassword.asd()

let date: Date? = "2021-10-02".date(format: "yyyy-MM-dd")
print(date)

//import PlaygroundSupport
//
//extension UIView {
//    @objc func buttonTapped(_ sender: Any) {
//        print("Button Tapped")
//    }
//}
//
//let view = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 568))
//let button = UIButton()
//button.setTitleColor(UIColor.white, for: .normal)
//button.backgroundColor = UIColor.blue
//button.setTitle("90 night(s)", for: .normal)
//button.addTarget(view, action: #selector(view.buttonTapped(_:)), for: .touchUpInside)
//button.layer.cornerRadius = 8
//button.layer.masksToBounds = true
//
//view.addSubview(button)
//button.translatesAutoresizingMaskIntoConstraints = false
//NSLayoutConstraint.activate([
//    button.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//    button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//    button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//])
//
//PlaygroundPage.current.liveView = view
