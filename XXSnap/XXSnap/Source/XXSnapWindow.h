//
//  XXSnapWindow.h
//  DySnap
//
//  Created by Shawn on 2016/12/12.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^XXSnapWindowCancelCompletion)(void);

typedef void (^XXSnapWindowGetImageCompletion)(UIImage * image);

@interface XXSnapWindow : UIWindow

+ (void)showSnapWithFinishCompletion:(XXSnapWindowGetImageCompletion)finishCompletion cancelCompletion:(XXSnapWindowCancelCompletion)cancelCompletion;

@end
