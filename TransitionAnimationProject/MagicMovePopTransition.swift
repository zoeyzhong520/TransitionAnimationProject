//
//  MagicMovePopTransition.swift
//  TransitionAnimationProject
//
//  Created by zhifu360 on 2019/5/10.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class MagicMovePopTransition: NSObject {

    static let instance = MagicMovePopTransition()
    
}

extension MagicMovePopTransition: UIViewControllerAnimatedTransitioning {
    
    //返回转场动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    //转场动画的具体内容
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //获取源控制器、目标控制器
        let fromVC = transitionContext.viewController(forKey: .from) as! SecondViewController
        let toVC = transitionContext.viewController(forKey: .to) as! FirstViewController
        let contanier = transitionContext.containerView
        //设置目标控制器位置及透明度
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.view.alpha = 0
        //添加到container中
        contanier.insertSubview(toVC.view, belowSubview: fromVC.view)
        //执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            toVC.view.alpha = 1
            fromVC.view.alpha = 0
        }) { (finish) in
            //动画完成后执行此方法，让系统管理navigation
            //这里要注意完成转场动画方法的参数
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}
