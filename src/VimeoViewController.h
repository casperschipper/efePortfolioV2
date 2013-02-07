//
//  YouTubeViewController.h
//  efePortfolio
//
//  Created by efe on 2/6/13.
//
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

#define IOS_OLDER_THAN_6 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] < 6.0 )
#define IOS_NEWER_OR_EQUAL_TO_6 ( [ [ [ UIDevice currentDevice ] systemVersion ] floatValue ] >= 6.0 )

@class VimeoHelper;

@interface VimeoViewController : UIViewController{
    VimeoHelper *vimeoHelper;
    MPMoviePlayerViewController *_moviePlayerController;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UITextField *txtUrl;//use this one to manually add URLs

@end
