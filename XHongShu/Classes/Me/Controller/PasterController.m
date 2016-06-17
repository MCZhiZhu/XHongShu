//
//  PasterController.m
//  XTPasterManager
//
//  Created by TuTu on 15/10/16.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "PasterController.h"
#import "PasterChooseView.h"
#import "XTPasterStageView.h"
#import "XTPasterView.h"
#import "NavigationView.h"
#import "SelectLabelViewController.h"
#import <XHTagView/XHTagView.h>


static const CGFloat width_pasterChoose = 110.0f ;

@interface PasterController () <UIScrollViewDelegate,PasterChooseViewDelegate,UITextFieldDelegate,AddLabelDelegate>
{
    UIView *_stickerView1;
    UIView *_stickerView2;
    
    UIView *_filterView1;
    UIView *_filterView2;
    
    UIButton *_filterBtn1;
    UIButton *_filterBtn2;
    UIButton *_stickerBtn1;
    UIButton *_stickerBtn2;
    
    UIView *_stickerView;
    
    CGPoint _point;//点击屏幕的哪个点
    UIView *_addLabelView;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_muArray;
    
    NSArray *_filterGalleryArray;
    NSArray *_beautifyPhotosArray;
    NSArray *_activityStickersArray;
    NSArray *_myStickerArray;
}
// UIs

@property (strong, nonatomic)        XTPasterStageView *stageView ;
@property (strong, nonatomic)UIView *topBar;
// Attrs
@property (nonatomic,copy) NSArray *pasterList ;

@property (nonatomic,strong)NavigationView *navigationView;

@property (nonatomic,strong) XHTagView      *tagView;
@end

@implementation PasterController

- (BOOL)prefersStatusBarHidden{
    return YES;
}
#pragma mark - PasterChooseViewDelegate
- (void)pasterClick:(NSString *)paster
{
    UIImage *image = [UIImage imageNamed:paster] ;
    
    if (!image) return ;
    
    //在这里 添加 贴纸
    [_stageView addPasterWithImg:image] ;
}


#pragma mark - Property
- (NSArray *)pasterList
{
    if (!_pasterList)
    {
        _pasterList = @[@"1",@"2",@"3",@"4",@"5"] ;
    }
    
    return _pasterList ;
}

#pragma mark - Life cycle
- (void)setup
{
    CGFloat sideFlex = 0.0f ;
    CGRect rectImage = CGRectZero ;
    CGFloat length = VIEW_WEDTH ;
    rectImage.size = CGSizeMake(length, length) ;
    CGFloat y = 44 ;
    rectImage.origin.x = sideFlex ;
    rectImage.origin.y = y ;
    
    _stageView = [[XTPasterStageView alloc] initWithFrame:rectImage] ;
    _stageView.originImage = self.imageWillHandle ;
    _stageView.backgroundColor = [UIColor purpleColor] ;
    _stageView.delegate = self;
    [self.view addSubview:_stageView] ;
    
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    [self.view bringSubviewToFront:self.topBar] ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataArray = [NSMutableArray arrayWithObjects:@"品牌",@"名称",@"币种",@"价格",@"国家/城市",@"具体地点",nil];
    _muArray = [NSMutableArray array];
    
    [self initNavBar];
    [self barbtnItem];
    [self createUI];
    
    [self setup] ;
    [self scrollviewSetup] ;
    
}
- (void)initNavBar{
    self.navigationController.navigationBar.barTintColor = MainWhriteColor;
    self.navigationItem.title = @"编辑照片(1/1)";
}

