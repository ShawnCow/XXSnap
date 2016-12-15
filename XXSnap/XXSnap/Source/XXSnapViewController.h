//
//  XXSnapViewController.h
//  DySnap
//
//  Created by Shawn on 2016/12/12.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXSnapViewController;

@protocol XXSnapViewControllerDelegate <NSObject>

@optional

- (void)snapViewControllerDidCancel:(XXSnapViewController *)snapViewController;

- (void)snapViewController:(XXSnapViewController *)snapViewController didSnapImage:(UIImage *)image;

@end

@interface XXSnapViewController : UIViewController

+ (UIImage *)snapScreenImage;

- (instancetype)initWithImage:(UIImage *)image;

@property (nonatomic, readonly) UIImage * image;

@property (nonatomic, weak) id<XXSnapViewControllerDelegate> delegate;

@end
