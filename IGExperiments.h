
@interface IGAlertView : UIAlertView
-(id)initWithTitle:(id)arg1 message:(id)arg2 cancelButtonTitle:(id)arg3 otherButtonTitle:(id)arg4 cancelBlock:(/*^block*/id)arg5 otherBlock:(/*^block*/id)arg6 ;
@end

@interface IGAuthHelper
+(id)currentUser;
@end

@interface IGUser : NSObject
@property (copy) NSString * username;
@end

@interface IGExperimentSpec : NSObject
@end

@interface IGExperimentSet : NSObject
@property (nonatomic,retain) NSArray * defaultExperiments;
-(id)experiments;
-(NSArray *)defaultExperiments;
-(id)initWithExperimentType:(int)arg1 defaultExperiments:(NSArray *)experiments uniqueIdentifier:(NSString *)identifier;
-(id)initWithExperimentType:(int)arg1 experimentSpecs:(NSArray *)experiments uniqueIdentifier:(NSString *)identifier service:(id)arg4;
- (id)initWithExperimentType:(long long)arg1 experimentSpecs:(id)arg2 uniqueIdentifier:(id)arg3;
- (id)initWithExperimentType:(long long)arg1 experimentSpecs:(id)arg2 uniqueIdentifier:(id)arg3 networker:(id)arg4;
@end

@interface IGExperimentManager
+(id)sharedInstance;
+(void)refreshExperimentsIfNecessary;
+(char)wantsColdStart;
-(IGExperimentSet *)deviceExperimentSet;
+(id)experiments;
+(NSDictionary *)experimentsGroupsMapping;
@end

@interface IGExperimentCategoryListViewController : UIViewController
-(id)initWithTitle:(id)arg1 experimentSet:(id)arg2 ;
@end

@interface IGExperimentGroupViewController : UIViewController
-(id)initWithExperiment:(id)arg1 experimentSet:(id)arg2 ;
@end

@interface IGExperimentListViewController : UIViewController
-(id)initWithTitle:(id)arg1 experiments:(id)arg2;
-(id)initWithTitle:(id)arg1 experiments:(id)arg2 experimentSet:(id)arg3;
@end

@interface IGUserDetailViewController : UIViewController
-(BOOL)isShowingCurrentUser;
-(void)showExperimentController;
@end

@interface IGUserDetailViewController_DEPRECATED : UIViewController // Not sure when they renamed it to deprecated
-(BOOL)isShowingCurrentUser;
-(void)showExperimentController;
@end

@interface IGService : NSObject
+(id)sharedService;
@end

@interface IGNetworker : NSObject
+ (id)sharedNetworker;
@end

@interface IGViewController : UIViewController
@end

@interface IGProfileViewController : IGViewController
-(void)showExperimentController;
@end
