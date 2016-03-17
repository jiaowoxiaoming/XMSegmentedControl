//
//  ViewController.m
//  XMSegmentedControl
//
//  Created by apple on 16/3/17.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "XMSegementView.h"
@interface ViewController ()<XMSegementViewDelegate>
@property (nonatomic,weak) XMSegementView * segementView;
@end

@implementation ViewController
- (IBAction)swipeGestureAction:(UISwipeGestureRecognizer *)sender {
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        
        self.segementView.segementedControl.selectedSegmentIndex = 0;
        [self.segementView segementTouch:self.segementView.segementedControl];
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        self.segementView.segementedControl.selectedSegmentIndex = 1;
        [self.segementView segementTouch:self.segementView.segementedControl];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self segementView];
}
- (XMSegementView *)segementView{
    if (!_segementView) {
        XMSegementView *segementView = [XMSegementView creatSegementViewWithTitles:@[@"视频",@"音频"] andFrame:CGRectMake(0, 0, 120, 30)];
        self.navigationItem.titleView = segementView;
        _segementView = segementView;
        _segementView.delegate = self;
    }
    return _segementView;
}
#pragma mark - XMSegementViewDelegate
-(void)segementControlSelected:(XMSegementView *)segementView andSegement:(UISegmentedControl *)sgementControl
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
