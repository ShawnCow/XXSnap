//
//  XXSnapMaskView.m
//  DySnap
//
//  Created by Shawn on 2016/12/12.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "XXSnapMaskView.h"

@interface XXSnapMaskView ()
{
    CGRect oldDisplayRect;
}

@property (nonatomic, copy) NSArray * maskThemeViews;
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) NSLayoutConstraint * contentLeftMarginConstraint;
@property (nonatomic, strong) NSLayoutConstraint * contentTopMarginConstraint;
@property (nonatomic, strong) NSLayoutConstraint * contentWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint * contentHeightConstraint;

@end

@implementation XXSnapMaskView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _setDefaultSnapMaskView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setDefaultSnapMaskView];
    }
    return self;
}

- (void)_setDefaultSnapMaskView
{
    
    NSMutableArray * tempMaskThemeViews = [NSMutableArray array];
    
    self.backgroundColor = [UIColor clearColor];
    _maskColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.3];
    
    _displayRect = CGRectMake(80, 100, 200, 200);
    
    UIView * contentView = [[UIView alloc]initWithFrame:CGRectMake(80, 100, 200, 200)];
    contentView.backgroundColor = [UIColor clearColor];
    [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:contentView];
    self.contentView = contentView;
    
    self.contentLeftMarginConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:80];
    self.contentTopMarginConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1. constant:100];
    self.contentWidthConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1. constant:200];
    self.contentHeightConstraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:200];
    
    [self addConstraint:self.contentLeftMarginConstraint];
    [self addConstraint:self.contentTopMarginConstraint];
    [self.contentView addConstraint:self.contentWidthConstraint];
    [self.contentView addConstraint:self.contentHeightConstraint];
    
    UIView * gesView = [[UIView alloc]initWithFrame:contentView.bounds];
    gesView.backgroundColor = [UIColor clearColor];
    gesView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:gesView];
    
    UIPinchGestureRecognizer * pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [gesView addGestureRecognizer:pinch];
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [gesView addGestureRecognizer:pan];
    
    UIView * leftTopView = [UIView new];
    [leftTopView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:leftTopView];
    leftTopView.backgroundColor = [UIColor redColor];
    UIPanGestureRecognizer * leftTopPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(leftTopViewPan:)];
    [leftTopView addGestureRecognizer:leftTopPan];
    
    [leftTopView addConstraint:[NSLayoutConstraint constraintWithItem:leftTopView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1. constant:20]];
    [leftTopView addConstraint:[NSLayoutConstraint constraintWithItem:leftTopView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1. constant:20]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:leftTopView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:leftTopView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    UIView * rightTopView = [UIView new];
    [rightTopView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:rightTopView];
    rightTopView.backgroundColor = [UIColor redColor];
    
    UIPanGestureRecognizer * rightTopPan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(rightTopViewPan:)];
    [rightTopView addGestureRecognizer:rightTopPan];
    
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1. constant:20]];
    [rightTopView addConstraint:[NSLayoutConstraint constraintWithItem:rightTopView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1. constant:20]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:rightTopView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:rightTopView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    
    UIView * leftView = [UIView new];
    leftView.userInteractionEnabled = NO;
    [leftView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:leftView];
    [tempMaskThemeViews addObject:leftView];
    leftView.backgroundColor = _maskColor;
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:leftView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    UIView * rightView = [UIView new];
    rightView.userInteractionEnabled = NO;
    [rightView setTranslatesAutoresizingMaskIntoConstraints:NO];
    rightView.backgroundColor = _maskColor;
    [self addSubview:rightView];
    [tempMaskThemeViews addObject:rightView];
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem:rightView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:rightView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:rightView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:rightView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    
    UIView * topView = [UIView new];
    topView.userInteractionEnabled = NO;
    [topView setTranslatesAutoresizingMaskIntoConstraints:NO];
    topView.backgroundColor = _maskColor;
    [self addSubview:topView];
    [tempMaskThemeViews addObject:topView];
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem:topView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:topView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:topView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:topView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    UIView * bottomView = [UIView new];
    bottomView.userInteractionEnabled = NO;
    [bottomView setTranslatesAutoresizingMaskIntoConstraints:NO];
    bottomView.backgroundColor = _maskColor;
    [self addSubview:bottomView];
    [tempMaskThemeViews addObject:bottomView];
    
    [self addConstraint: [NSLayoutConstraint constraintWithItem:bottomView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:bottomView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:leftView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:bottomView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self addConstraint: [NSLayoutConstraint constraintWithItem:bottomView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:rightView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    self.maskThemeViews = tempMaskThemeViews;
}

- (void)setDisplayRect:(CGRect)displayRect
{
    [self setDisplayRect:displayRect animated:NO];
}

- (void)setDisplayRect:(CGRect)displayRect animated:(BOOL)aniamted
{
    if (CGRectEqualToRect(_displayRect, displayRect) == true || displayRect.size.width < 10 || displayRect.size.height < 10) {
        return;
    }
    _displayRect = displayRect;
    
    self.contentLeftMarginConstraint.constant = _displayRect.origin.x;
    self.contentTopMarginConstraint.constant = _displayRect.origin.y;
    self.contentWidthConstraint.constant = _displayRect.size.width;
    self.contentHeightConstraint.constant = _displayRect.size.height;
    
    if (aniamted) {
        [UIView animateWithDuration:0.25 animations:^{
            [self setNeedsLayout];
        }];
    }
}

- (void)setMaskColor:(UIColor *)maskColor
{
    if ([_maskColor isEqual:maskColor]) {
        return;
    }
    _maskColor = maskColor;

    for (UIView * view in _maskThemeViews) {
        view.backgroundColor = _maskColor;
    }
}

#pragma mark - 

- (void)pinch:(UIPinchGestureRecognizer *)pinch
{
    if (pinch.state == UIGestureRecognizerStateBegan) {
        oldDisplayRect = self.displayRect;
    }
    CGRect displayRect = oldDisplayRect;
    float width = displayRect.size.width * pinch.scale;
    float height = displayRect.size.height * pinch.scale;
    
    if (width > self.bounds.size.width) {
        width = self.bounds.size.width;
    }
    if (height > self.bounds.size.height) {
        height = self.bounds.size.height;
    }
    
    float offsetX = width/2 - displayRect.size.width/2;
    float offsetY = height/2 - displayRect.size.height/2;
    
    CGRect nDisplayRect = CGRectMake(displayRect.origin.x - offsetX, displayRect.origin.y - offsetY, width, height);
    [self setDisplayRect:nDisplayRect animated:YES];
    
    [self _callChangeDisplayRectDelegateMethod];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGPoint pnt = [pan translationInView:self.contentView];
    CGRect displayRect = self.displayRect;
    displayRect.origin.x += pnt.x;
    displayRect.origin.y += pnt.y;
    [pan setTranslation:CGPointZero inView:self.contentView];
    [self setDisplayRect:displayRect animated:YES];
    
    [self _callChangeDisplayRectDelegateMethod];
}

- (void)leftTopViewPan:(UIPanGestureRecognizer *)pan
{
    CGPoint pnt = [pan translationInView:self.contentView];
    CGRect displayRect = self.displayRect;
    displayRect.origin.x += pnt.x;
    displayRect.origin.y += pnt.y;
    displayRect.size.width -= pnt.x;
    displayRect.size.height -= pnt.y;
    [pan setTranslation:CGPointZero inView:self.contentView];
    [self setDisplayRect:displayRect animated:YES];
    
    [self _callChangeDisplayRectDelegateMethod];
}

- (void)rightTopViewPan:(UIPanGestureRecognizer *)pan
{
    CGPoint pnt = [pan translationInView:self.contentView];
    CGRect displayRect = self.displayRect;
    displayRect.size.width += pnt.x;
    displayRect.size.height += pnt.y;
    [pan setTranslation:CGPointZero inView:self.contentView];
    [self setDisplayRect:displayRect animated:YES];
    
    [self _callChangeDisplayRectDelegateMethod];
}

- (void)_callChangeDisplayRectDelegateMethod
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(snapMaskView:didChangeToRect:)]) {
        [self.delegate snapMaskView:self didChangeToRect:self.displayRect];
    }
}

@end
