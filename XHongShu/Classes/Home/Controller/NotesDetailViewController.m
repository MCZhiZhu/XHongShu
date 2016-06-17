//
//  NotesDetailViewController.m
//  XHongShu
//
//  Created by 周陆洲 on 16/6/1.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "NotesDetailViewController.h"
#import "HomeViewController.h"
#import "GoodsListModel.h"
#import "ImagesList.h"
#import "ForDetailsModel.h"
#import <UIImageView+WebCache.h>
#import "User.h"
#import "NavTransitioningBack.h"
#import "MCHub.h"
#import "CommentCell.h"
#import "NewestComments.h"

#define LeftMargin 15
static CGFloat const TopViewH = 55;
static NSString *CommentIdentifier = @"CommentCell";

@interface NotesDetailViewController ()<UIScrollViewDelegate,UINavigationControllerDelegate,MCScrollViewDelegate,MBProgressHUDDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *descripLabel;
@property (nonatomic, strong) UIScrollView *tagView;
@property (nonatomic, strong) UILabel *likeLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UITableView *commentTableView;
@property (nonatomic, strong) UIView *moreGoodsView;

@property (nonatomic, strong)ForDetailsModel *detailModel;
@property (nonatomic, strong) NSArray *commentArray;

@property(strong, nonatomic) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property(strong, nonatomic) NavTransitioningBack *backTransition;

@end

@implementation NotesDetailViewController
{
    NSMutableArray *_imageArray;
    
    UIImageView *_userHeadView;
    UILabel *_userName;
    
    MBProgressHUD *HUD;
    MCHub *hub;
    CGFloat _commentViewH;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _commentArray = [NSMutableArray array];
    
    self.navigationController.navigationBar.barTintColor = MainWhriteColor;
    self.navigationItem.title = @"笔记详情";
    
    UIBarButtonItem *leftItem = [UIBarButtonItem itemWithImageName:@"navi_back~iphone" target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self createTopView];

    [self getDetailData];
    
    //UIScreenEdgePanGestureRecognizer继承于UIPanGestureRecognizer，能检测从屏幕边缘滑动的手势，设置edges为left检测左边即可。然后实现handlePopRecognizer:
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
}


/**
 *  与动画控制器类似，我们把实现了 UIViewControllerInteractiveTransitioning 协议的对象称之为交互控制器，最常用的就是把交互控制器应用到导航栏的 Back 手势返回上，而如果要实现一个自定义的交互式动画，我们有两种方式来完成：实现一个交互控制器，或者使用iOS提供的 UIPercentDrivenInteractiveTransition 类作交互控制器。实际上这个类就是实现了 UIViewControllerInteractiveTransitioning 协议的交互控制器，我们使用它就能够轻松地为动画控制器添加一个交互动画。调用 updateInteractiveTransition: 更新进度；调用cancelInteractiveTransition 取消交互，返回到切换前的状态；调用 finishInteractiveTransition 通知上下文交互已完成,这个类只在需要用时才创建
 */

-(void)handlePopRecognizer:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    CGFloat progress = [recognizer translationInView:self.view].x / self.view.bounds.size.width;
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        if (progress > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];
        }else{
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
}

-(void)setImgDic:(NSDictionary *)imgDic{
    if (_imgDic == nil) {
        _imgDic = [NSDictionary dictionary];
    }
    _imgDic = imgDic;
}

