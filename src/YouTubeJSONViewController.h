//
//  YouTubeViewController.h
//  efePortfolio
//
//  Created by efe on 2/6/13.
//
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface YouTubeJSONViewController : MPMoviePlayerViewController{
    
}

-(id)initWithVideoId:(NSString *)videoId;

-(NSString *)videoId;

@end
