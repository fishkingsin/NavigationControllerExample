//
//  ViewController.swift
//  NavigationControllerExample
//
//  Created by James Kong on 22/5/2020.
//  Copyright © 2020 James Kong. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(gotoNext), for: .touchUpInside)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        
    }
    @objc
    func gotoNext() {
        let newController = SecondViewController()
        navigationController?.pushViewController(newController, animated: true)
        
    }
    
    
}

class SecondViewController: UIViewController, UIGestureRecognizerDelegate {
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
           view.backgroundColor = .red
        navigationController?.interactivePopGestureRecognizer?.addTarget(self, action: #selector(onGesture))
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        let button = UIButton(type: .custom)
        button.setTitle("Button", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        
    }
    
    @objc
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    private var currentTransitionCoordinator: UIViewControllerTransitionCoordinator?

    @objc private func onGesture(sender: UIGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            print("sender.state \(sender.state)")
            if let ct = navigationController?.transitionCoordinator {
                currentTransitionCoordinator = ct
            }
        case .cancelled, .ended:
            print("sender.state \(sender.state)")
            currentTransitionCoordinator = nil
        case .possible, .failed:
            break
        default:
            print("sender.state \(sender.state)")
        }

        if let currentTransitionCoordinator = currentTransitionCoordinator {
            print(currentTransitionCoordinator.percentComplete)
        }

    }

}