-(void)getDetailData{
    hub = [[MCHub alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.customView = hub;
    HUD.color = [UIColor clearColor];
    [self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    [HUD show:YES];
    
    [MCNetworkingLogin getLogin:goodDetailUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = [NSDictionary dictionary];
        dic = responseObject[@"data"];
        _detailModel = [[ForDetailsModel alloc]initWithDictionary:dic error:nil];
        
        _commentArray = [NewestComments arrayOfModelsFromDictionaries:_detailModel.newestComments];
        
        [self setData];
        
        _imageArray = [NSMutableArray arrayWithArray:_detailModel.imagesList];
        [_imageArray insertObject:self.imgDic atIndex:0];
        
        _imageScrollView.imageItemArray = _imageArray;
        
        [HUD hide:YES];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [HUD hide:YES];
    }];
}

/**
 *  填充数据
 */
-(void)setData{
    User *userModel = _detailModel.user;
    [_userHeadView sd_setImageWithURL:[NSURL URLWithString:userModel.images]];
    _userName.text = userModel.nickname;
    
    [_descripLabel setAttributedText:[ToolMothod getLineSpacing:5 text:_detailModel.desc]];
    CGSize labelSize = [_descripLabel.text sizeWithFont:MCFont(14) lineSpacing:5 maxSize:CGSizeMake(SCREEN_WIDTH-25, MAXFLOAT)];
    _descripLabel.frame = CGRectMake(LeftMargin, 10,labelSize.width,labelSize.height);
    
    _likeLabel.text = [NSString stringWithFormat:@"%@次收藏      %@次点赞",_detailModel.favCount,_detailModel.likes];
    _likeLabel.origin = CGPointMake(SCREEN_WIDTH-_likeLabel.width-20, CGRectGetMaxY(_descripLabel.frame)+10);
    
    _commentLabel.origin = CGPointMake(LeftMargin, CGRectGetMaxY(_likeLabel.frame)+10);
    
    _commentTableView.origin = CGPointMake(0, CGRectGetMaxY(_commentLabel.frame)+10);
    [_commentTableView reloadData];
    [_commentTableView setSize:CGSizeMake(SCREEN_WIDTH, _commentViewH+60)];

    _bottomView.frame = CGRectMake(0, CGRectGetMaxY(_imageScrollView.frame), SCREEN_WIDTH, CGRectGetMaxY(_commentTableView.frame)+10);
    _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+_bottomView.height);
}

/**
 *  创建顶部区域
 */
-(void)createTopView{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.bounces = NO;
    _mainScrollView.backgroundColor = MCColor(242, 246, 249, 1.0);
    [self.view addSubview:_mainScrollView];
    
    //创建头像和昵称
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TopViewH)];
    _userHeadView = [[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, 11, 33, 33)];
    _userHeadView.userInteractionEnabled = YES;
    [_topView addSubview:_userHeadView];
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userHeadView.frame) + 10, 17.5, 200, 20)];
    _userName.font = MCFont(14);
    _userName.textColor = MCColor(40, 40, 40, 1.0);
    [_topView addSubview:_userName];
    UITapGestureRecognizer *headViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topViewClick)];
    [_topView addGestureRecognizer:headViewTap];
    [_mainScrollView addSubview:_topView];
    
    //创建图片滚动区
    [self createImageScroll];
    
    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [_mainScrollView addSubview:_bottomView];
    
    //创建描述详情
    _descripLabel = [[UILabel alloc] init];
    _descripLabel.font = MCFont(14);
    _descripLabel.numberOfLines = 0;
    _descripLabel.textColor = MCColor(40, 40, 40, 1.0);
    [_descripLabel setAttributedText:[ToolMothod getLineSpacing:5 text:self.des]];
    CGSize labelSize = [_descripLabel.text sizeWithFont:MCFont(14) lineSpacing:5 maxSize:CGSizeMake(SCREEN_WIDTH-25, MAXFLOAT)];
    _descripLabel.frame = CGRectMake(LeftMargin, 10,labelSize.width,labelSize.height);
    [_bottomView addSubview:_descripLabel];
    
    //点赞、收藏数
    _likeLabel = [[UILabel alloc] init];
    _likeLabel.font = MCFont(13);
    _likeLabel.textColor = MCColor(148, 148, 148, 1.0);
    _likeLabel.text = [NSString stringWithFormat:@"%@次收藏      %@次点赞",self.favCount,self.likes];
    _likeLabel.textAlignment = NSTextAlignmentRight;
    [_likeLabel setSize:CGSizeMake(250, 20)];
    _likeLabel.origin = CGPointMake(SCREEN_WIDTH - _likeLabel.width-20, CGRectGetMaxY(_descripLabel.frame)+10);
    [_bottomView addSubview:_likeLabel];
    
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, CGRectGetMaxY(_likeLabel.frame)+10, 150, 20)];
    _commentLabel.text = @"全部评论";
    _commentLabel.textColor = MCColor(67, 67, 67, 1.0);
    _commentLabel.font = MCFont(15);
    [_bottomView addSubview:_commentLabel];
    
    [self createCommtentTableView];
    
    _bottomView.frame = CGRectMake(0, CGRectGetMaxY(_imageScrollView.frame), SCREEN_WIDTH, CGRectGetMaxY(_commentLabel.frame)+10);
    _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(_likeLabel.frame));
}

