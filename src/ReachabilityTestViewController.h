//
//  ReachabilityTestViewController.h
//  efePortfolio
//
//  Created by efe on 2/6/13.
//
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@class TextView;
@class IdleView;

@interface ReachabilityTestViewController : UIViewController<UIGestureRecognizerDelegate>{
    Reachability *reachability;
    
}

@property(nonatomic,strong)TextView *textView;
@property(nonatomic,strong)IdleView *idleView;
@property (nonatomic, readwrite) int textViewAlphaValue;
@property (nonatomic, retain) UIButton *flipButton;

-(BOOL)isConnected;
-(IBAction)flip:(id)sender;
-(IBAction)dissolve:(id)sender;

@end
