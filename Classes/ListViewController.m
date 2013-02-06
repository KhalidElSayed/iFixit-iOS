//
//  ListViewController.m
//  iFixit
//
//  Created by David Patierno on 3/24/11.
//  Copyright 2011. All rights reserved.
//

#import "ListViewController.h"
#import "iFixitAppDelegate.h"
#import "BookmarksViewController.h"
#import "Config.h"

@implementation ListViewController

@synthesize allStack, bookmarksTVC;

- (id)initWithRootViewController:(UIViewController *)rvc {
    if ((self = [super initWithRootViewController:rvc])) {
        // Create the bookmarks view controller
        BookmarksViewController *bvc = [[BookmarksViewController alloc] initWithNibName:@"BookmarksView" bundle:nil];
        self.bookmarksTVC = bvc;
        [bvc release];
    }
    return self;
}

- (void)dealloc {
    [allStack release];
    [bookmarksTVC release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.tintColor = [Config currentConfig].toolbarColor;
    
    // Add the toolbar with bookmarks toggle.
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;

    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        int diff = 20 + 44;
        // Adjust for the tab bar.
        iFixitAppDelegate *appDelegate = (iFixitAppDelegate*)[UIApplication sharedApplication].delegate;
        if (appDelegate.showsTabBar)
            diff += 49;
        toolbar.frame = CGRectMake(0, screenSize.width - diff, 320, 44);
    }
    else {
        toolbar.frame = CGRectMake(0, screenSize.height - 43, screenSize.width, 44);
        toolbar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    NSArray *toggleItems = [NSArray arrayWithObjects:@"All", @"Favorites", nil];
    UISegmentedControl *toggle = [[UISegmentedControl alloc] initWithItems:toggleItems];
    toggle.selectedSegmentIndex = bookmarksTVC && self.topViewController == bookmarksTVC ? 1 : 0;
    toggle.segmentedControlStyle = UISegmentedControlStyleBar;
    [toggle addTarget:self action:@selector(toggleBookmarks:) forControlEvents:UIControlEventValueChanged];
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        toolbar.tintColor = [UIColor lightGrayColor];
        toggle.tintColor = [UIColor lightGrayColor];
    }
    else {
        toolbar.tintColor = [Config currentConfig].toolbarColor;
        toggle.tintColor = [[Config currentConfig].toolbarColor isEqual:[UIColor blackColor]] ? [UIColor darkGrayColor] : [Config currentConfig].toolbarColor;
    }
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                            target:nil
                                                                            action:nil];
    UIBarButtonItem *toggleItem = [[UIBarButtonItem alloc] initWithCustomView:toggle];
    NSArray *toolbarItems = [NSArray arrayWithObjects:spacer, toggleItem, spacer, nil];
    [toolbar setItems:toolbarItems];
    [spacer release];
    [toggleItem release];
    [toggle release];
    
    [self.view addSubview:toolbar];
    [toolbar release];
}

- (void)toggleBookmarks:(UISegmentedControl *)toggle { 
    // All
    if (toggle.selectedSegmentIndex == 0) {
        // Restore the saved stack.
        if ([allStack count] > 1) {
            self.viewControllers = allStack;
        }
        else {
            iFixitAppDelegate *appDelegate = (iFixitAppDelegate*)[[UIApplication sharedApplication] delegate];    
            self.viewControllers = [NSArray arrayWithObject:appDelegate.categoriesViewController];
        }
    }
    // Bookmarks
    else if (toggle.selectedSegmentIndex == 1) {
        // Save the full stack for later.
        self.allStack = self.viewControllers;

        // Show bookmarks.
        self.viewControllers = [NSArray arrayWithObject:bookmarksTVC];
    }
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
