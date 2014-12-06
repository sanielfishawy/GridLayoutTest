//
//  TBMGridElementViewController.m
//  GridLayoutTest
//
//  Created by Sani Elfishawy on 12/5/14.
//  Copyright (c) 2014 No Plan B. All rights reserved.
//

#import "TBMGridElementViewController.h"
#import "HexColor.h"

@interface TBMGridElementViewController()
@property UIImageView *plusImgView;
@end

@implementation TBMGridElementViewController

- (void)viewWillAppear:(BOOL)animated{
    [self buildView];
}

- (void)buildView{
    self.view.backgroundColor = [UIColor colorWithHexString:@"F48A31" alpha:1];
    [self addPlus];
}

- (void)addPlus{
    UIImage *plusImg = [UIImage imageNamed:@"plus"];
    self.plusImgView = [[UIImageView alloc] initWithImage:plusImg];
    float w = self.view.frame.size.width / 2;
    float x = (self.view.frame.size.width - w) / 2;
    float y = (self.view.frame.size.height -w) / 2;
    self.plusImgView.frame = CGRectMake(x, y, w, w);
    [self.view addSubview:self.plusImgView];
}



@end
