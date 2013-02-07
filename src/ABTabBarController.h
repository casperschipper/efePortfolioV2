//
//
//
//
//
//

#import <UIKit/UIKit.h>
#import "ABTabBar.h"
#import "AbTabBarItem.h"

#define ACTIVE_ABTABBAR_VIEW 2222

@interface ABTabBarController : UIViewController <ABTabBarDelegate> {
    ABTabBar *tabBar;
}

@property (nonatomic, retain) NSMutableArray *tabBarItems;
@property (nonatomic) float tabBarHeight;
@property (nonatomic, retain) UIImage *backgroundImage;

@end
