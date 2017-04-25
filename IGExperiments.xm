//
//
//    IGExperiments.xm
//    White Instagram
//    Created by Juan Carlos Perez <carlos@jcarlosperez.me> 04/27/2016
//    © CP Digital Darkroom <admin@cpdigitaldarkroom.com>. All rights reserved.
//
//
//

#import "IGExperiments.h"

static NSString *igeIdentifier;
static NSArray *igeExperimentSet0;
static NSArray *igeExperimentSet1;
static BOOL oldVersion;

%hook IGProfileViewController
- (void)navigationItemsControllerDidTapSettings:(id)arg1 {
	IGAlertView *alertView = [[NSClassFromString(@"IGAlertView") alloc] initWithTitle:@"IGExperiments" message:@"Which settings would you like?" cancelButtonTitle:@"Default Settings" otherButtonTitle:@"Experimental Settings" cancelBlock:^{
		%orig;
		}  otherBlock:^{
			[self showExperimentController];
			}];
	[alertView show];
	[alertView release];
}
%new
- (void)showExperimentController {

	if(oldVersion) {

		IGAlertView *alertView = [[NSClassFromString(@"IGAlertView") alloc] initWithTitle:@"IGExperiments" message:@"You are running an unsupported version of Instagram, please update to the latest version." cancelButtonTitle:@"Dismiss" otherButtonTitle:nil cancelBlock:nil  otherBlock:nil];
		[alertView show];
		[alertView release];

		return;
	}

	NSMutableArray *experiments = [NSMutableArray new];

	for(IGExperimentSpec *eSpec in igeExperimentSet0) {
		[experiments addObject:eSpec];
	}

	for(IGExperimentSpec *eSpec in igeExperimentSet1) {
		if(![experiments containsObject:eSpec]) {
			[experiments addObject:eSpec];
		}
	}

	IGExperimentSet *experimentSet = [[NSClassFromString(@"IGExperimentSet") alloc] initWithExperimentType:0 experimentSpecs:experiments uniqueIdentifier:igeIdentifier];
	NSLog(@"Do I get here");
	IGExperimentCategoryListViewController *experimentsController = [[NSClassFromString(@"IGExperimentCategoryListViewController") alloc] initWithTitle:@"Experiments" experimentSet:experimentSet];
	[self showViewController:experimentsController sender:nil];
}
%end

%hook IGUserDetailViewController_DEPRECATED

- (void)navigationItemsControllerDidTapSettings:(id)arg1 {
	IGAlertView *alertView = [[NSClassFromString(@"IGAlertView") alloc] initWithTitle:@"IGExperiments" message:@"Which settings would you like?" cancelButtonTitle:@"Default Settings" otherButtonTitle:@"Experimental Settings" cancelBlock:^{
		%orig;
		}  otherBlock:^{
			[self showExperimentController];
			}];
	[alertView show];
	[alertView release];
}

%new
- (void)showExperimentController {

	if(oldVersion) {

		IGAlertView *alertView = [[NSClassFromString(@"IGAlertView") alloc] initWithTitle:@"IGExperiments" message:@"You are running an unsupported version of Instagram, please update to the latest version." cancelButtonTitle:@"Dismiss" otherButtonTitle:nil cancelBlock:nil  otherBlock:nil];
		[alertView show];
		[alertView release];

		return;
	}

	NSMutableArray *experiments = [NSMutableArray new];

	for(IGExperimentSpec *eSpec in igeExperimentSet0) {
		[experiments addObject:eSpec];
	}

	for(IGExperimentSpec *eSpec in igeExperimentSet1) {
		if(![experiments containsObject:eSpec]) {
			[experiments addObject:eSpec];
		}
	}

	IGExperimentSet *experimentSet = [[NSClassFromString(@"IGExperimentSet") alloc] initWithExperimentType:0 experimentSpecs:experiments uniqueIdentifier:igeIdentifier];
	NSLog(@"Do I get here");
	IGExperimentCategoryListViewController *experimentsController = [[NSClassFromString(@"IGExperimentCategoryListViewController") alloc] initWithTitle:@"Experiments" experimentSet:experimentSet];
	[self showViewController:experimentsController sender:nil];
}
%end

%hook IGExperimentSet
-(id)initWithExperimentType:(int)type experimentSpecs:(NSArray *)experiments uniqueIdentifier:(NSString *)identifier {

	if(type == 0) {
		igeIdentifier = identifier;
		igeExperimentSet0 = experiments;
	}

	if(type == 1) {
		igeExperimentSet1 = experiments;
	}
	return %orig;
}
%end

%ctor {
	NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
	NSComparisonResult newestWaveVersionComparisonResult = [version compare:@"10.2" options:NSNumericSearch];

	if (newestWaveVersionComparisonResult == NSOrderedAscending) {
		oldVersion = YES;
	}
}
