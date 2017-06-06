//
//  CutPicetureDemoViewController.m
//  CutPicetureDemo
//
//  Created by yang kong on 12-6-26.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CutPicetureDemoViewController.h"


@implementation CutPicetureDemoViewController

@synthesize ShowPicView;
@synthesize CutView = _CutView;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



//*/


-(void)buttonPressed:(id)sender
{
	UIButton *button =(UIButton*)sender;
	if(button.tag == 0){
	
	UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:nil
															 delegate:self
													cancelButtonTitle:@"取消" 
											   destructiveButtonTitle:nil
													otherButtonTitles: @"拍照", @"相册", nil];
	actionSheet.tag = 0;
	[actionSheet showInView:self.view];
	[actionSheet release];
	}
	else if(button.tag == 1)
	{
		UIImage *image =  [ShowPicView getCutPicetureByRect:[_CutView getCutPicetureRect]];
		UIImageWriteToSavedPhotosAlbum(image,nil, nil, nil);
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"保存成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
		[alertView show];
		[alertView release];
	}
	else if(button.tag == 2)
	{
		[ShowPicView PortraitImage];
		[_CutView setBgImage:nil andtheRect:ShowPicView.frame];
	}
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)modalView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (buttonIndex)
	{
		case 0:
		{
			if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
				UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
				imagePicker.delegate = self;
				imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
				[self presentModalViewController:imagePicker animated:YES];
                _isCarm = YES;
				[imagePicker release];
			}
			break;
		}
		case 1:
		{
//			if (screenWidth<500) 
			{//ipad 不支持
				UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
				imagePicker.delegate = self;
				imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
				[self presentModalViewController:imagePicker animated:YES];
                _isCarm = NO;
				[imagePicker release];
			}
			break;
		}
		case 2:
		{
			break;
		}
	}
}


#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)selectedImage editingInfo:(NSDictionary *)editingInfo 
{
	NSLog(@"selected Image Finished");
    if (_isCarm == YES) {
        [ShowPicView PortraitImage];
        [_CutView setBgImage:nil andtheRect:ShowPicView.frame];
    }
     CGFloat width = selectedImage.size.width;
    CGFloat height = selectedImage.size.height;
	//bIsNewPic = YES;
    if (selectedImage.size.width  > selectedImage.size.height) {
        width = selectedImage.size.height;
        height = selectedImage.size.width;
    }
    
	CGSize mySize;
	if(width > 640)
	{
		mySize = CGSizeMake(640, height*(640/width));
		if(mySize.height > 960)
		{
			mySize = CGSizeMake(mySize.width*(960/mySize.height), 960);
		}
	}
	else if(selectedImage.size.height > 960)
	{
		mySize = CGSizeMake(width*(960/height), 960);
		if(mySize.width > 960)
		{
			mySize = CGSizeMake(640, mySize.height*(640/mySize.width));
		}
		
	}
	else
	{
    
  
	}

    [self dismissModalViewControllerAnimated:YES];

	ShowPicView.hidden = NO;
	[ShowPicView setBgImage:selectedImage];
	[_CutView setBgImage:selectedImage andtheRect:ShowPicView.frame];
//	ShowPicView.showImageView.image = selectedImage;//[UIImage imageNamed:@"Default.png"];

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


///*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"图片编辑Demo";
	

    _isCarm = NO;
	
	 ShowPicView = [[ShowPicetureView alloc] initWithFrame:CGRectMake(20, 20, 280, 360)];
    ShowPicView.backgroundColor = [UIColor clearColor];
	ShowPicView.hidden = YES;
    [self.view addSubview:ShowPicView];
	
	_CutView = [[CutPicetureView alloc] initWithFrame:CGRectMake(0, 0, 320, 380)];
	[self.view addSubview:_CutView];
	
	
	UIButton * selPic  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	selPic.frame = CGRectMake(10, 385, 70, 30);
	[selPic setTitle:@"选择图片" forState:UIControlStateNormal];
	selPic.titleLabel.textColor = [UIColor blackColor];
	selPic.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
	selPic.tag = 0;
	[selPic addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:selPic];
	
	UIButton * savePic  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	savePic.frame = CGRectMake(100, 385, 100, 30);
	[savePic setTitle:@"保存剪切图片" forState:UIControlStateNormal];
	savePic.titleLabel.textColor = [UIColor blackColor];
	savePic.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
	savePic.tag = 1;
	
	[savePic addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:savePic];
	
	UIButton * PortraitImage  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	PortraitImage.frame = CGRectMake(210, 385, 60, 30);
	[PortraitImage setTitle:@"旋转" forState:UIControlStateNormal];
	PortraitImage.titleLabel.textColor = [UIColor blackColor];
	PortraitImage.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
	PortraitImage.tag = 2;
	
	[PortraitImage addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:PortraitImage];
	
	
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[ShowPicView release];
	[_CutView release];
	_CutView = nil;
    [super dealloc];
}

@end
