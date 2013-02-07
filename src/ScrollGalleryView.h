//
//  ScrollGalleryView.h
//  efePortfolio
//
//  Created by efe on 2/7/13.
//
//

#import <UIKit/UIKit.h>

@protocol PageControlDelegate;

@interface ScrollGalleryView : UIScrollView{
    
}

@property(nonatomic,assign)IBOutlet id<PageControlDelegate> pageControlDelegate;

@end


@protocol PageControlDelegate <NSObject>

-(void)ScrollGalleryView:(ScrollGalleryView*)ms scrolledToPage:(int)page;

@end
