//
//  YouTubeViewController.h
//  efePortfolio
//
//  Created by efe on 2/6/13.
//
//
//YouTubeViewController

#import <UIKit/UIKit.h>
#import "LBYouTube.h"

@interface YouTubeViewController : UIViewController <LBYouTubePlayerControllerDelegate> {
    LBYouTubePlayerController* controller;
}

@property (nonatomic, strong) LBYouTubePlayerController* controller;

@end

