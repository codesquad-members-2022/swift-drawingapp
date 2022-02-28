//
//  ViewController.swift
//  Drawingapp
//
//  Created by seongha shin on 2022/02/28.
//

import UIKit

class ViewController: UIViewController {

    let factory = Factory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (0..<4).forEach { _ in
            let newSquare = factory.makeSquare()
            print("\(newSquare)")
        }
        
        
//        ViewController 클래스에 viewDidLoad() 함수에서 팩토리에서 모델 객체 4종류를 생성하고 print()가 아닌 시스템 로그 함수로 출력한다
    }


}

