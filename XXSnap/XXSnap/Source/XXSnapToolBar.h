//
//  XXSnapToolBar.h
//  DySnap
//
//  Created by Shawn on 2016/12/13.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXSnapToolBar;

@protocol XXSnapToolBarDelegate <NSObject>

@optional

- (void)snapToolBarDidTapCancel:(XXSnapToolBar *)snapToolBar;
- (void)snapToolBarDidTapSave:(XXSnapToolBar *)snapToolBar;

@end

@interface XXSnapToolBar : UIView

@property (nonatomic, weak) id <XXSnapToolBarDelegate> delegate;

@end
