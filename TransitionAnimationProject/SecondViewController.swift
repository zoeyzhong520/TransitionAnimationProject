//
//  SecondViewController.swift
//  TransitionAnimationProject
//
//  Created by zhifu360 on 2019/5/10.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController {

    lazy var button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btn.layer.cornerRadius = 40
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return btn
    }()
    
    var percentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addScreenEdge()
        navigationController?.delegate = self
    }
    
    func setPage() {
        title = "演示2"
        view.addSubview(button)
        view.backgroundColor = UIColor.yellow
        
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
    
    func addScreenEdge() {
        //加入边缘滑动手势
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeAction(_:)))
        edgePan.edges = .left
        view.addGestureRecognizer(edgePan)
    }
    
    @objc func screenEdgeAction(_ edgePan: UIScreenEdgePanGestureRecognizer) {
        //创建UIPercentDrivenInteractiveTransition属性，实现手势百分比更新
        let progress = edgePan.translation(in: view).x / view.bounds.size.width
        if edgePan.state == .began {
            percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
            navigationController?.popViewController(animated: true)
        } else if edgePan.state == .changed {
            percentDrivenInteractiveTransition?.update(progress)
        } else if edgePan.state == .cancelled || edgePan.state == .ended {
            if progress > 0.5 {
                percentDrivenInteractiveTransition?.finish()
            } else {
                percentDrivenInteractiveTransition?.cancel()
            }
            percentDrivenInteractiveTransition = nil//释放对象
        }
        
    }
    
    @objc func btnClick() {
        navigationController?.popViewController(animated: true)
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

extension SecondViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        if animationController is MagicMovePopTransition {
            return self.percentDrivenInteractiveTransition
        } else {
            return nil
        }
        
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == UINavigationController.Operation.pop {
            return MagicMovePopTransition()
        } else {
            return nil
        }
        
    }
    
}
