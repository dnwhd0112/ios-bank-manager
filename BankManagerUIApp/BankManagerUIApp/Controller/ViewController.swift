//
//  BankManagerUIApp - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import UIKit
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    func makeUIViewController(context: Context) -> ViewController {
            return ViewController()
        }

        func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        }
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}

class ViewController: UIViewController {
    let waitingClientVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill

        return stackView
    }()
    
    let workingClientVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let safeArea = view.safeAreaLayoutGuide
        
        let verticalStackView: UIStackView = {
            let stackView = UIStackView()
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .equalSpacing

            return stackView
        }()
        
        let addButton = UIButton()
        addButton.setTitle("고객 10명 추가", for: .normal)
        addButton.setTitleColor(.blue, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addClients), for: .touchUpInside)
        
        let resetButton = UIButton()
        resetButton.setTitle("초기화", for: .normal)
        resetButton.setTitleColor(.red, for: .normal)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalStackView1: UIStackView = {
            let stackView = UIStackView()
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fillEqually

            return stackView
        }()
        
        let timerLabel = UILabel()
        
        timerLabel.text = "업무시간 - 0000"
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.textAlignment = .center
        
        let horizontalStackView2: UIStackView = {
            let stackView = UIStackView()
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fillEqually

            return stackView
        }()
        
        let waitLabel = UILabel()
        waitLabel.text = "대기중"
        waitLabel.backgroundColor = .green
        waitLabel.textAlignment = .center
        waitLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let workingLabel = UILabel()
        workingLabel.text = "업무중"
        workingLabel.backgroundColor = .blue
        workingLabel.textAlignment = .center
        workingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalStackView3: UIStackView = {
            let stackView = UIStackView()
            
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.alignment = .center
            stackView.distribution = .fillEqually

            return stackView
        }()
        
        view.addSubview(verticalStackView)
        verticalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        verticalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        verticalStackView.addArrangedSubview(horizontalStackView1)
        horizontalStackView1.addArrangedSubview(addButton)
        horizontalStackView1.addArrangedSubview(resetButton)
        verticalStackView.addArrangedSubview(timerLabel)
        horizontalStackView2.addArrangedSubview(waitLabel)
        horizontalStackView2.addArrangedSubview(workingLabel)
        verticalStackView.addArrangedSubview(horizontalStackView2)
        
        verticalStackView.addArrangedSubview(horizontalStackView3)
        horizontalStackView3.addArrangedSubview(waitingClientVerticalStackView)
        horizontalStackView3.addArrangedSubview(workingClientVerticalStackView)
        
        waitingClientVerticalStackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.7).isActive = true
        workingClientVerticalStackView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.7).isActive = true
        
        bankProcess.setBank(delegate: self)
    }
    
    
    //MARK: ViewdidLoard 끝
    var bankProcess = BankProcess()
    
    @objc
    func addClients() {
        bankProcess.addClientQueue()
    }
    
}

protocol ViewControllerDelegate: AnyObject {
    func addWaitingClientLabel(text: String, color: UIColor)
    func addWorkingClientLabel(text: String, color: UIColor)
    func removeWorkingClientLable(text: String, color: UIColor)
}

extension ViewController: ViewControllerDelegate {
    func addWaitingClientLabel(text: String, color: UIColor) {
        let label = UILabel()
        label.textColor = color
        label.text = text
        label.textAlignment = .center
        
        waitingClientVerticalStackView.addArrangedSubview(label)
    }
    
    func addWorkingClientLabel(text: String, color: UIColor) {
        let label = waitingClientVerticalStackView.arrangedSubviews.filter{
            if let label = $0 as? UILabel, label.text == text {
                return true
            }
            return false
        }
        
        label.forEach{
            waitingClientVerticalStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
            workingClientVerticalStackView.addArrangedSubview($0)
        }
    }
    
    func removeWorkingClientLable(text: String, color: UIColor) {
        let label = workingClientVerticalStackView.arrangedSubviews.filter{
            if let label = $0 as? UILabel, label.text == text {
                return true
            }
            return false
        }
        
        label.forEach{
            workingClientVerticalStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}
