//
//  XXSnapViewController.m
//  DySnap
//
//  Created by Shawn on 2016/12/12.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "XXSnapViewController.h"
#import "XXSnapMaskView.h"
#import "XXSnapToolBar.h"

@interface XXSnapViewController ()<XXSnapToolBarDelegate>
{
    NSLayoutConstraint * toolBarTopConstraint;
}

@property (nonatomic, weak) UIImageView * imageView;

@property (nonatomic, weak) XXSnapMaskView * editContentView;

@property (nonatomic, weak) XXSnapToolBar * toolBar;

@property (nonatomic) BOOL showToolBar;

@end

@implementation XXSnapViewController

+ (UIImage *)snapScreenImage
{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

//    UIView * view = [[UIScreen mainScreen] snapshotViewAfterScreenUpdates:NO];
//    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 1);
//    [[[UIApplication sharedApplication]keyWindow]addSubview:view];
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();

    return image;
}

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * imgView = [UIImageView new];
    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imgView.frame = self.view.bounds;
    [self.view addSubview:imgView];
    imgView.image = self.image;
    self.imageView = imgView;
    
    XXSnapMaskView * contentView = [[XXSnapMaskView alloc]initWithFrame:self.view.bounds];
    [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:contentView];
    self.editContentView = contentView;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
//    XXSnapToolBar * toolBar = [[XXSnapToolBar alloc]initWithFrame:CGRectZero];
//    toolBar.delegate = self;
//    toolBar.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:toolBar];
//    self.toolBar = toolBar;
//    [toolBar addConstraint:[NSLayoutConstraint constraintWithItem:toolBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:40]];
//    toolBarTopConstraint = [NSLayoutConstraint constraintWithItem:toolBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:-40];
//    [self.view addConstraint:toolBarTopConstraint];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:toolBar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1. constant:0]];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.frame = CGRectMake(self.view.bounds.size.width - 60, 25, 50, 30);
    btn.layer.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.900].CGColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 5;
    btn.layer.shadowOpacity = YES;
    btn.layer.shadowRadius = 4;
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.layer.shadowColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.2].CGColor;
    [self.view addSubview:btn];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:-10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:25]];
    [btn addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
    [btn addConstraint:[NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30]];
    [btn addTarget:self action:@selector(_doneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.showsTouchWhenHighlighted = YES;
    cancelBtn.frame = CGRectMake(10, 25, 50, 30);
    cancelBtn.layer.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.900].CGColor;
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.layer.cornerRadius = 5;
    cancelBtn.layer.shadowOpacity = YES;
    cancelBtn.layer.shadowRadius = 4;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.layer.shadowColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.2].CGColor;
    [self.view addSubview:cancelBtn];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:cancelBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:cancelBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:25]];
    [cancelBtn addConstraint:[NSLayoutConstraint constraintWithItem:cancelBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50]];
    [cancelBtn addConstraint:[NSLayoutConstraint constraintWithItem:cancelBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30]];
    [cancelBtn addTarget:self action:@selector(_cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 

- (void)setShowToolBar:(BOOL)showToolBar
{
    [self setShowToolBar:showToolBar animated:NO];
}

- (void)setShowToolBar:(BOOL)showToolBar animated:(BOOL)animated
{
    if (_showToolBar == showToolBar) {
        return;
    }
    _showToolBar = showToolBar;
    
    if (_showToolBar) {
        toolBarTopConstraint.constant = 10;
    }else
        toolBarTopConstraint.constant = -40;
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark - 

- (void)_toolBarAction:(UIButton *)btn
{
    BOOL showToolBar = ![self showToolBar];
    [self setShowToolBar:showToolBar animated:YES];
}

- (void)_cancelBtnAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(snapViewControllerDidCancel:)]) {
        [self.delegate snapViewControllerDidCancel:self];
    }
}

- (void)_doneBtnAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(snapViewController:didSnapImage:)]) {
        UIGraphicsBeginImageContextWithOptions(self.editContentView.displayRect.size, YES, [UIScreen mainScreen].scale);
        [self.image drawAtPoint:CGPointMake(-self.editContentView.displayRect.origin.x, -self.editContentView.displayRect.origin.y)];;
        UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self.delegate snapViewController:self didSnapImage:image];
    }
}
#pragma mark - 后续功能

- (void)snapToolBarDidTapSave:(XXSnapToolBar *)snapToolBar
{
    
}

- (void)snapToolBarDidTapCancel:(XXSnapToolBar *)snapToolBar
{
    
}

@end
