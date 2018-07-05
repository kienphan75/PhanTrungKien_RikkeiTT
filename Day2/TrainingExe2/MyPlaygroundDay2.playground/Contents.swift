//: Playground - noun: a place where people can play

import UIKit

print("HelloWord\n")
print("***************")
for i in 0...15{
    print("*             *")
}
print("***************")

var arrString = ["Phan","Trung"]
print("Mảng trước = ",arrString)

arrString.append("Kiên")

print("Mảng sau = ",arrString)


let p : [String:String] = ["name": "Kiên1", "age": "25", "address": "Hà Đông", "phone": "016666666"]
if let ten = p["name"]{
    print("Tên là : ",ten)
}


var dicArray = [Dictionary<String, String>]()
let dic1 = ["name": "Kiên", "age": "12","address":"Hà Đông","phone":"0122111"]
dicArray.append(dic1)
let dic2 = ["name": "Hải", "age": "14","address":"Hà Đông","phone":"0122111"]
dicArray.append(dic2)
let sortedArray = dicArray.sorted {$0["age"]! < $1["age"]!}

print(sortedArray)





