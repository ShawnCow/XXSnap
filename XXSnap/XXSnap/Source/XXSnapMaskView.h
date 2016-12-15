//
//  XXSnapMaskView.h
//  DySnap
//
//  Created by Shawn on 2016/12/12.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXSnapMaskView;

@protocol XXSnapMaskViewDelegate <NSObject>

@optional

- (void)snapMaskView:(XXSnapMaskView *)snapMaskView didChangeToRect:(CGRect)rect;

@end

@interface XXSnapMaskView : UIView

@property (nonatomic, strong) UIColor * maskColor;//rgb 0,0,0,0.3

@property (nonatomic) CGRect displayRect;

- (void)setDisplayRect:(CGRect)displayRect animated:(BOOL)aniamted;

@property (nonatomic, weak) id <XXSnapMaskViewDelegate> delegate;

@end
