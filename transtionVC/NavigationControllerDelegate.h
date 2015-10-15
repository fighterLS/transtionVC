//
//  NavigationControllerDelegate.h
//  transtionVC
//
//  Created by 李赛 on 15/10/14.
//  Copyright © 2015年 李赛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NavigationControllerDelegate : NSObject<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UINavigationController *navigationController;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionController;
@end
