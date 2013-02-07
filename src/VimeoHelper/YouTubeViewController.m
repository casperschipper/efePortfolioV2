//
//  YouTubeViewController.m
//  efePortfolio
//
//  Created by efe on 2/6/13.
//
//

#import "YouTubeViewController.h"

@interface YouTubeViewController ()

@end

@implementation YouTubeViewController
@synthesize controller;

//- (void)dealloc {
//    self.controller.delegate = nil;
//}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    //extract the URL
    
    LBYouTubeExtractor *extractor = [[LBYouTubeExtractor alloc] initWithURL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=WVTzEq53-PI"] quality:LBYouTubeVideoQualityLarge];
    
    [extractor extractVideoURLWithCompletionBlock:^(NSURL *videoURL, NSError *error) {
        if(!error) {
            NSLog(@"Did extract video URL using completion block: %@", videoURL);
        } else {
            NSLog(@"Failed extracting video URL using block due to error:%@", error);
        }
    }];
    
    // Setup the player controller and add it's view as a subview:
    
    self.controller = [[LBYouTubePlayerController alloc] initWithYouTubeURL:[NSURL URLWithString:@"http://www.youtube.com/watch?v=1QebKMqdElg"] quality:LBYouTubeVideoQualityLarge];
    self.controller.delegate = self;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    CGFloat screenHeight = screenRect.size.height;
    CGFloat screenHeight = screenRect.size.width;
    CGFloat screenWidth = screenRect.size.height;
    self.controller.view.frame = CGRectMake(0.0f, 0.0f, screenWidth, screenHeight);
    //self.controller.view.center = self.view.center;
    [self.view addSubview:self.controller.view];
}

-(void)viewDidUnload{
    [super viewDidUnload];
    self.controller.delegate = nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

#pragma mark -
#pragma mark LBYouTubePlayerViewControllerDelegate

-(void)youTubePlayerViewController:(LBYouTubePlayerController *)controller didSuccessfullyExtractYouTubeURL:(NSURL *)videoURL {
    NSLog(@"Did extract video source:%@", videoURL);
}

-(void)youTubePlayerViewController:(LBYouTubePlayerController *)controller failedExtractingYouTubeURLWithError:(NSError *)error {
    NSLog(@"Failed loading video due to error:%@", error);
}

@end
