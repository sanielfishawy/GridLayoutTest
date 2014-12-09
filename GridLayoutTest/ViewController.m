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
@property (nonatomic) UIView *contentView;
@property (nonatomic) UIView *headerView;
@end

@implementation ViewController

static const float LayoutConstGUTTER = 10;
static const float LayoutConstMARGIN = 5;
static const float LayoutConstASPECT = 0.75;
static const float LayoutConstHEADER_HEIGHT = 55;
static const float LayoutConstLOGO_HEIGHT = LayoutConstHEADER_HEIGHT * 0.4;
static const float LayoutConstBENCH_ICON_HEIGHT = LayoutConstHEADER_HEIGHT *0.4;

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
    for (UIView *v in self.contentView.subviews){
        [v removeFromSuperview];
    }
}

- (void)addViews {
    [self removeViews];
    [self addHeaderView];
    [self addContentView];
    [self addGridViews];
}

//-----------
// HeaderView
//-----------

- (void)addHeaderView{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, LayoutConstHEADER_HEIGHT)];
    self.headerView.backgroundColor = [UIColor colorWithHexString:@"1B1B19" alpha:1];
    [self.headerView addSubview:[self logoView]];
    [self.headerView addSubview:[self drawerIconView]];
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

- (UIImageView *)drawerIconView{
    UIImage *i = [UIImage imageNamed:@"drawerIcon"];
    float aspect = i.size.width / i.size.height;
    UIImageView *iv = [[UIImageView alloc] initWithImage:i];
    float w = aspect * LayoutConstBENCH_ICON_HEIGHT;
    float x = self.view.bounds.size.width - LayoutConstGUTTER - w;
    float y = (LayoutConstHEADER_HEIGHT - LayoutConstBENCH_ICON_HEIGHT) / 2;
    iv.frame = CGRectMake(x, y, w, LayoutConstBENCH_ICON_HEIGHT);
    return iv;
}

//------------
// ContentView
//------------
- (void)addContentView{
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, LayoutConstHEADER_HEIGHT, self.view.bounds.size.width, self.view.bounds.size.height - LayoutConstHEADER_HEIGHT)];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"2E2D28" alpha:1];
    [self.view addSubview:self.contentView];
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
            [self.contentView addSubview:v];
            
            UIViewController *c = [TBMGridElementViewController new];
            [self addChildViewController:c];
            c.view.frame = CGRectMake(0, 0, elSize.width, elSize.height);
            [v addSubview:c.view];
        }
    }
}

- (CGSize) elementSize {
    long mainViewWidth = self.contentView.bounds.size.width;
    long mainViewHeight = self.contentView.bounds.size.height;
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
        return ( self.contentView.bounds.size.height - 3*[self elementSize].height - 2*LayoutConstMARGIN ) / 2;

}

- (float) LayoutConstGUTTERLeft{
    if ([self isWidthConstrained])
        return LayoutConstGUTTER;
    else
        return ( self.contentView.bounds.size.width - 3*[self elementSize].width - 2*LayoutConstMARGIN ) / 2;
}

- (BOOL) isWidthConstrained{
    return (self.contentView.bounds.size.width / self.contentView.bounds.size.height) < LayoutConstASPECT;
}

- (BOOL) isHeightConstrained{
    return ![self isWidthConstrained];
}

@end
