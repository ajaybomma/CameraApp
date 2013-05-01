//
//  ViewController.h
//  CameraFunctionality
//
//  Created by PRANEETH PATLOLA on 4/15/13.
//  Copyright (c) 2013 PRANEETH PATLOLA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <Social/Social.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
     BOOL newMedia;
}

@property (strong, nonatomic) IBOutlet UIBarButtonItem *camButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *fbButton;
@property (strong, nonatomic) IBOutlet UIButton *twitterButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *albumButton;
@property (strong, nonatomic) IBOutlet UILabel *shareLabel;
@property (strong, nonatomic) UIImage *imageToSave;

- (IBAction) showCameraUI;
- (IBAction) showAlbum;
- (IBAction) fbButtonTapped:(id)sender;
- (IBAction) twitterTapped:(id)sender;
@end
