#import "LaunchAppViewController.h"
#import "ExampleOFAppViewController.h"
#import "ExampleOFApp.h"
#import "FioritoViewController.h"
#import "FioritoAttractor.h"
#import "CloudViewController.h"
#import "CloudGesture.h"
#import "BoxesViewController.h"
#import "BoxesApp.h"

#import "PortifolioViewController.h"
#import "ReachabilityTestViewController.h"
#import "VimeoViewController.h"
#import "YouTubeJSONViewController.h"
#import "YouTubeViewController.h"
#import "ImageCachedTestViewController.h"
#import "ActivityTestViewController.h"

@interface LaunchAppViewController () {}

@end

@implementation LaunchAppViewController

#pragma mark - Buttons to access the GL scenes

- (IBAction)launchAppPressed:(id)sender {
    
    // Note we are not creating the ExampleOFAppViewController via storyboards
    // as is requires a custom initilaiser
    
    // create the app
    ExampleOFApp *exampleOFApp = new ExampleOFApp(); // For the curious, exampleOFApp will be deleted laters

    // create the frame for the app. In this example we create it to
    // be the the same size as the screen and respect this views
    // orientation
    CGRect mainScreenFrame = [[UIScreen mainScreen] bounds];
    CGRect frame = mainScreenFrame;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        frame.size.width = mainScreenFrame.size.height;
        frame.size.height = mainScreenFrame.size.width;
    }
    
    //push viewcontroller
    ExampleOFAppViewController *exampleOFAppViewController = [[ExampleOFAppViewController alloc] initWithFrame:frame app:exampleOFApp];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.8;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    //[[self navigationController] popViewControllerAnimated:NO];
    [self.navigationController pushViewController:exampleOFAppViewController animated:YES];
}

-(void)launchFioritoAttractor:(id)sender{
    FioritoAttractor *fioritoApp = new FioritoAttractor();
    
    CGRect mainScreenFrame = [[UIScreen mainScreen]bounds];
    CGRect frame = mainScreenFrame;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        frame.size.width = mainScreenFrame.size.height;
        frame.size.height = mainScreenFrame.size.width;
    }
    
    FioritoViewController *fvc = [[FioritoViewController alloc]initWithFrame:frame app:fioritoApp];
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.8;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionFade;
//    transition.subtype = kCATransitionFromTop;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:fvc animated:YES];
}


-(IBAction)launchPortifolio:(id)sender
{
    PortifolioViewController *portifolioVC = [[PortifolioViewController alloc]init];
    [self.navigationController pushViewController:portifolioVC animated:YES];
}

-(IBAction)launchSocketTest:(id)sender{
    ReachabilityTestViewController *rtvc = [[ReachabilityTestViewController alloc]init];
    [self.navigationController pushViewController:rtvc animated:YES];
}

-(IBAction)launchVimeoView:(id)sender{
    VimeoViewController *vvc = [[VimeoViewController alloc]init];
    [self.navigationController pushViewController:vvc animated:YES];
}

-(IBAction)launchYouTubeJSONView:(id)sender{
    //here we need to decide the URL for the youTube/vimeo source
    NSURL *url = [NSURL URLWithString:@"http://gdata.youtube.com/feeds/api/videos?alt=json&author=AKB48"];
    //USE a dictionary to load the videos
    /*
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *res, NSData *data, NSError *error) {
                               NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                                   options:0
                                                                                     error:nil];
                               list = [[dic objectForKey:@"feed"] objectForKey:@"entry"];
                               [self.tableView reloadData];
                           }];
     */

    //CHECK HERE THE URL as it is loaded from a server
    NSString *videoId = @"http://www.youtube.com/watch?v=1QebKMqdElg";
    YouTubeJSONViewController *ytvc = [[YouTubeJSONViewController alloc]initWithVideoId:videoId];
    [self.navigationController pushViewController:ytvc animated:YES];
}

-(IBAction)launchYouTubeView:(id)sender{
    YouTubeViewController *ytvc = [[YouTubeViewController alloc]init];
    [self.navigationController pushViewController:ytvc animated:YES];
}

-(IBAction)launchImageLoader:(id)sender{
    ImageCachedTestViewController *ivc = [[ImageCachedTestViewController alloc]init];
    [self.navigationController pushViewController:ivc animated:YES];
}

-(IBAction)launchActivityTest:(id)sender{
    ActivityTestViewController *avc = [[ActivityTestViewController alloc]init];
    [self.navigationController pushViewController:avc animated:YES];
}

//////////////////////////////////////////////////
#pragma mark - Actions to call OFW sketches

-(void)launchCloudView:(id)sender{
    CloudGesture *cloudApp = new CloudGesture();
    
    CGRect mainScreenFrame = [[UIScreen mainScreen]bounds];
    CGRect frame = mainScreenFrame;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        frame.size.width = mainScreenFrame.size.height;
        frame.size.height = mainScreenFrame.size.width;
    }
    
    //create the app
    CloudViewController *cvc = [[CloudViewController alloc]initWithFrame:frame app:cloudApp];
    //add it
    [self.navigationController pushViewController:cvc animated:YES];
}

-(void)launchBoxesApp:(id)sender{
    BoxesApp *boxApp = new BoxesApp();
    
    CGRect mainScreenFrame = [[UIScreen mainScreen]bounds];
    CGRect frame = mainScreenFrame;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        frame.size.width = mainScreenFrame.size.height;
        frame.size.height = mainScreenFrame.size.width;
    }
    
    //create the app
    BoxesViewController *cvc = [[BoxesViewController alloc]initWithFrame:frame app:boxApp];
    //add it
    [self.navigationController pushViewController:cvc animated:YES];

}

#pragma mark - Life Cycle

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