-(void)topViewClick{
    
    NSLog(@"topViewClick");
}

/**
 *  创建图片滚动区域
 */
-(void)createImageScroll{
    
    CGFloat scrollH = [self getImageHWithImgW:[self.imgDic objectForKey:@"width"] imgH:[self.imgDic objectForKey:@"height"]];
    _imageScrollView = [[MCScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), SCREEN_WIDTH, scrollH)];
    _imageScrollView.mcDelegate = self;
    [_mainScrollView addSubview:_imageScrollView];
    
}
/**
 *  创建评论区域
 */
-(void)createCommtentTableView{
    _commentTableView = [[UITableView alloc] init];
    _commentTableView.dataSource = self;
    _commentTableView.delegate = self;
    _commentTableView.frame = CGRectMake(0, CGRectGetMaxY(_commentLabel.frame)+10, SCREEN_WIDTH, 160);
    [_commentTableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:CommentIdentifier];
    [_bottomView addSubview:_commentTableView];
}

-(CGFloat)getImageHWithImgW:(NSString *)imgW imgH:(NSString *)imgH{
    CGFloat width = [imgW floatValue];
    CGFloat height = [imgH floatValue];
    
    return SCREEN_WIDTH/width * height;
}

#pragma mark MCScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView viewHeight:(CGFloat)height
{
    _bottomView.origin = CGPointMake(0, CGRectGetMaxY(scrollView.frame));
}

#pragma mark tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentIdentifier];
    NewestComments *model = [_commentArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.userHead.imageView sd_setImageWithURL:[NSURL URLWithString:model.user.images]];
    cell.nickName.text = model.user.nickname;
    cell.timeLabel.text = model.time;
    cell.contentLabel.text = model.content;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentIdentifier];
    NewestComments *model = [_commentArray objectAtIndex:indexPath.row];
    
    [cell.userHead.imageView sd_setImageWithURL:[NSURL URLWithString:model.user.images]];
    cell.nickName.text = model.user.nickname;
    cell.timeLabel.text = model.time;
    cell.contentLabel.text = model.content;
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    _commentViewH += height;
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(LeftMargin, 16, 32, 32)];
    imageView.image = [UIImage imageNamed:@"tour_fillup_portrait~iphone"];
    [footView addSubview:imageView];
    
    UITextField *commentField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+10, 15, SCREEN_WIDTH-72, 36)];
    commentField.placeholder = @"说点什么，让TA也认识看笔记的你吧";
    commentField.backgroundColor = MCColor(242, 242, 242, 1.0);
    [footView addSubview:commentField];
    
    return footView;
}

#pragma mark - <UINavigationControllerDelegate>
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if ([animationController isKindOfClass:[NavTransitioningBack class]]) {
        return _interactivePopTransition;
    }else{
        return nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[HomeViewController class]])
{
        return self.backTransition;
    }else{
        return nil;
    }
}

-(NavTransitioningBack *)backTransition
{
    if (!_backTransition) {
        _backTransition = [[NavTransitioningBack alloc]init];
    }
    return _backTransition;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    [HUD removeFromSuperview];
    HUD = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
