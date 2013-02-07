//
//  YouTubeViewController.m
//  efePortfolio
//
//  Created by efe on 2/6/13.
//
//

#import "YouTubeJSONViewController.h"
#import "FMYouTubeVideoSourceDetector.h"

@interface YouTubeJSONViewController ()<UIWebViewDelegate>
@end

@implementation YouTubeJSONViewController{
    NSString *_videoId;
    NSURL *_sourceURL;
    FMYouTubeVideoSourceDetector *detector;
}

-(id)init{
    self = [super init];
    if(self){
        
    }
    
    return self;
}

-(id)initWithVideoId:(NSString *)videoId
{
    self = [super init];
    if (self) {
        _videoId = videoId;
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
    // Do any additional setup after loading the view from its nib.
    
    //setup the source URL
    [self startDetectVideoSourceURL];
}

#pragma mark - Video Sources

-(NSString *)videoId
{
    return _videoId;
}

-(void)startDetectVideoSourceURL;
{
    detector = [[FMYouTubeVideoSourceDetector alloc] init];
    __weak YouTubeJSONViewController *_self = self;
    [detector detectSourceURLofVideoId:self.videoId
                            completion:^(NSURL *sourceURL, NSError *error) {
                                if (error) {
                                    [_self.presentingViewController dismissMoviePlayerViewControllerAnimated];
                                    return;
                                }
                                _self.moviePlayer.contentURL = sourceURL;
                            }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
