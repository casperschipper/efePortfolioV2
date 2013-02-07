//
//  TextView.h
//  efePortfolio
//
//  Created by efe on 2/6/13.
//
//

#import <UIKit/UIKit.h>
#import "ReachabilityTestViewController.h"
#import "Reachability.h"

@protocol UIButtonWithTapDelegate

@optional
- (void)buttonDidLongTap:(NSNumber *)tag;

@end

@interface TextView : UIView{
    
    UIImageView *imageView;
    NSOperationQueue *operationQueue;
    
    Reachability *reachability;
    
    //BOOL isConnected;
    UIButton *flipButton;
    int touchCounter;
    float alphaValue;
    float scaleValue;
    
}

- (void)loadImageFromServer;
- (BOOL)isConnected;
- (void)connectToWebPage;

@end
