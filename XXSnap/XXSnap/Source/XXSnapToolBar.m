//
//  XXSnapToolBar.m
//  DySnap
//
//  Created by Shawn on 2016/12/13.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "XXSnapToolBar.h"

@interface XXSnapToolBar ()
{
    NSLayoutConstraint * stacktViewWidhtConstratin;
}

@property (nonatomic, weak) UIButton * cancelBtn;

@property (nonatomic, weak) UIButton * saveBtn;

@property (nonatomic, weak) UIStackView * stackView;

@end

@implementation XXSnapToolBar

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _setDefaultSnapToolBar];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setDefaultSnapToolBar];
    }
    return self;
}

- (void)_setDefaultSnapToolBar
{
    self.backgroundColor = [UIColor colorWithRed:1. green:1. blue:1. alpha:0.5];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    
    UIStackView * stackView = [[UIStackView alloc]initWithFrame:self.bounds];
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.spacing = 10;
    [self addSubview:stackView];
    self.stackView = stackView;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:stackView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:stackView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:stackView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:stackView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"  取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelBtn sizeToFit];
    [cancelBtn addConstraint:[NSLayoutConstraint constraintWithItem:cancelBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:cancelBtn.frame.size.width + 10]];
    [cancelBtn addTarget:self action:@selector(_cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.cancelBtn = cancelBtn;
    [stackView addArrangedSubview:cancelBtn];
    
    UIButton * addWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addWordBtn setTitle:@"A" forState:UIControlStateNormal];
    [addWordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addWordBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [addWordBtn addConstraint:[NSLayoutConstraint constraintWithItem:addWordBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:addWordBtn.frame.size.width + 20]];
    [stackView addArrangedSubview:addWordBtn];
    
    UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"确定  " forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [doneBtn sizeToFit];
     [doneBtn addConstraint:[NSLayoutConstraint constraintWithItem:doneBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:doneBtn.frame.size.width + 10]];
    [doneBtn addTarget:self action:@selector(_saveBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.saveBtn = doneBtn;
    [stackView addArrangedSubview:doneBtn];
    
    float maxWidth = cancelBtn.frame.size.width + 10 + addWordBtn.frame.size.width + 20 + doneBtn.frame.size.width + 10 + 10 * 2;
    stacktViewWidhtConstratin = [NSLayoutConstraint constraintWithItem:stackView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:maxWidth];
    [stackView addConstraint:stacktViewWidhtConstratin];
}

- (void)_cancelBtnAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(snapToolBarDidTapCancel:)]) {
        [self.delegate snapToolBarDidTapCancel:self];
    }
}

- (void)_saveBtnAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(snapToolBarDidTapSave:)]) {
        [self.delegate snapToolBarDidTapSave:self];
    }
}

@end
