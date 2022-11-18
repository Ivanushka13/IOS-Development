//
//  ViewController.swift
//  isdavydov_3PW1
//
//  Created by Иван Давыдов on 20.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //массив иконок
    @IBOutlet var views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Метод нажатия на кнопку(изменение цвета иконок и их углов)
    @IBAction func ChangeColorButtonPressed(_ sender: Any) {
        //кнопка
        let button = sender as? UIButton
        //при запуске повторное нажатие недоступно
        button?.isEnabled = false
        //set для формирования неповторяющихся цветов
        var set = Set<UIColor>()
        //заполнение каждой иконки рандомным цветом
        while set.count < views.count {
            set.insert(
                UIColor(
                    red: .random(in: 0...1),
                    green: .random(in: 0...1),
                    blue: .random(in: 0...1),
                    alpha: 1
                )
            )
        }
        //анимация перекращивания
        UIView.animate(withDuration: 2, animations: {
            for view in self.views {
                //углы каждой иконки формируются рандомно
                view.layer.cornerRadius = .random(in: 10...50)
                view.backgroundColor = set.popFirst()
            }
            //после завершения окрашивания кнопка становиться доступной
        }) { completion in
            button?.isEnabled = true
        }
    }
}

