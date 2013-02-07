//
//  ReachabilityTestViewController.m
//  efePortfolio
//
//  Created by efe on 2/6/13.
//
//

#import "ReachabilityTestViewController.h"
#import "TextView.h"
#import "IdleView.h"
#import "InfoViewController.h"

@interface ReachabilityTestViewController (PrivateMethods)

@end

@implementation ReachabilityTestViewController

@synthesize textView;
@synthesize idleView;
@synthesize textViewAlphaValue;
@synthesize flipButton;

//CHECK which init method is called
- (id)init{
    self = [super init];
    if(self){
        reachability = [Reachability reachabilityForInternetConnection];
        [reachability startNotifier];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleReachibilityChange:) name:kReachabilityChangedNotification object:reachability];
        
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
        
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        reachability = [Reachability reachabilityForInternetConnection];
        [reachability startNotifier];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleReachibilityChange:) name:kReachabilityChangedNotification object:reachability];
        
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleButtonAppearance:)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
    
    //load views
    CGRect frame = self.view.bounds;
    textView = [[TextView alloc] initWithFrame:frame];
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //[textView isConnected:self.isConnected];
    idleView = [[IdleView alloc] initWithFrame:frame];
    idleView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:textView];
    [self.view addSubview:idleView];
    
    
    
    //check for internet connection
    if([self isConnected]){
        idleView.hidden = YES;
        [textView connectToWebPage];
        textView.hidden = NO;
    }
    else{
        idleView.hidden = NO;
        textView.hidden = YES;
    }
    
    
    flipButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [flipButton addTarget:self
                   action:@selector(flip:)
         forControlEvents:UIControlEventTouchUpInside];
    //[flipButton setFrame:CGRectMake(5, rect.size.height - 30, 40, 20)];
    //[flipButton setFrame:CGRectMake(12, 285, 20, 20)];
    [flipButton setBackgroundColor:[UIColor whiteColor]];
    flipButton.contentMode = YES;
    flipButton.alpha = 0.0f;
    //flipButton.transform = CGAffineTransformMakeScale(2, 2);
    [self.view addSubview:flipButton];
    
    
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return flipButton.highlighted == NO;
}

- (void)toggleButtonAppearance:(UITapGestureRecognizer*)gesture{
    switch (gesture.state) {
        case UIGestureRecognizerStateRecognized:
            [UIView animateWithDuration:1.5 delay:0 options:  UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                flipButton.alpha = (flipButton.alpha == 0.0 ? 1.0 : 0.0);
                //flipButton.transform = (flipButton.alpha == 0.0 ? CGAffineTransformMakeScale(2, 2) : CGAffineTransformIdentity);
                if(flipButton.alpha == 0.0){
                    flipButton.transform = CGAffineTransformMakeScale(2, 2);
                }
                else {
                    flipButton.transform  = CGAffineTransformIdentity;
                }
            } completion:^(BOOL finished) {
            }
             ];
            break;
            
//        default:
//            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -methods for fliping

- (IBAction)flip:(UIButton*)sender{
    InfoViewController *infoViewController = [[InfoViewController alloc] init];
    infoViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:infoViewController animated:YES];
}

- (IBAction)dissolve:(UIButton*)sender{
    InfoViewController *infoViewController = [[InfoViewController alloc] init];
    infoViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:infoViewController animated:YES];
}

#pragma mark check connection
//view load and checks for the first time the
- (BOOL)isConnected{
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}



- (void)handleReachibilityChange:(NSNotification*)notification {
    //notify when connection state changes
    if([self isConnected]){
        
        [textView connectToWebPage];
        //idleView.hidden = YES; textView.hidden = NO;
        
        UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve;
        
        [UIView transitionWithView:self.view
                          duration:1.5
                           options:options
                        animations:^{ idleView.hidden = YES; textView.hidden = NO; }
                        completion:NULL];
        
    }
    else {
        //idleView.hidden = NO; textView.hidden = YES;
        
        UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionTransitionCrossDissolve;
        
        [UIView transitionWithView:self.view
                          duration:1.5
                           options:options
                        animations:^{ idleView.hidden = NO; textView.hidden = YES; }
                        completion:NULL];
    }
}

@end
