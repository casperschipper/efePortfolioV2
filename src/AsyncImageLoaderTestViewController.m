//
//  AsyncImageLoaderTestViewController.m
//  efePortfolio
//
//  Created by efe on 2/7/13.
//
//

#import "AsyncImageLoaderTestViewController.h"
#import "AsyncImageView.h"
#import "PhotoDetailViewController.h"

@interface AsyncImageLoaderTestViewController (PrivateMethods)

@end

@implementation AsyncImageLoaderTestViewController

@synthesize imageURLs;

-(id)init{
    self = [super init];
    if(self){
        
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"LoadImages" ofType:@"plist"];
    NSArray *imagePaths = [NSArray arrayWithContentsOfFile:plistPath];
    
    //remote image URLs
    NSMutableArray *URLs = [NSMutableArray array];
    for (NSString *path in imagePaths)
    {
        NSURL *URL = [NSURL URLWithString:path];
        if (URL)
        {
            [URLs addObject:URL];
        }
        else
        {
            NSLog(@"'%@' is not a valid URL", path);
        }
    }
    self.imageURLs = URLs;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    //unload view to demonstrate caching
    self.view = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [imageURLs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
#define TAG 99
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 44.0f, 44.0f)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.tag = TAG;
        [cell addSubview:imageView];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.indentationWidth = 44.0f;
        cell.indentationLevel = 1;
    }
    
    AsyncImageView *imageView = (AsyncImageView *)[cell viewWithTag:TAG];
    //cancel loading previous image for cell
    [[AsyncImageLoader sharedLoader]cancelLoadingImagesForTarget:imageView];
    imageView.imageURL = imageURLs[indexPath.row];
    
    cell.textLabel.text = [[imageURLs[indexPath.row] path] lastPathComponent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    PhotoDetailViewController *viewController = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:nil];
    [viewController view]; 
    viewController.imageView.imageURL = imageURLs[indexPath.row];
    viewController.title = [[imageURLs[indexPath.row] path] lastPathComponent];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
