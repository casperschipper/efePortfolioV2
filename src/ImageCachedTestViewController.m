//
//  ImageCachedTestViewController.m
//  efePortfolio
//
//  Created by efe on 2/7/13.
//
//

//BLOCK IMAGE LOADER
#import "ImageCachedTestViewController.h"
#import "URLImageCached.h"

#define IMAGE_1_URL @"http://farm7.static.flickr.com/6159/6263221527_6f629d6df7_b.jpg"
#define IMAGE_2_URL @"http://farm4.static.flickr.com/3324/5709658575_185b3a341f_b.jpg"
#define IMAGE_3_URL @"http://farm7.static.flickr.com/6060/5904339697_9ea19a7ae1_z.jpg"

@interface ImageCachedTestViewController (PrivateMethods)
    -(URLImageLoadCompleteHandler)setImageBlock;
    -(URLImageLoadProgressHandler)setProgressBlock;
@end

@implementation ImageCachedTestViewController
@synthesize imageView, progressView;

#pragma mark - Memory Management
//MOVE THIS TO THE UNLOAD METHOD?
//////////////////////////////////////////////
-(void)dealloc {
    
    
    blockSelf_ = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    blockSelf_ = self;
    progressView.hidden = YES;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    imageView = nil;
    
    progressView = nil;
}

#pragma mark - Events
-(IBAction)loadImage1:(id)sender {
    curLoadingURL_ = IMAGE_1_URL;
    progressView.hidden = NO;
    progressView.progress = 0.0f;
    
    if([URLImageCached loadImageWithURL:IMAGE_1_URL withLoadProgressHandler:[self setProgressBlock]
                withLoadCompleteHandler:[self setImageBlock]]) {
        NSLog(@"Loading Image at %@", IMAGE_1_URL);
    } else {
        NSLog(@"No Internet!");
    }
}

-(IBAction)loadImage2:(id)sender {
    curLoadingURL_ = IMAGE_2_URL;
    progressView.hidden = NO;
    progressView.progress = 0.0f;
    
    if([URLImageCached loadImageWithURL:IMAGE_2_URL withLoadProgressHandler:[self setProgressBlock]
                withLoadCompleteHandler:[self setImageBlock]]) {
        NSLog(@"Loading Image at %@", IMAGE_2_URL);
    } else {
        NSLog(@"No Internet!");
    }
}

-(IBAction)loadImage3:(id)sender {
    curLoadingURL_ = IMAGE_3_URL;
    progressView.hidden = YES;
    
    if([URLImageCached loadImageWithURL:IMAGE_3_URL withLoadCompleteHandler:[self setImageBlock]]) {
        NSLog(@"Loading Image at %@", IMAGE_3_URL);
    } else {
        NSLog(@"No Internet!");
    }
}

-(IBAction)clearImageCache:(id)sender {
    [URLImageCached flushCache];
}

@end

@implementation ImageCachedTestViewController(Private)

-(URLImageLoadProgressHandler)setProgressBlock {
    return [^void(float progress, NSString *url) {
        if(blockSelf_ != nil && [url isEqualToString:curLoadingURL_]) {
            progressView.progress = progress;
        }
    } copy];
}


-(URLImageLoadCompleteHandler)setImageBlock {
    return [^void(UIImage *loadedImage, NSString *url) {
        if(blockSelf_ != nil && [url isEqualToString:curLoadingURL_]) {
            imageView.image = loadedImage;
            progressView.hidden = YES;
        }
    } copy];
}
@end
