//
//  ViewController.swift
//  Homework(GenericsAndErrors)
//
//  Created by Кирилл Афонин on 08/10/2019.
//  Copyright © 2019 Кирилл Афонин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Сохраняемые значения
        let intNumber = 5
        let stringNumber = "five"
        
        save(intNumber)
        save(stringNumber)
        
        // Загрузка
        var resultInt: Result<Int, Error>
        resultInt = resultObject(forKey: "1")
        
        switch resultInt {
        case .success(let number):
            print(number)
        case .failure(let error):
            print(error)
        }
        
        resultInt = resultObject(forKey: "2")
        
        switch resultInt {
        case .success(let number):
            print(number)
        case .failure(let error):
            print(error)
        }
        
        var resultString: Result<String, Error>
        resultString = resultObject(forKey: "2")
        
        switch resultString {
        case .success(let string):
            print(string)
        case .failure(let error):
            print("WARNING! There is \(error)")
        }
        
    }
    
    // Генерируемая ошибка
    enum LoadingErrors: Error {
        case loadError
    }

    let defaults = UserDefaults.standard
    static var saveKey = 1 // Уникальный ключ для сохранения объектов. Увеличивается после каждого сохранения
    
    func save<T>(_ object: T) {
        defaults.set(object, forKey: "\(ViewController.saveKey)")
        ViewController.saveKey += 1
    }
    
    func loadObject<T>(forKey key: String) throws -> T {
        // Ошибка, если объект не Т
        guard let obj = defaults.object(forKey: key) as? T else {
            throw LoadingErrors.loadError
        }
        return obj
    }

    // Обработка функции, генерирующей ошибку
    func resultObject<T>(forKey key: String) -> Result<T, Error> {
        do {
            let object: T = try loadObject(forKey: key)
            return .success(object)
        } catch {
            return .failure(error)
        }
    }
}

