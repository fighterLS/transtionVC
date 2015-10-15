//
//  CircleTransitionAnimator.m
//  transtionVC
//
//  Created by 李赛 on 15/10/14.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "CircleTransitionAnimator.h"

@implementation CircleTransitionAnimator
// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    //1
    self.transitionContext = transitionContext;
    
    //2
    UIView *containerView = transitionContext.containerView;
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIButton *button = fromViewController.button
    
    //3
    [containerView addSubview:toViewController.view];
    
    //4
    UIBezierPath *circleMaskPathInitial=[UIBezierPath bezierPathWithOvalInRect:CGRectZero];

    
    CGPoint extremePoint = CGPointMake(CGRectGetWidth(toViewController.view.bounds), CGRectGetHeight(toViewController.view.bounds));
    
    double radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y));
    UIBezierPath *circleMaskPathFinal =[UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectZero, -radius, -radius)];
    
    //5
    CAShapeLayer *maskLayer =[CAShapeLayer layer];
    maskLayer.path = circleMaskPathFinal.CGPath;
    toViewController.view.layer.mask = maskLayer;
    
    //6
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(circleMaskPathInitial.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(circleMaskPathFinal.CGPath);
    maskLayerAnimation.duration =[self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask=nil;
}

@end
