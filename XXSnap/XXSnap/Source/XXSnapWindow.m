//
//  XXSnapWindow.m
//  DySnap
//
//  Created by Shawn on 2016/12/12.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "XXSnapWindow.h"
#import "XXSnapViewController.h"

@interface XXSnapWindow ()<XXSnapViewControllerDelegate>

@property (nonatomic, copy) XXSnapWindowCancelCompletion cancelCompletion;

@property (nonatomic, copy) XXSnapWindowGetImageCompletion finishCompletion;

@property (nonatomic, weak) UIWindow * lastKeyWindow;

@property (nonatomic, strong) id rSelf;//retain self

@end

@implementation XXSnapWindow

+ (void)showSnapWithFinishCompletion:(XXSnapWindowGetImageCompletion)finishCompletion cancelCompletion:(XXSnapWindowCancelCompletion)cancelCompletion
{
    XXSnapWindow * window = [[XXSnapWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.cancelCompletion = cancelCompletion;
    window.finishCompletion = finishCompletion;
    [window show];
}

- (void)show
{
    if (self.rootViewController) {
        return;
    }
    
    self.rSelf = self;
    
    self.lastKeyWindow = [[UIApplication sharedApplication]keyWindow];
    XXSnapViewController * vc = [[XXSnapViewController alloc]initWithImage:[XXSnapViewController snapScreenImage]];
    vc.delegate = self;
    self.rootViewController = vc;
    [self makeKeyAndVisible];
}

- (void)dismiss
{
    self.rSelf = nil;
    [self resignKeyWindow];
    self.cancelCompletion = nil;
    self.finishCompletion = nil;
}

- (void)snapViewControllerDidCancel:(XXSnapViewController *)snapViewController
{
    if (self.cancelCompletion) {
        self.cancelCompletion();
    }
    [self dismiss];
}

- (void)snapViewController:(XXSnapViewController *)snapViewController didSnapImage:(UIImage *)image
{
    if (self.finishCompletion) {
        self.finishCompletion(image);
    }
    [self dismiss];
}

- (void)dealloc
{
    NSLog(@"");
}
@end
