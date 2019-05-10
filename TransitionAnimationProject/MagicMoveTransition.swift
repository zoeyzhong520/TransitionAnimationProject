//
//  MagicMoveTransition.swift
//  TransitionAnimationProject
//
//  Created by zhifu360 on 2019/5/10.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

///自定义转场动画
class MagicMoveTransition: NSObject {

    static let instance = MagicMoveTransition()
    
    
}

extension MagicMoveTransition: UIViewControllerAnimatedTransitioning {
    
    //指定转场动画执行的时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    //转场动画的具体内容
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //获取动画的源控制器和目标控制器
        let fromVC = transitionContext.viewController(forKey: .from) as! FirstViewController
        let toVC = transitionContext.viewController(forKey: .to) as! SecondViewController
        let contanier = transitionContext.containerView
        //设置目标控制器的位置，并设置透明度为0，以在后续动画中慢慢显示为1
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.view.alpha = 0
        //添加到container中
        contanier.addSubview(toVC.view)
        //执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            toVC.view.alpha = 1
        }) { (finish) in
            //动画完成后执行此方法，让系统管理navigation
            transitionContext.completeTransition(true)
        }
    }
    
}
