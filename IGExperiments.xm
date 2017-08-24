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

static NSString *experimentIdentifier;
static NSArray *experimentSet0;
static NSArray *experimentSet1;
static BOOL oldVersion;

%hook IGAccountSettingsViewController

- (void)viewDidLoad {
	%orig;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navBarSettings"] style:UIBarButtonItemStylePlain target:self action:@selector(showExperimentsController:)];
}

%new
- (void)showExperimentsController:(UIBarButtonItem *)item {
	if(oldVersion) {

		IGAlertView *alertView = [[NSClassFromString(@"IGAlertView") alloc] initWithTitle:@"IGExperiments" message:@"You are running an unsupported version of Instagram, please update to the latest version." cancelButtonTitle:@"Dismiss" otherButtonTitle:nil cancelBlock:nil  otherBlock:nil];
		[alertView show];
		[alertView release];

		return;
	}

	NSMutableArray *experiments = [NSMutableArray new];

	for(IGExperimentSpec *eSpec in experimentSet0) {
		[experiments addObject:eSpec];
	}

	for(IGExperimentSpec *eSpec in experimentSet1) {
		if(![experiments containsObject:eSpec]) {
			[experiments addObject:eSpec];
		}
	}

	IGExperimentSet *experimentSet = [[NSClassFromString(@"IGExperimentSet") alloc] initWithExperimentType:0 experimentSpecs:experiments uniqueIdentifier:experimentIdentifier];
	IGExperimentCategoryListViewController *experimentsController = [[NSClassFromString(@"IGExperimentCategoryListViewController") alloc] initWithTitle:@"Experiments" experimentSet:experimentSet];
	[self showViewController:experimentsController sender:nil];
}
%end

%hook IGExperimentSet
-(id)initWithExperimentType:(int)type experimentSpecs:(NSArray *)experiments uniqueIdentifier:(NSString *)identifier {

	if(type == 0) {
		experimentIdentifier = identifier;
		experimentSet0 = experiments;
	}

	if(type == 1) {
		experimentSet1 = experiments;
	}
	return %orig;
}
%end

%ctor {
	NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
	NSComparisonResult newestWaveVersionComparisonResult = [version compare:@"11.0" options:NSNumericSearch];

	if (newestWaveVersionComparisonResult == NSOrderedAscending) {
		oldVersion = YES;
	}
}
