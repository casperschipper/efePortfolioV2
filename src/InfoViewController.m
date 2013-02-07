//
//  InfoViewController.m
//  efePortfolio
//
//  Created by efe on 2/6/13.
//
//

#import "InfoViewController.h"
#import "ReachabilityTestViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

-(id)init{
    self = [super init];
    if(self){
        
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnTextViewController:)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
    
    
    UITapGestureRecognizer *doubleTap =
    [[UITapGestureRecognizer alloc]
     initWithTarget:self
     action:@selector(tapDetected:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    
    testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 200)];
    testLabel.numberOfLines = 2;
    testLabel.text = @"put the info here";
    [self.view addSubview:testLabel];
}

#pragma mark -gesture methods
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    return YES;
//}
//
//- (IBAction)returnTextViewController:(UIGestureRecognizer *)sender{
//    ReachabilityTestViewController *rvc = [[ReachabilityTestViewController alloc] init];
//    rvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentModalViewController:rvc animated:YES];
//}
//
//- (IBAction)tapDetected:(UIGestureRecognizer *)sender {
//	ReachabilityTestViewController *rvc = [[ReachabilityTestViewController alloc] init];
//    rvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentModalViewController:rvc animated:YES];
//
//}

-(IBAction)returnToMainView:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
