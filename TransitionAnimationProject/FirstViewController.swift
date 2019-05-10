//
//  FirstViewController.swift
//  TransitionAnimationProject
//
//  Created by zhifu360 on 2019/5/10.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController {

    lazy var button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("跳转", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.layer.cornerRadius = 40
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
    }
    
    func setPage() {
        title = "演示1"
        view.addSubview(button)
        view.backgroundColor = UIColor.gray
        navigationController?.navigationBar.isHidden = true
        
        //添加约束
        button.translatesAutoresizingMaskIntoConstraints = false
        let btnCenterXCon = NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let btnCenterYCon = NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        let btnWidthCon = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 80)
        let btnHeightCon = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 80)
        button.superview?.addConstraint(btnCenterXCon)
        button.superview?.addConstraint(btnCenterYCon)
        button.superview?.addConstraint(btnWidthCon)
        button.superview?.addConstraint(btnHeightCon)
        
    }
    
    @objc func btnClick() {
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FirstViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == UINavigationController.Operation.push {
            return MagicMoveTransition()
        } else {
            return nil
        }
        
    }
    
}
