//
//  ViewController.m
//  CameraFunctionality
//
//  Created by PRANEETH PATLOLA on 4/15/13.
//  Copyright (c) 2013 PRANEETH PATLOLA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageView,fbButton,twitterButton,imageToSave,shareLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    fbButton.hidden = YES;
    twitterButton.hidden = YES;
    shareLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) showCameraUI
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        cameraUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        cameraUI.allowsEditing = NO;
        cameraUI.delegate = self;
        [self presentViewController:cameraUI animated:YES completion:nil];
        newMedia = YES;
    }
}

- (IBAction)showAlbum
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
        newMedia = NO;
    }
}

// camera delegate methods

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker
        didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediatype = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage;
    
    if (CFStringCompare((CFStringRef) mediatype,kUTTypeImage, 0) == kCFCompareEqualTo)
    {
        editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
        originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    if (editedImage)
        imageToSave = editedImage;
    else
        imageToSave = originalImage;
    
    imageView.image = imageToSave;
    
    if (newMedia)
        UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil, nil);
    
    shareLabel.hidden = NO;
    fbButton.hidden = NO;
    twitterButton.hidden = NO;
    
    if (CFStringCompare((CFStringRef) mediatype, kUTTypeMovie, 0) == kCFCompareEqualTo)
    {
        NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        if(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath))
        {
            UISaveVideoAtPathToSavedPhotosAlbum(moviePath, nil, nil, nil);
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)fbButtonTapped:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [tweetSheet setInitialText:@"Tweeting from my own app! :)"];
        
        [tweetSheet addImage:imageToSave];
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Facebook account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }

}

- (IBAction)twitterTapped:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Tweeting from my own app! :)"];
        [tweetSheet addImage:imageToSave];
        
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }

}

@end
