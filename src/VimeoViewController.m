//
//  YouTubeViewController.m
//  efePortfolio
//
//  Created by efe on 2/6/13.
//
//

#import "VimeoViewController.h"
#import "VimeoHelper.h"

@interface VimeoViewController (PrivateMethods)

@end

VimeoHelper *vimeoHelper;
MPMoviePlayerViewController *_moviePlayerController;

@implementation VimeoViewController

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
    vimeoHelper = [[VimeoHelper alloc] init];
}

- (void)finishedGetVimeoURL:(NSString *)url
{
    _moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:url]];
    [self presentViewController:_moviePlayerController animated:NO completion:nil];
}

- (void)playVideo
{
    //NSString * url = [self.txtUrl text];
    NSString *url = @"https://vimeo.com/5606758";
    [vimeoHelper getVimeoRedirectUrlWithUrl:url delegate:(id<VimeoDelegate>)self];
    if IOS_OLDER_THAN_6 {
        [self.view addSubview:vimeoHelper.webView];
        vimeoHelper.webView.frame =  CGRectMake(0,0,0,0);
    }
    
}

- (IBAction)playUrl:(id)sender {
    [self playVideo];
}


- (void)viewDidUnload {
    [self setTxtUrl:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
