//
//  XMSegementView.m
//  
//
//  Created by 郭建斌 on 15/9/21.
//  Copyright © 2015年 郭建斌. All rights reserved.
//

#import "XMSegementView.h"

#define kStrokenColor [UIColor colorWithHexString:@"4A9BF6" alpha:1].CGColor

#define kFontNormalColor [UIColor colorWithHexString:@"4A9BF6" alpha:1]
#define kFontSelectedColor [UIColor whiteColor]

#define kWaterColor [UIColor colorWithHexString:@"4A9BF6" alpha:1]
//填充颜色
#define kShapeLayerFillColor [UIColor whiteColor]

#define kWidth 240

#define kLineWidth  0.5

@interface XMSegementBGView : UIView

@end

@implementation XMSegementBGView

+(Class)layerClass
{
    return [CAShapeLayer class];
}

@end
@interface XMSegementView ()
/**
 *  segement
 */
@property (nonatomic,weak) UISegmentedControl * titleView;
/**
 *  segement 数量
 */
@property (nonatomic,assign) NSUInteger segementCount;

@property (nonatomic,strong) XMSegementBGView * backgroundView;
/**
 *  动画的Layer
 */
@property (nonatomic,strong) CAShapeLayer * shapeLayer;

@property (nonatomic,strong) NSArray * titles;
@end

@implementation XMSegementView
#pragma mark - 用给的titles创建segement
+(instancetype)creatSegementViewWithTitles:(NSArray *)titles andFrame:(CGRect)frame
{
    XMSegementView * segementView = [[XMSegementView alloc]initWithFrame:frame];
    
    CAShapeLayer * shapeLayer = (CAShapeLayer *)segementView.layer;
    
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:segementView.bounds cornerRadius:15];
   
    path.lineWidth = kLineWidth;

    for (int i = 0; i < titles.count - 1; i ++) {
        UIBezierPath * line1 = [[UIBezierPath alloc]init];
        CGFloat x = (kWidth * 0.5 / titles.count);
        
        [line1 moveToPoint:CGPointMake(x * (i+1), 0)];
        [line1 addLineToPoint:CGPointMake(x * (i+1), 30)];
        
        [path appendPath:line1];
        
    }
    [path addClip];
    shapeLayer.path = path.CGPath;
    
    shapeLayer.fillColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    shapeLayer.strokeColor = kStrokenColor;
  

    [segementView creatSegementControlWithTitles:titles];
    
    segementView.titleView.selectedSegmentIndex = 0;
    [segementView segementTouch:segementView.titleView];
    
    segementView.titles = titles;
    return segementView;
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {

        self.strokenColor = [UIColor whiteColor];
        self.fontNormalColor = [UIColor whiteColor];
        self.fontSelectedColor =  [UIColor colorWithRed:0.87f green:0.13f blue:0.21f alpha:1.00f];
        self.waterColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
        self.shapeLayerFillColor = [UIColor colorWithRed:0.87f green:0.13f blue:0.21f alpha:1.00f];
        
    }
    return self;
}
+(Class)layerClass
{

    return [CAShapeLayer class];
}

#pragma mark - getter
-(XMSegementBGView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[XMSegementBGView alloc]init];
//        _backgroundView.size = CGSizeMake(kScreenWidth * 0.5 / _segementCount, 30);
        _backgroundView.frame = CGRectMake(0, 0, kWidth * 0.5 / _segementCount, 30);
        
        [self addSubview:_backgroundView];
    }
    return _backgroundView;
}
#pragma mark - creatSegementControlWithTitles
-(void) creatSegementControlWithTitles:(NSArray *)titles
{
    _segementCount = titles.count;
//    [self backgroundView];
    
    
    UISegmentedControl * segementedControl = [[UISegmentedControl alloc]initWithItems:titles];
    self.segementedControl = segementedControl;
    segementedControl.frame = self.bounds;

    segementedControl.tintColor = [UIColor clearColor];//[UIColor colorWithRed:0.20f green:0.75f blue:0.51f alpha:1.00f];//
    
   [self addSubview:segementedControl];
    
    NSDictionary * norAttri = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:kFontNormalColor};
    
    NSDictionary * attri = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:kFontSelectedColor};
    
    [segementedControl setTitleTextAttributes:norAttri forState:UIControlStateNormal];
    [segementedControl setTitleTextAttributes:attri forState:UIControlStateSelected];

    [segementedControl addTarget:self action:@selector(segementTouch:) forControlEvents:UIControlEventValueChanged];

    self.titleView = segementedControl;
    
}
#pragma mark - setbackgroundView

#pragma mark - segementTouch
- (void) segementTouch:(UISegmentedControl *)segement
{

    [self segementBackgroundViewMoveWithIndex:segement.selectedSegmentIndex];
    
    [self bringSubviewToFront:self.titleView];
    if ([self.delegate respondsToSelector:@selector(segementControlSelected:andSegement:)]) {
        [self.delegate segementControlSelected:self andSegement:segement];
    }
}

#pragma mark -判断segement实现动画
- (void) segementBackgroundViewMoveWithIndex:(NSInteger )idnex
{
    _shapeLayer = (CAShapeLayer *)self.backgroundView.layer;
    
    UIColor* color = kWaterColor;
    _shapeLayer.fillColor = color.CGColor;
    UIBezierPath* rectanglePath;
    
    if (idnex == 0) {
        rectanglePath = [UIBezierPath bezierPathWithRoundedRect: self.backgroundView.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii: CGSizeMake(15, 15)];
        

    }
    else if (idnex == self.titles.count - 1)
    {
        rectanglePath = [UIBezierPath bezierPathWithRoundedRect: self.backgroundView.bounds byRoundingCorners: UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii: CGSizeMake(15, 15)];

    }
    else
    {
        rectanglePath = [UIBezierPath bezierPathWithRoundedRect: self.backgroundView.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii: CGSizeMake(0, 0)];
        

    }
    

    [self moveAnimationWithIndex:idnex and:rectanglePath];
}
#pragma mark - 根据贝塞尔曲线做动画
-(void)moveAnimationWithIndex:(NSInteger)index and:(UIBezierPath *)path
{
    CGFloat x = (kWidth * 0.5 / _segementCount);

    [UIView animateWithDuration:self.animaitonDur animations:^{
        self.backgroundView.frame = CGRectMake(index * x, 0, x, 30);
        _shapeLayer.path = path.CGPath;
    } completion:^(BOOL finished) {
        
    }];
}
@end
