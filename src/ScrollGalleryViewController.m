//
//  ScrollGalleryViewController.m
//  efePortfolio
//
//  Created by efe on 2/7/13.
//
//

#import "ScrollGalleryViewController.h"

@interface ScrollGalleryViewController (PrivateMethods)<PageControlDelegate>

@end

@implementation ScrollGalleryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //turn this into a property so we can load dynam the amount of pages
    self.pageControl.numberOfPages = 4;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    CGFloat screenWidth = screenRect.size.height;
    CGFloat screenHeight = screenRect.size.width;
    
    self.scrollView.frame = CGRectMake(0, 0, screenWidth ,  screenHeight);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ScrollGallery protocol
-(void)ScrollGalleryView:(ScrollGalleryView *)ms scrolledToPage:(int)page{
    self.pageControl.currentPage = page;
}

@end
