//
//  NavigationControllerDelegate.m
//  transtionVC
//
//  Created by 李赛 on 15/10/14.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "CircleTransitionAnimator.h"


@implementation NavigationControllerDelegate
-(void)awakeFromNib
{
    [super awakeFromNib];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    [_navigationController.view addGestureRecognizer:panGesture];
}

-(void)panGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
     CGFloat completionProgress = [gestureRecognizer translationInView:self.navigationController.view].x/CGRectGetWidth(self.navigationController.view.bounds);
    /**
     *  稳定进度区，让其在0.0~1.0
     */
    completionProgress=MIN(1.0, MAX(0.0, completionProgress));
    
    if (gestureRecognizer.state==UIGestureRecognizerStateBegan) {
        self.interactionController=[[UIPercentDrivenInteractiveTransition alloc]init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (gestureRecognizer.state==UIGestureRecognizerStateChanged)
    {
         [self.interactionController updateInteractiveTransition:completionProgress];
    }else if (gestureRecognizer.state==UIGestureRecognizerStateEnded||gestureRecognizer.state==UIGestureRecognizerStateCancelled)
    {
        if (completionProgress>0.5) {
            [self.interactionController finishInteractiveTransition];
        }else
        {
            [self.interactionController cancelInteractiveTransition];
        }
        
        self.interactionController = nil;
    }
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController NS_AVAILABLE_IOS(7_0)
{
    return self.interactionController;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{

    return [CircleTransitionAnimator new];
  
}


@end
