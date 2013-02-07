//
//
//
//
//
//

#import <Foundation/Foundation.h>

@interface AbTabBarItem : NSObject {
    
}

@property(nonatomic, retain) UIImage *image;
@property(nonatomic, retain) UIImage *selectedImage;
@property(nonatomic, retain) UIViewController *viewController;

-(id) initWithImage:(UIImage*)image selectedImage:(UIImage*)selectedImage viewController:(UIViewController*)viewcontroller;

@end
