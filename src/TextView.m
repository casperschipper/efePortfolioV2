//
//  TextView.m
//  efePortfolio
//
//  Created by efe on 2/6/13.
//
//

#import "TextView.h"

@implementation TextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        operationQueue = [[NSOperationQueue alloc] init];
        operationQueue.maxConcurrentOperationCount = 3;
        if([self isConnected]){
            [self loadImageFromServer];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationAlphaView:) name:@"alphaTextView" object:nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if([self isConnected]){
        [self loadImageFromServer];
    }
    
    touchCounter = 1;
    alphaValue = 0.0f;
    scaleValue = 1.5f;
    
    flipButton = [UIButton buttonWithType:UIButtonTypeInfoDark];
    flipButton.frame = CGRectMake(5, rect.size.height - 30, 40, 20);
    [flipButton setBackgroundColor:[UIColor whiteColor]];
    flipButton.alpha = alphaValue;
    //[flipButton
    flipButton.transform = CGAffineTransformMakeScale(scaleValue,scaleValue);
    //[flipButton setTitle:@"X" forState:UIControlStateNormal];
    [flipButton addTarget:self action:@selector(flipViewForInformation:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:flipButton];
    
}

#pragma -mark connection and fetching of the image
- (BOOL)isConnected{
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}


- (void)loadImageFromServer{
    [operationQueue addOperationWithBlock:^{
        NSString *urlAddress = @"http://www.recalculatingroute.info/";
        //NSString *urlAddress = @"www.recalculatingroute.info/";
        NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlAddress]];
        NSURLResponse *resp = nil;
        NSError *err = nil;
        NSData *response = [NSURLConnection sendSynchronousRequest: theRequest returningResponse: &resp error: &err];
        NSString *theResponseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        
        NSError *error = NULL;
        NSRegularExpression *regexImg = [NSRegularExpression regularExpressionWithPattern:@"<img src=\"(.*)\" >" options:NSRegularExpressionCaseInsensitive error:&error];
        NSArray *matches = [regexImg matchesInString:theResponseString
                                             options:0
                                               range:NSMakeRange(0, [theResponseString length])];
        NSRange offset;
        for (NSTextCheckingResult *match in matches) {
            //NSRange matchRange = [match range];
            //NSRange firstHalfRange = [match rangeAtIndex:1];
            offset = [match rangeAtIndex:1];
        }
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //load the image
            //NSString *imageURL = @"http://www.recalculatingroute.info/";
            NSString *imageURL = [NSString stringWithFormat:@"%@%@", urlAddress, [theResponseString substringWithRange:offset]];
            NSLog(@"%@",imageURL);
            NSURL *url = [NSURL URLWithString:imageURL];
            NSData *imageData = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:imageData];
            CGFloat imageWidth = 460.0f;CGFloat imageHeight = 320;
            
            //test image for view
            /*
             UIImageView *testImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gato.png"]];
             [self addSubview:testImage];
             */
            
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f,-10.0f,imageWidth, imageHeight)];
            [imageView setImage:image];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            //imageView.alpha = 1.0f;
            [self addSubview:imageView];
            
        }];
        
    }];
}

- (void)handleReachibilityChange:(NSNotification*)notification {
    if([self isConnected]){
        [self loadImageFromServer];
    }
}

- (void)connectToWebPage{
    [self loadImageFromServer];
}

@end
