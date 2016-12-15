//
//  ViewController.m
//  XXSnap
//
//  Created by Shawn on 2016/12/15.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "ViewController.h"
#import "XXSnapWindow.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testAction:(id)sender {
    
    [XXSnapWindow showSnapWithFinishCompletion:^(UIImage *image) {
        self.imgView.backgroundColor = [UIColor whiteColor];
        self.imgView.image = image;
    } cancelCompletion:^{
        
    }];
}

@end
