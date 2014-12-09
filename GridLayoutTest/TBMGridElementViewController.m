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
@property UILabel *nameLabel;
@property NSArray *greenBorder;
@property UILabel *countLabel;
@property UIImageView *thumbView;
@property UIView *uploadingIndicator;
@property UIView *downloadingIndicator;
@property UIView *viewedIndicator;
@end

@implementation TBMGridElementViewController

static const float LayoutConstNameLabelHeight = 22;
static const float LayoutConstNameLabelFontSize = 0.65 * LayoutConstNameLabelHeight;
static const float LayoutConstBorderWidth = 3;
static const float LayoutConstCountWidth = 22;
static const float LayoutConstUnviewedCountFontSize = 0.5 * LayoutConstCountWidth;
static const float LayoutConstIndicatorBoxHeight = LayoutConstNameLabelHeight;
static const float LayoutConstIndicatorHeight = LayoutConstIndicatorBoxHeight * 0.5;

static NSString *LayoutConstOrangeColor = @"F48A31";
static NSString *LayoutConstGreenColor = @"9BC046";
static NSString *LayoutConstWhiteTextColor  = @"ccc";
static NSString *LayoutConstLabelGreyColor = @"4E4D42";
static NSString *LayoutConstRedColor = @"D90D19";

- (void)viewWillAppear:(BOOL)animated{
    [self buildView];
}


//------------------
// Building the view
//------------------
- (void)buildView{
    self.view.backgroundColor = [UIColor colorWithHexString:LayoutConstOrangeColor alpha:1];
    [self addPlus];
    [self addThumb];
    [self addNameLabel];
    [self addGreenBorder];
    [self addCountLabel];
    [self showGreenBorder];
    [self addUploadingIndicator];
    [self addDownloadingIndicator];
    [self addViewedIndicator];
}

- (void)addPlus{
    UIImage *plusImg = [UIImage imageNamed:@"plus"];
    self.plusImgView = [[UIImageView alloc] initWithImage:plusImg];
    float w = self.view.frame.size.width / 2;
    w = fminf(w, plusImg.size.width);
    float x = (self.view.frame.size.width - w) / 2;
    float y = (self.view.frame.size.height -w) / 2;
    self.plusImgView.frame = CGRectMake(x, y, w, w);
    [self.view addSubview:self.plusImgView];
}

- (void)addNameLabel{
    float y = self.view.bounds.size.height - LayoutConstNameLabelHeight;
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, self.view.bounds.size.width, LayoutConstNameLabelHeight)];
    self.nameLabel.backgroundColor = [UIColor colorWithHexString:LayoutConstLabelGreyColor alpha:1];
    self.nameLabel.textColor = [UIColor colorWithHexString:LayoutConstWhiteTextColor alpha:1];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:LayoutConstNameLabelFontSize];
    self.nameLabel.text = @"Stephanie";
    [self.view addSubview:self.nameLabel];
}


// Green Border
- (void)addGreenBorder{
    UIView *l = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LayoutConstBorderWidth, self.view.bounds.size.height)];
    UIView *t = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, LayoutConstBorderWidth)];
    UIView *r = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - LayoutConstBorderWidth, 0, LayoutConstBorderWidth, self.view.bounds.size.height)];
    self.greenBorder = [[NSArray alloc] initWithObjects:l,t,r, nil];
    for (UIView *b in self.greenBorder){
        b.backgroundColor = [UIColor colorWithHexString:LayoutConstGreenColor alpha:1];
        [self.view addSubview:b];
    }
}

// Unviewed count
- (void)addCountLabel{
    float x = self.view.bounds.size.width - LayoutConstCountWidth + 3;
    float y = -3;
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, LayoutConstCountWidth, LayoutConstCountWidth)];
    self.countLabel.backgroundColor = [UIColor colorWithHexString:LayoutConstRedColor alpha:1];
    self.countLabel.font = [UIFont systemFontOfSize:LayoutConstUnviewedCountFontSize];
    self.countLabel.textColor = [UIColor whiteColor];
    self.countLabel.layer.cornerRadius = LayoutConstNameLabelHeight / 2;
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.text = @"1";
    [self.view addSubview:self.countLabel];
}

// Thumb
- (void)addThumb{
    self.thumbView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thumb"]];
    self.thumbView.frame = self.view.frame;
    [self.view addSubview:self.thumbView];
}

// Uploading, downloading and viewed indicators
- (void)addUploadingIndicator{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uploadingIcon"]];
    self.uploadingIndicator = [self createIndicatorWithImage:iv];
    [self.view addSubview:self.uploadingIndicator];
}

- (void)addDownloadingIndicator{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"downloadingIcon"]];
    self.downloadingIndicator = [self createIndicatorWithImage:iv];
    [self.view addSubview:self.downloadingIndicator];
}

- (void)addViewedIndicator{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"viewedIcon"]];
    self.viewedIndicator = [self createIndicatorWithImage:iv];
    [self.view addSubview:self.viewedIndicator];
}

- (UIView *)createIndicatorWithImage:(UIImageView *)iv{
    float aspect = iv.frame.size.width / iv.frame.size.height;
    CGSize ivSize = CGSizeMake(LayoutConstIndicatorHeight / aspect, LayoutConstIndicatorHeight);
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LayoutConstIndicatorBoxHeight, LayoutConstIndicatorBoxHeight)];
    v.backgroundColor = [UIColor colorWithHexString:LayoutConstGreenColor];
    float x = (v.frame.size.width - ivSize.width) / 2;
    float y = (v.frame.size.height - ivSize.height) / 2;
    iv.frame = CGRectMake(x, y, ivSize.width, ivSize.height);
    [v addSubview:iv];
    return v;
}

//-------------
// View actions
//-------------
- (void)showGreenBorder{
    for (UIView *b in self.greenBorder){
        b.hidden = NO;
        self.nameLabel.backgroundColor = [UIColor colorWithHexString:LayoutConstGreenColor];
        self.nameLabel.textColor = [UIColor whiteColor];
    }
}

- (void)hideGreenBorder{
    for (UIView *b in self.greenBorder){
        b.hidden = YES;
        self.nameLabel.backgroundColor = [UIColor colorWithHexString:LayoutConstLabelGreyColor];
        self.nameLabel.textColor = [UIColor colorWithHexString:LayoutConstWhiteTextColor];
    }
}

- (void)showThumb{
    
}

- (void)hideThumb{
    
}

@end