- (void)barbtnItem{
    UIBarButtonItem *userItem = [UIBarButtonItem itemWithImageName:@"navi_back~iphone" target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = userItem;
    
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc]initWithTitle:@"继续" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
    
    self.navigationItem.rightBarButtonItem = setItem;
}
- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    _filterGalleryArray = [NSArray arrayWithObjects:@"原图",@"迷失东京",@"挪威的森林",@"一页台北",@"罗马假日",@"恋战冲绳",@"情迷翡冷翠",@"布拉格之恋",@"旺角卡门",@"广岛之恋",@"冰岛之梦", nil];
    
    _beautifyPhotosArray = [NSArray arrayWithObjects:@"裁剪",@"亮度",@"对比度",@"色温",@"饱和度", nil];
    
    _activityStickersArray = [NSArray arrayWithObjects:@"不漏退等什么",@"欧洲杯看球必备",@"良心美剧我推荐",@"小长假去哪儿",@"这就是我的态度",@"爱美的态度",@"爱美的态度",@"爱美的态度",@"爱美的态度",@"吃货的态度",@"吃货的态度",@"吃货的态度",@"周末宅家",@"我心中的米其林",@"今夏必Buy连...",@"一线鞋星",@"小众控的好品味",@"夏日缤纷妆容色",@"周末探店",@"我的66第一单",@"历史贴纸", nil];
    
    _myStickerArray = [NSArray arrayWithObjects:@"1",@"不漏退等什么",@"欧洲杯看球必备",@"良心美剧我推荐",@"LOVE",@"BAG",@"Sweetheart",@"CrystalClear",@"GreatGift",@"Daisy",@"Rose", nil];
}

- (void)scrollviewSetup{
    
    _navigationView = [[NavigationView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_stageView.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(_stageView.frame)) name:@[@"滤镜",@"标签",@"贴纸"]];
    _navigationView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_navigationView];
    
    [self creeateStickerView];
    [self createFilterView];
    [self createLabelView];
    

}
#pragma mark 滤镜
- (void)createFilterView{
    UIView *filterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(_stageView.frame)-44)];
    filterView.backgroundColor = [UIColor whiteColor];
    [_navigationView.scrollView addSubview:filterView];
    
    _filterBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 60, 20)];
    _filterBtn1.tag = 4000;
    _filterBtn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [_filterBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_filterBtn1 setTitle:@"滤镜库" forState:UIControlStateNormal];
    
    [_filterBtn1 addTarget:self action:@selector(filterClick:) forControlEvents:UIControlEventTouchUpInside];
    [filterView addSubview:_filterBtn1];
    
    UIView *lineView = [ToolMothod createLineWithWidth:1.0 andHeight:20 andColor:[UIColor groupTableViewBackgroundColor]];
    lineView.frame = CGRectMake(CGRectGetMaxX(_filterBtn1.frame)+5, 10, 1.0, 20);
    [filterView addSubview:lineView];
    
    _filterBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame)+5, 10, 60, 20)];
    _filterBtn2.tag = 4001;
    _filterBtn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [_filterBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_filterBtn2 setTitle:@"美化照片" forState:UIControlStateNormal];
    [_filterBtn2 addTarget:self action:@selector(filterClick:) forControlEvents:UIControlEventTouchUpInside];
    [filterView addSubview:_filterBtn2];
  
}
#pragma mark 标签
- (void)createLabelView{
    
    UIView *labelView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH,SCREEN_HEIGHT - CGRectGetMaxY(_stageView.frame)-44)];
    labelView.backgroundColor = [UIColor whiteColor];
    [_navigationView.scrollView addSubview:labelView];
    
    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(_stageView.frame)-44)];
    labelName.text = @"点击照片\n选择添加相关信息";
    labelName.font = [UIFont systemFontOfSize:16];
    labelName.textAlignment = NSTextAlignmentCenter;
    labelName.numberOfLines = 2;
    [labelView addSubview:labelName];
    
}

