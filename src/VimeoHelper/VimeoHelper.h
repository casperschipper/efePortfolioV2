#import <Foundation/Foundation.h>

@protocol VimeoDelegate

- (void)finishedGetVimeoURL:(NSString *)url;
@end


@interface VimeoHelper : NSObject {
    UIWebView *_webView;
    UIWebView *_webViewPlay;
    id<VimeoDelegate> _delegate;
    NSString *_originUrl;
}

@property (nonatomic, retain) UIWebView *webView;
- (void)getVimeoRedirectUrlWithUrl:(NSString *)url delegate:(id<VimeoDelegate>)delegate;
@end