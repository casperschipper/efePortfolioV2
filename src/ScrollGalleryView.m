//
//  ScrollGalleryView.m
//  efePortfolio
//
//  Created by efe on 2/7/13.
//
//

#import "ScrollGalleryView.h"


@interface ScrollGalleryView()

@property(nonatomic, strong) NSArray *images;

@end

@implementation ScrollGalleryView
//#define width 320


//THERE IS AN ISSUE WITH THE OFFSETS!!!!!!!!!!!!!!!!!!!



-(NSArray*)images{
    if(_images) return _images;
    _images = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"2.png"], [UIImage imageNamed:@"3.png"], [UIImage imageNamed:@"4.png"],[UIImage imageNamed:@"5.png"], nil];
    return _images;
}

-(id)init{
    self = [super init];
    if(self){
        
    }
    
    return self;
}

//OLD CODE for IPHONE
/*
 -(id)initWithCoder:(NSCoder *)aDecoder{
 float currentPosition = 0;
 if(self = [super initWithCoder:aDecoder]){
 self.pagingEnabled = YES;
 for(int i=0; i< self.images.count + 2; i++){
 CGRect rect = CGRectMake(currentPosition, 0, width, self.bounds.size.height);
 UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
 if(i == 0)
 imageView.image = self.images[self.images.count - 1];
 else if(i == self.images.count + 1)
 imageView.image = self.images[0];
 else
 imageView.image = self.images[i - 1];
 currentPosition += 320;
 imageView.contentMode = UIViewContentModeScaleToFill;
 self.showsHorizontalScrollIndicator = NO;
 self.showsVerticalScrollIndicator = NO;
 [self addSubview:imageView];
 }
 }
 self.contentOffset = CGPointMake(320, 0);
 self.contentSize = CGSizeMake(currentPosition, self.bounds.size.height);
 return self;
 }
 */

-(id)initWithCoder:(NSCoder *)aDecoder{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    CGFloat screenWidth = screenRect.size.height;
    CGFloat screenHeight = screenRect.size.width;
    
    float currentPosition = 0;
    if(self = [super initWithCoder:aDecoder]){
        self.pagingEnabled = YES;
        for(int i=0; i< self.images.count + 2; i++){
            CGRect rect = CGRectMake(currentPosition, 0, screenWidth, screenHeight);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
            if(i == 0)
                imageView.image = self.images[self.images.count - 1];
            else if(i == self.images.count + 1)
                imageView.image = self.images[0];
            else
                imageView.image = self.images[i - 1];
            currentPosition += screenWidth;
            imageView.contentMode = UIViewContentModeScaleToFill;
            self.showsHorizontalScrollIndicator = NO;
            self.showsVerticalScrollIndicator = NO;
            [self addSubview:imageView];
        }
    }
    self.contentOffset = CGPointMake(screenWidth, 0);//320
    self.contentSize = CGSizeMake(currentPosition, self.bounds.size.height);
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)layoutSubviews{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    if(self.contentOffset.x == 0){
        self.contentOffset = CGPointMake(self.images.count * screenWidth, 0);
    }
    if(self.contentOffset.x == (self.images.count +1) * screenWidth){
        self.contentOffset = CGPointMake(0, 0);
    }
    [self.pageControlDelegate ScrollGalleryView:self scrolledToPage:abs(self.contentOffset.x / screenHeight) -1];//320
}

@end
