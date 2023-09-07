//
//  FlashCardModel.swift
//  Flip Learner
//
//  Created by Apple  on 22/05/23.
//

import Foundation

struct FlashCardModel:Hashable{
    let question:String
    let answer:String
    let hint:String
}

class FlashCardViewModel:ObservableObject{
    
    @Published var flashCardModelsArray:[CardEntity] = []
    
    
//    @Published var flashCardModelsArray:[FlashCardModel] = [
//        FlashCardModel(question: "What is the keyword used to declare a constant in Swift?", answer: "The keyword \"let\" is used to declare a constant in Swift.", hint: " It is the opposite of a variable and its value cannot be changed once it is assigned.") ,
//    FlashCardModel(question: "What is an optional in Swift?", answer: "An optional in Swift represents a value that can either be present or absent. It is denoted by adding a \"?\" after the type.", hint: " It provides a way to handle values that might be nil or have no value assigned.") ,
//    FlashCardModel(question: "What is the difference between a struct and a class in Swift?", answer: " In Swift, both structs and classes are used to define custom data types, but they have some differences. One major difference is that structs are value types, while classes are reference types.", hint: "Value types are copied when they are assigned or passed as arguments, while reference types are passed by reference.") ,
//    FlashCardModel(question: "How do you create a function in Swift?", answer: " To create a function in Swift, you use the keyword \"func\" followed by the function name, parameters, return type (if any), and the function body enclosed in curly braces.", hint: "The keyword \"func\" is used to declare a function in Swift.") ,
//    FlashCardModel(question: "What is a closure in Swift?", answer: "A closure is a self-contained block of code that can be assigned to a variable, passed as a parameter, or returned from a function. It captures and stores references to variables and constants from the surrounding context in which it is defined.", hint: "Closures are similar to anonymous functions or lambda expressions in other programming languages.") ,
//    FlashCardModel(question: "What is type inference in Swift?", answer: " Type inference is a feature in Swift that allows the compiler to automatically deduce the type of a variable or expression based on its initial value.", hint: " Type inference reduces the need for explicit type annotations and makes code more concise.") ,
//    FlashCardModel(question: " What is the difference between \"if\" and \"guard\" statements in Swift?", answer: "Both \"if\" and \"guard\" statements are used for conditional execution in Swift. The main difference is that an \"if\" statement introduces a new scope, while a \"guard\" statement requires an early exit from the current scope.", hint: " \"guard\" statements are often used to validate conditions and ensure that certain requirements are met before proceeding with the rest of the code.")
//    ]
}