#pragma mark 贴纸
- (void)creeateStickerView{
    
    _stickerView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH,SCREEN_HEIGHT - CGRectGetMaxY(_stageView.frame)-44)];
    _stickerView.backgroundColor = [UIColor whiteColor];
    [_navigationView.scrollView addSubview:_stickerView];

    
    _stickerBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 60, 20)];
    _stickerBtn1.tag = 2000;
    _stickerBtn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [_stickerBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_stickerBtn1 setTitle:@"活动贴纸" forState:UIControlStateNormal];
    
    [_stickerBtn1 addTarget:self action:@selector(stickerClick:) forControlEvents:UIControlEventTouchUpInside];
    [_stickerView addSubview:_stickerBtn1];
    
    UIView *lineView = [ToolMothod createLineWithWidth:1.0 andHeight:20 andColor:[UIColor groupTableViewBackgroundColor]];
    lineView.frame = CGRectMake(CGRectGetMaxX(_stickerBtn1.frame)+5, 10, 1.0, 20);
    [_stickerView addSubview:lineView];
    
    _stickerBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView.frame)+5, 10, 60, 20)];
    _stickerBtn2.tag = 2001;
    _stickerBtn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [_stickerBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_stickerBtn2 setTitle:@"我的贴纸" forState:UIControlStateNormal];
    [_stickerBtn2 addTarget:self action:@selector(stickerClick:) forControlEvents:UIControlEventTouchUpInside];
    [_stickerView addSubview:_stickerBtn2];
    
    _stickerView1 = [self PasterView:CGSizeMake(VIEW_WEDTH, _stickerView.bounds.size.height -30) dataArray:_activityStickersArray];
    _stickerView1.frame = CGRectMake(0,CGRectGetMaxY(_stickerBtn1.frame)+10, VIEW_WEDTH, _stickerView.bounds.size.height -30);
    _stickerView1.backgroundColor = [UIColor purpleColor];
    [_stickerView addSubview:_stickerView1];
    _stickerView1.hidden = NO;
    
}
- (void)stickerClick:(UIButton *)btn{
    
    if (btn.tag == 2000) {

        _stickerView1.hidden = NO;
        _stickerView2.hidden = YES;
        [_stickerBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_stickerBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }else{
        if (!_stickerView2) {
            _stickerView2 = [self PasterView:CGSizeMake(VIEW_WEDTH, _stickerView.bounds.size.height -30) dataArray:_myStickerArray];
            _stickerView2.frame =  CGRectMake(0, CGRectGetMaxY(_stickerBtn1.frame)+10, VIEW_WEDTH, _stickerView.bounds.size.height -30);
            [_stickerView addSubview:_stickerView2];

        }
        _stickerView1.hidden = YES;
        _stickerView2.hidden = NO;
        [_stickerBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_stickerBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (void)filterClick:(UIButton *)btn{
    
    if (btn.tag == 4000) {
        
        _filterView1.hidden = NO;
        _filterView2.hidden = YES;
        [_filterBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_filterBtn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
    }else{
        _filterView1.hidden = YES;
        _filterView2.hidden = NO;
        [_filterBtn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_filterBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}
#pragma mark 贴纸View
- (UIView *)PasterView:(CGSize)size dataArray:(NSArray *)pasterList{
    
    UIView *pasterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];

    [self .view addSubview:pasterView];
    
    UIScrollView *scrollPaster = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, size.width,size.height)];
    scrollPaster.delegate = self ;
    scrollPaster.pagingEnabled = NO ;
    scrollPaster.showsVerticalScrollIndicator = NO ;
    scrollPaster.showsHorizontalScrollIndicator = NO ;
    scrollPaster.bounces = YES ;
    scrollPaster.contentSize = CGSizeMake(width_pasterChoose *pasterList.count,
                                            scrollPaster.frame.size.height) ;
    [pasterView addSubview:scrollPaster];
    
    int _x = 0 ;
    
    for (int i = 0; i < pasterList.count; i++)
    {
        CGRect rect = CGRectMake(_x, 0, SCREEN_WIDTH, scrollPaster.frame.size.height) ;
        PasterChooseView *pView = (PasterChooseView *)[[[NSBundle mainBundle] loadNibNamed:@"PasterChooseView" owner:self options:nil] lastObject] ;
        pView.backgroundColor = [UIColor whiteColor];
        pView.frame = rect ;
        
        pView.aPaster = pasterList[i] ;
        
        pView.delegate = self ;
        [scrollPaster addSubview:pView] ;
        
        _x += width_pasterChoose ;
    }
    return pasterView;
}
#pragma mark 添加标签
- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)gesture{
    
    
    _point = [gesture locationInView:gesture.view];
    
    _tagView = [[XHTagView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _tagView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [_stageView.imgView addSubview:_tagView];
    
    _addLabelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _addLabelView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.9];
    [self.navigationController.view addSubview:_addLabelView];
    
    _addLabelView.alpha = 1.0;
    
    CGFloat field_Magin = 8;
    CGFloat field_HEIGHT = 30;
    CGFloat field_WEDTH = (VIEW_WEDTH - 5*field_Magin)/3;
    CGFloat field_X;
    CGFloat field_Y;
    for (int i = 0; i< 6; i++) {
        
        field_Y = i/2 * (field_HEIGHT +15) + 200 + 20;
        field_X = i%2*(field_WEDTH +field_Magin) +field_Magin*2;
        field_WEDTH = i%2*(VIEW_WEDTH - 5*field_Magin)/3+(VIEW_WEDTH - 5*field_Magin)/3;
        
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(field_X, field_Y, field_WEDTH, 30)];
        
        textField.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        textField.clearButtonMode =  YES;
        textField.delegate = self;
        textField.leftViewMode = UITextFieldViewModeUnlessEditing;
        textField.tag = i;
        textField.textColor = [UIColor whiteColor];
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = MCColor(191, 193, 194, 1.0).CGColor;
        textField.layer.cornerRadius = 15;
        textField.font = [UIFont systemFontOfSize:12];
        [textField setText:[NSString stringWithFormat:@"    %@",_dataArray[i]]];
        [_addLabelView addSubview:textField];
        [_muArray addObject:textField];
        
    }
    
    UIButton *finishBtn = [[UIButton alloc]initWithFrame:CGRectMake((VIEW_WEDTH - 200)/2,400, 200, 30)];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishBtn.backgroundColor = [UIColor redColor];
    finishBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    finishBtn.layer.cornerRadius = 15;
    [finishBtn addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    [_addLabelView addSubview:finishBtn];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake((VIEW_WEDTH - 200)/2, 450, 200, 30)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor redColor];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cancelBtn.layer.cornerRadius = 15;
    [cancelBtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [_addLabelView addSubview:cancelBtn];
    
    
}
- (void)finish:(UIButton *)btn{
    
    _tagView.branchTexts = @[@"你要你要你要去去",@"仅仅看到",@"是大大说的"];
    [_tagView showInPoint:_point];
    _tagView.imageSize = CGSizeMake(_stageView.imgView.size.width, _stageView.imgView.size.height);
    _addLabelView.alpha = 0.0;
}
- (void)cancel:(UIButton *)btn{
    [UIView animateWithDuration:0.2 animations:^{
        _addLabelView.alpha = 0.0;
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //写你要实现的：页面跳转的相关代码
    if (textField == [_muArray objectAtIndex:3]) {
        [textField resignFirstResponder];
        return YES;
    }else{
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        SelectLabelViewController *selectLabelVC = [[SelectLabelViewController alloc]init];
        selectLabelVC.index = textField.tag;
        selectLabelVC.valueBlock = ^(NSString *value){
            
            [textField setText:[NSString stringWithFormat:@"    %@",value]];
        };
        [self presentViewController:selectLabelVC animated:NO completion:nil];
        
        return NO;
        
    }
}
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}

#pragma mark 取消
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 继续
- (void)next{
    UIImage *imgResult = [_stageView doneEdit] ;
    [self.delegate pasterAddFinished:imgResult] ;
}
@end
