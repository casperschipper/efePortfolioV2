//
//  ImageCachedTestViewController.h
//  efePortfolio
//
//  Created by efe on 2/7/13.
//
//

#import <UIKit/UIKit.h>

@interface ImageCachedTestViewController : UIViewController{
    
    NSString *curLoadingURL_;
    __block id blockSelf_;
}

@property(nonatomic, strong) __block IBOutlet UIImageView *imageView;
@property(nonatomic, strong) __block IBOutlet UIProgressView *progressView;

-(IBAction)loadImage1:(id)sender;
-(IBAction)loadImage2:(id)sender;
-(IBAction)loadImage3:(id)sender;
-(IBAction)clearImageCache:(id)sender;

@end
