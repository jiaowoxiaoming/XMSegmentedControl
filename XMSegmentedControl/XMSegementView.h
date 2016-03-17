//
//  XMSegementView.h
//  
//
//  Created by 郭建斌 on 15/9/21.
//  Copyright © 2015年 郭建斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+XMColor.h"
@class XMSegementView;
@protocol XMSegementViewDelegate <NSObject>
/**
 *  sgement selected method
 *
 *  @param segementView   segementView
 *  @param sgementControl sgementControl
 */
- (void) segementControlSelected:(XMSegementView *)segementView andSegement:(UISegmentedControl * )sgementControl;

@end

@interface XMSegementView : UIView

@property (nonatomic,weak) id <XMSegementViewDelegate> delegate;

@property (nonatomic,weak) UISegmentedControl * segementedControl;

@property (nonatomic,strong) UIColor * strokenColor;

@property (nonatomic,strong) UIColor * fontNormalColor;

@property (nonatomic,strong) UIColor * fontSelectedColor;

@property (nonatomic,strong) UIColor * waterColor;

@property (nonatomic,strong) UIColor * shapeLayerFillColor;

/**
 *  创建导航栏的segement
 *
 *  @param titles segement Items titles
 *
 *  @return XMSegementView对象
 */
+ (instancetype) creatSegementViewWithTitles:(NSArray *)titles andFrame:(CGRect)frame;

- (void) segementTouch:(UISegmentedControl *)segement;
@end
