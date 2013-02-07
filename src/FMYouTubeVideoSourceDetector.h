


#import <Foundation/Foundation.h>

typedef void(^FMYouTubeViewSourceDetectorCompletionBlock)(NSURL *sourceURL, NSError *error);

@interface FMYouTubeVideoSourceDetector : NSObject

-(void)detectSourceURLofVideoId:(NSString *)videoId completion:(FMYouTubeViewSourceDetectorCompletionBlock)completion;

@end
