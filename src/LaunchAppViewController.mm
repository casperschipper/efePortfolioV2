//
//
//
//
//
//
//

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
#import "AsyncImageLoaderTestViewController.h"
#import "ActivityTestViewController.h"
#import "ScrollGalleryViewController.h"

#import "PrettyKit.h"
#import "ModalTemplateViewController.h"



@interface LaunchAppViewController (PrivateMethods) {}

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

-(IBAction)launchBlog:(id)sender{
    
}

-(IBAction)launchAbout:(id)sender{
    
}

-(IBAction)launchInfo:(id)sender{
    
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
    //CHECK THE PUSHING OF THE VIEW
    ImageCachedTestViewController *ivc = [[ImageCachedTestViewController alloc]init];
    [self.navigationController pushViewController:ivc animated:YES];
}

-(IBAction)launchAsyncImage:(id)sender{
    AsyncImageLoaderTestViewController *ivc = [[AsyncImageLoaderTestViewController alloc]init];
    [self.navigationController pushViewController:ivc animated:YES];
}

-(IBAction)launchActivityTest:(id)sender{
    ActivityTestViewController *avc = [[ActivityTestViewController alloc]init];
    [self.navigationController pushViewController:avc animated:YES];
}


-(IBAction)launchScrollGallery:(id)sender{
    ScrollGalleryViewController *svc = [[ScrollGalleryViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];
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



//////////////////////////////////////////////////
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
//	//Gradient background
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    //gradient.frame = self.view.bounds;
//    gradient.frame = CGRectMake(0,0,self.view.bounds.size.height, self.view.bounds.size.width);
//    //0x009999
//    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0xCCFFCC] CGColor], (id)[[UIColor colorWithHex:0x33CCCC] CGColor], nil];
//    [self.view.layer insertSublayer:gradient atIndex:0];
    
    //customize navigation bar et al
    PrettyNavigationBar *navBar = (PrettyNavigationBar *)self.navigationController.navigationBar;
    
    //Color Codes
    //http://www.nthelp.com/colorcodes.htm
    navBar.tintColor = navBar.gradientEndColor;
    navBar.roundedCornerRadius = 2;
    navBar.shadowOpacity = 0.2;
    
    self.navigationItem.title = @"Style Test";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                              target:self
                                              action:@selector(pkClick:)];
    
    
    //CHANGE STYLE OF THE BUTTONS
    //TrebuchetMS-Bold
    UIFont *segoeFont = [UIFont fontWithName:@"GillSans-Bold" size:20];

    UIButton *appButton = [UIButton buttonWithType:UIButtonTypeCustom];//UIButtonTypeCustom UIButtonTypeRoundedRect
    appButton.frame = CGRectMake(79,94,170,44);
    [appButton addTarget:self action:@selector(launchAppPressed:) forControlEvents:UIControlEventTouchUpInside];
    [appButton setTitle:@"TEST BUTTON" forState:UIControlStateNormal];
    [appButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [appButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    appButton.titleLabel.font = segoeFont;
    //appButton.titleLabel.textColor = [UIColor blackColor];
    [self.view addSubview:appButton];
    
    //fiorito button
    UIButton *fioritoButton =[UIButton buttonWithType:UIButtonTypeCustom];
    fioritoButton.frame = CGRectMake(79,153,170,44);
    [fioritoButton addTarget:self action:@selector(launchFioritoAttractor:) forControlEvents:UIControlEventTouchUpInside];
    [fioritoButton setTitle:@"FIORITO" forState:UIControlStateNormal];
    [fioritoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fioritoButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    fioritoButton.titleLabel.font = segoeFont;
    [self.view addSubview:fioritoButton];
    
    //cloudButton
    UIButton *cloudButton =[UIButton buttonWithType:UIButtonTypeCustom];
    cloudButton.frame = CGRectMake(79,213,170,44);
    [cloudButton addTarget:self action:@selector(launchCloudView:) forControlEvents:UIControlEventTouchUpInside];
    [cloudButton setTitle:@"BUBBLE" forState:UIControlStateNormal];
    [cloudButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cloudButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    cloudButton.titleLabel.font = segoeFont;
    [self.view addSubview:cloudButton];
    
    //boxButton
    UIButton *boxButton =[UIButton buttonWithType:UIButtonTypeCustom];
    boxButton.frame = CGRectMake(79,276,170,44);
    [boxButton addTarget:self action:@selector(launchBoxesApp:) forControlEvents:UIControlEventTouchUpInside];
    [boxButton setTitle:@"BOXES" forState:UIControlStateNormal];
    [boxButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [boxButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    boxButton.titleLabel.font = segoeFont;
    [self.view addSubview:boxButton];
    
    
    /////////////////////////////////
    //socketButton
    UIButton *socketButton =[UIButton buttonWithType:UIButtonTypeCustom];
    socketButton.frame = CGRectMake(288,96,170,44);
    [socketButton addTarget:self action:@selector(launchSocketTest:) forControlEvents:UIControlEventTouchUpInside];
    [socketButton setTitle:@"SOCKET ME" forState:UIControlStateNormal];
    [socketButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [socketButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    socketButton.titleLabel.font = segoeFont;
    [self.view addSubview:socketButton];
    
    
    //vimeoButton
    UIButton *vimeoButton =[UIButton buttonWithType:UIButtonTypeCustom];
    vimeoButton.frame = CGRectMake(288,161,170,44);
    [vimeoButton addTarget:self action:@selector(launchVimeoView:) forControlEvents:UIControlEventTouchUpInside];
    [vimeoButton setTitle:@"VIMEO ME" forState:UIControlStateNormal];
    [vimeoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [vimeoButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    vimeoButton.titleLabel.font = segoeFont;
    [self.view addSubview:vimeoButton];
    
    //jsonButton
    UIButton *jsonButton =[UIButton buttonWithType:UIButtonTypeCustom];
    jsonButton.frame = CGRectMake(288,217,170,44);
    [jsonButton addTarget:self action:@selector(launchYouTubeJSONView:) forControlEvents:UIControlEventTouchUpInside];
    [jsonButton setTitle:@"JSON ME" forState:UIControlStateNormal];
    [jsonButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [jsonButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    jsonButton.titleLabel.font = segoeFont;
    [self.view addSubview:jsonButton];
    
    //youtubeButton
    UIButton *youtubeButton =[UIButton buttonWithType:UIButtonTypeCustom];
    youtubeButton.frame = CGRectMake(288,278,170,44);
    [youtubeButton addTarget:self action:@selector(launchYouTubeView:) forControlEvents:UIControlEventTouchUpInside];
    [youtubeButton setTitle:@"YOUTUBE ME" forState:UIControlStateNormal];
    [youtubeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [youtubeButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    youtubeButton.titleLabel.font = segoeFont;
    [self.view addSubview:youtubeButton];
    
    //imageLoaderButton
    UIButton *imageLoaderButton =[UIButton buttonWithType:UIButtonTypeCustom];
    imageLoaderButton.frame = CGRectMake(288,338,170,44);
    [imageLoaderButton addTarget:self action:@selector(launchImageLoader:) forControlEvents:UIControlEventTouchUpInside];
    [imageLoaderButton setTitle:@"IMAGE ME" forState:UIControlStateNormal];
    [imageLoaderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [imageLoaderButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    imageLoaderButton.titleLabel.font = segoeFont;
    [self.view addSubview:imageLoaderButton];
    
    //asyncImageButton
    UIButton *asyncImageButton =[UIButton buttonWithType:UIButtonTypeCustom];
    asyncImageButton.frame = CGRectMake(288,399,170,44);
    [asyncImageButton addTarget:self action:@selector(launchAsyncImage:) forControlEvents:UIControlEventTouchUpInside];
    [asyncImageButton setTitle:@"ASYNC IMAGE" forState:UIControlStateNormal];
    [asyncImageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [asyncImageButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    asyncImageButton.titleLabel.font = segoeFont;
    [self.view addSubview:asyncImageButton];
    
    //activityButton
    UIButton *activityButton =[UIButton buttonWithType:UIButtonTypeCustom];
    activityButton.frame = CGRectMake(288,450,170,44);
    [activityButton addTarget:self action:@selector(launchActivityTest:) forControlEvents:UIControlEventTouchUpInside];
    [activityButton setTitle:@"ACTIVATE ME" forState:UIControlStateNormal];
    [activityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [activityButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    activityButton.titleLabel.font = segoeFont;
    [self.view addSubview:activityButton];
    
    
    /////////////////////////////////
    //portfolioButton
    UIButton *portfolioButton =[UIButton buttonWithType:UIButtonTypeCustom];
    portfolioButton.frame = CGRectMake(661,132,170,44);
    [portfolioButton addTarget:self action:@selector(launchPortifolio:) forControlEvents:UIControlEventTouchUpInside];
    [portfolioButton setTitle:@"PORTFOLIO" forState:UIControlStateNormal];
    [portfolioButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [portfolioButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    portfolioButton.titleLabel.font = segoeFont;
    [self.view addSubview:portfolioButton];
    
    //blogButton
    UIButton *blogButton =[UIButton buttonWithType:UIButtonTypeCustom];
    blogButton.frame = CGRectMake(661,191,170,44);
    [blogButton addTarget:self action:@selector(launchBlog:) forControlEvents:UIControlEventTouchUpInside];
    [blogButton setTitle:@"BLOG" forState:UIControlStateNormal];
    [blogButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [blogButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    blogButton.titleLabel.font = segoeFont;
    [self.view addSubview:blogButton];
    
    
    //aboutButton
    UIButton *aboutButton =[UIButton buttonWithType:UIButtonTypeCustom];
    aboutButton.frame = CGRectMake(661,255,170,44);
    [aboutButton addTarget:self action:@selector(launchAbout:) forControlEvents:UIControlEventTouchUpInside];
    [aboutButton setTitle:@"ABOUT" forState:UIControlStateNormal];
    [aboutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [aboutButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    aboutButton.titleLabel.font = segoeFont;
    [self.view addSubview:aboutButton];
    
    //infoButton
    UIButton *infoButton =[UIButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(661,320,170,44);
    [infoButton addTarget:self action:@selector(launchInfo:) forControlEvents:UIControlEventTouchUpInside];
    [infoButton setTitle:@"INFO" forState:UIControlStateNormal];
    [infoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [infoButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    infoButton.titleLabel.font = segoeFont;
    [self.view addSubview:infoButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - PrettyKit methods
-(void)pkClick:(id)sender
{
	ModalTemplateViewController *modalView = [[ModalTemplateViewController alloc] initWithNibName:@"ModalTemplateViewController" bundle:nil];
	[self presentModalViewController:modalView animated:YES];
}

@end
