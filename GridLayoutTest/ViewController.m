//
//  ViewController.m
//  GridLayoutTest
//
//  Created by Sani Elfishawy on 12/3/14.
//  Copyright (c) 2014 No Plan B. All rights reserved.
//

#import "ViewController.h"
#import "TBMGridElementViewController.h"
#import "HexColor.h"

@interface ViewController ()
@property (nonatomic) UIView *mainView;
@property (nonatomic) UIView *headerView;
@end

@implementation ViewController

static const float LayoutConstGUTTER = 10;
static const float LayoutConstMARGIN = 5;
static const float LayoutConstASPECT = 0.75;
static const float LayoutConstHEADER_HEIGHT = 55;
static const float LayoutConstLOGO_HEIGHT = LayoutConstHEADER_HEIGHT * 0.4;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [self addViews];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    NSLog(@"rotated");
    [self addViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)removeViews{
    for (UIViewController *c in self.childViewControllers){
        [c removeFromParentViewController];
    }
    for (UIView *v in self.mainView.subviews){
        [v removeFromSuperview];
    }
}

- (void)addViews {
    [self removeViews];
    [self addHeaderView];
    [self addMainView];
    [self addGridViews];
}

- (void)addHeaderView{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, LayoutConstHEADER_HEIGHT)];
    self.headerView.backgroundColor = [UIColor colorWithHexString:@"1B1B19" alpha:1];
    [self.headerView addSubview:[self logoView]];
    [self.view addSubview:self.headerView];
}

- (UIImageView *)logoView{
    UIImage *li = [UIImage imageNamed:@"logo"];
    float logoAspect = li.size.width / li.size.height;
    UIImageView *lv = [[UIImageView alloc] initWithImage:li];
    float y = (LayoutConstHEADER_HEIGHT - LayoutConstLOGO_HEIGHT) / 2;
    lv.frame = CGRectMake(LayoutConstGUTTER, y, logoAspect * LayoutConstLOGO_HEIGHT, LayoutConstLOGO_HEIGHT);
    return lv;
}

- (void)addMainView{
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, LayoutConstHEADER_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height - LayoutConstHEADER_HEIGHT)];
    self.mainView.backgroundColor = [UIColor colorWithHexString:@"2E2D28" alpha:1];
    [self.view addSubview:self.mainView];
}

- (void)addGridViews{
    CGSize elSize = [self elementSize];
    float x;
    float y;
    UIView *v;
    for (int row=0; row<3; row++){
        for (int col=0; col < 3; col++){
            x = [self LayoutConstGUTTERLeft] + col * (LayoutConstMARGIN + elSize.width);
            y = [self LayoutConstGUTTERTop] + row * (LayoutConstMARGIN + elSize.height);
            v = [[UIView alloc] initWithFrame:CGRectMake(x, y, elSize.width, elSize.height)];
            [self.mainView addSubview:v];
            
            UIViewController *c = [TBMGridElementViewController new];
            [self addChildViewController:c];
            c.view.frame = CGRectMake(0, 0, elSize.width, elSize.height);
            [v addSubview:c.view];
        }
    }
}

- (CGSize) elementSize {
    long mainViewWidth = self.mainView.bounds.size.width;
    long mainViewHeight = self.mainView.bounds.size.height;
    long width;
    long height;
    if ([self isHeightConstrained]){
        height = ( mainViewHeight - 2 * (LayoutConstGUTTER + LayoutConstMARGIN) ) / 3;
        width = LayoutConstASPECT * height;
    } else {
        width = ( mainViewWidth - 2 * (LayoutConstGUTTER + LayoutConstMARGIN) ) / 3;
        height = width / LayoutConstASPECT;
    }
    return CGSizeMake(width, height);
}

- (float) LayoutConstGUTTERTop{
    if ([self isHeightConstrained])
        return LayoutConstGUTTER;
    else
        return ( self.mainView.bounds.size.height - 3*[self elementSize].height - 2*LayoutConstMARGIN ) / 2;

}

- (float) LayoutConstGUTTERLeft{
    if ([self isWidthConstrained])
        return LayoutConstGUTTER;
    else
        return ( self.mainView.bounds.size.width - 3*[self elementSize].width - 2*LayoutConstMARGIN ) / 2;
}

- (BOOL) isWidthConstrained{
    return (self.mainView.bounds.size.width / self.mainView.bounds.size.height) < LayoutConstASPECT;
}

- (BOOL) isHeightConstrained{
    return ![self isWidthConstrained];
}

@end
