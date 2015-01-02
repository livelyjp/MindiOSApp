//
//  LoginViewController.m
//  MindApp
//
//  Created by Jonny Pillar on 14/12/2014.
//  Copyright (c) 2014 Jonny Pillar. All rights reserved.
//

#import "LoginViewController.h"
#import "MediaListViewCollectionViewController.h"
#import "LoginRequestModel.h"
#import "LoginResponseModel.h"
#import "InputValidationUtil.h"
#import "CommunicationsManager.h"

@interface LoginViewController () <CommunicationsManagerDelegate>

@property (nonatomic,strong) CommunicationsManager* communicationManager;

@end

@implementation LoginViewController

static NSString * const postLoginUrl = @"http://mind-1.apphb.com/api/Account/LogIn";

- (void)viewDidLoad {
    [super viewDidLoad];
	[self.loginEmailAddressTextField setText:@"test@test.com"];
	[self.loginPasswordTextField setText:@"123456"];
	self.communicationManager = [[CommunicationsManager alloc] initWithDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)performLogin:(id)sender {
	if(![self validateLoginFields]) return;
	
	LoginRequestModel *loginRequestModel = [self createLoginModel];
	
	[_communicationManager PostRequest:postLoginUrl withParams:nil withBody:loginRequestModel.GetResquestDictionary];
}

#pragma mark Communication Manager Delegate Methods

-(void) handleSuccess:(NSDictionary*) responseDictionary{
	LoginResponseModel *loginModel = [[LoginResponseModel alloc] initWithDictionary:responseDictionary];
	if(loginModel.Success) {
		[self performSegueWithIdentifier:@"segueToMediaListView" sender:self];
	}
	else{
		[self showErrorAlert:loginModel.Message];
	}
}

-(void) handleFailure:(NSDictionary*) responseDictionary{
	
	LoginResponseModel *loginModel = [[LoginResponseModel alloc] initWithDictionary:responseDictionary];
	[self showErrorAlert:loginModel.Message];
}

#pragma mark Login Creation Methods

- (LoginRequestModel *)createLoginModel {
	LoginRequestModel* loginRequestModel = [LoginRequestModel new];
	loginRequestModel.EmailAddress = self.loginEmailAddressTextField.text;
	loginRequestModel.Password = self.loginPasswordTextField.text;
	return loginRequestModel;
}


#pragma mark Validation Methods

- (BOOL) validateLoginFields {
	
	if(![InputValidationUtil validateEmailField: _loginEmailAddressTextField])
	{
		[self showErrorAlert: @"Login Email Field Is Invalid"];
	}
	if(![InputValidationUtil validatePasswordField: _loginPasswordTextField])
	{
		[self showErrorAlert: @"Login Password Field Is Invalid"];
	}
	
	return true;
}

#pragma mark UI Methods

-(void) showErrorAlert:(NSString*) errorMessage
{
	UIAlertView *ErrorAlert = [[UIAlertView alloc] initWithTitle:@""
														 message:errorMessage
														delegate:nil
											   cancelButtonTitle:@"OK"
											   otherButtonTitles:nil, nil];
	[ErrorAlert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([[segue identifier] isEqualToString:@"segueToMediaListView"])
	{
		[segue destinationViewController];
	}
}

@end
