//
//  DetailViewController.h
//  iFixit
//
//  Created by David Patierno on 8/6/10.
//  Copyright iFixit 2010. All rights reserved.
//

#import "GuideViewController.h"
#import "DetailGridViewControllerDelegate.h"

@class GuideCatchingWebView;
@class WBProgressHUD;
@class DetailIntroViewController;
@class DetailGridViewController;
@class ListViewController;

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, UIWebViewDelegate, UIAlertViewDelegate, DetailGridViewControllerDelegate>

@property (nonatomic, retain) UIBarButtonItem *browseButton;
@property (nonatomic, retain) UIPopoverController *popoverController;

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet GuideCatchingWebView *wikiWebView;
@property (nonatomic, retain) IBOutlet GuideCatchingWebView *answersWebView;
@property (nonatomic, retain) NSURL *lastURL;

@property (nonatomic, retain) DetailGridViewController *gridViewController;
@property (nonatomic, retain) NSMutableArray *deviceToolbarItems;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) DetailIntroViewController *introViewController;
@property (nonatomic, retain) ListViewController *listViewController;

- (void)setDevice:(NSString *)device;
- (void)reset;
- (void)updateSegmentedControlSelection;
    
@end
