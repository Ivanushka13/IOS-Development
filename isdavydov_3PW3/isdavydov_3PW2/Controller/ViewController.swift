//
//  ViewController.swift
//  isdavydov_3PW2
//
//  Created by Иван Давыдов on 29.09.2022.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    // основная кнопка
    private let incrementButton = UIButton(type: .system)
    
    // лабелька для отображения "достижения"
    private let commentLabel = UILabel()
    
    // лабелька для подсчета нажатий
    let valueLabel = UILabel()
    
    var buttonsSV = UIStackView()
    
    let colorPaletteView = ColorPaleteView()
    
    // счетчик
    private var value: Int = 0
    
    // запуск основных функций
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupMenuButtons()
        setupCommentView()
    }
    
    // задание параметров основной кнопки
    private func setupIncrementButton() {
        incrementButton.setTitle("Press me", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 25.0, weight: .medium)
        incrementButton.backgroundColor = .white
        applyShadow(incrementButton)

        self.view.addSubview(incrementButton)
        incrementButton.setHeight(60) // задаем размер
        incrementButton.pinTop(to: self.view.centerYAnchor) // выставляем по центру
        incrementButton.pinLeft(to: self.view, 20) // задаем границу слева
        incrementButton.pinRight(to: self.view, 20) // задаем границу справа
        incrementButton.addTarget(
            self,
            action: #selector(incrementButtonPressed),
            for: .touchUpInside
        )
    }
    
    // функция для создание тени кнопки
    private func applyShadow(_ button: UIButton) {
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
    
    // задаем параметры лабельки-счетчика
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"

        self.view.addSubview(valueLabel)
        valueLabel.pinCenter(to: self.view) // ставим по центру
        valueLabel.pinCenterY(to: incrementButton.topAnchor, -50) // от основной кнопки вверх по вертикали +50
    }

    // начальная функция
    func setupView() {
        view.backgroundColor = .systemGray6
        colorPaletteView.isHidden = true
        
        setupIncrementButton()
        setupValueLabel()
        setupMenuButtons()
        setupColorControlSV()
    }
    
    private func setupColorControlSV() {
        colorPaletteView.isHidden = true
        view.addSubview(colorPaletteView)
        
        colorPaletteView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorPaletteView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 10),
            colorPaletteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            colorPaletteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            colorPaletteView.bottomAnchor.constraint(equalTo: buttonsSV.topAnchor, constant: -10)
        ])
        colorPaletteView.addTarget(self, action: #selector(changeColor(_:)), for: .touchDragInside)
    }
    
    @objc
    private func paletteButtonPressed() {
        colorPaletteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    @objc
    private func changeColor(_ slider: ColorPaleteView) {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = slider.chosenColor
        }
    }
    
    // задание параметров для лабельки-достижений
    @discardableResult
    private func setupCommentView() -> UIView {
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 12

        view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor) // ставим сверху
        commentView.pinLeft(to: view, 20) // задаем левую границу
        commentView.pinRight(to: view, 20) // задаем правую границу
        
        // параметры визуальной части
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center

        commentView.addSubview(commentLabel)
        commentView.setHeight(50) // задаем размер
        commentLabel.pin(to: commentView, [.top, .left, .bottom, .right])

        return commentView
    }
    
    // функция для изменения лабельки при достижении счетчика какого-то значения
    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "🎉🎉🎉🎉🎉🎉🎉🎉🎉"
        case 50...60:
            commentLabel.text = "BIG BOY!!!😎"
        case 60...70:
            commentLabel.text = "GO! GO! GO! 🥵"
        case 70...80:
            commentLabel.text = "⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️"
        case 80...90:
            commentLabel.text = " 80! 🤯\n Go higher!"
        case 90...100:
            commentLabel.text = "100!!🤩\n To the moon!!🌚🌚"
        default:
            break
        }
        commentLabel.font = commentLabel.font.withSize(20) // задаем размер текста
    }
    
    // функция, отвечающая за нажатие на кнопку
    @objc
    private func incrementButtonPressed() {
        value += 1

        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()

        UIView.animate(withDuration: 1) {
            self.updateUI()
        }
    }
    
    // функция для изменения текста лабельки-счетчика
    func updateUI() {
        valueLabel.text = String(value)
        updateCommentLabel(value: value)
    }
    
    // функция создания кнопки
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 40.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true

        return button
    }
    
    // создание дополнительных кнопок без функционала
    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        colorsButton.addTarget(
            self,
            action: #selector(paletteButtonPressed),
            for: .touchUpInside
        )
        let notesButton = makeMenuButton(title: "📝")

        let newsButton = makeMenuButton(title: "📰")
        
        // применяем функцию теней для каждой кнопки
        applyShadow(colorsButton)
        applyShadow(notesButton)
        applyShadow(newsButton)
        buttonsSV = UIStackView(arrangedSubviews: [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually

        self.view.addSubview(buttonsSV)
        buttonsSV.pinLeft(to: self.view, 20) // задаем левую границу
        buttonsSV.pinRight(to: self.view, 20) // задаем правую границу
        buttonsSV.pinBottom(to: self.view, 70) // задаем границу снизу
    }
}
