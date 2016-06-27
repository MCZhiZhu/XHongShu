//
//  BuyViewController.m
//  XHongShu
//
//  Created by 周陆洲 on 16/5/24.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "BuyViewController.h"
#import "CategoryModel.h"
#import "SXTitleLable.h"
#import "TitleMenuView.h"
#import "BuyCollectionViewController.h"
@interface BuyViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_itemScrollView;
    UIScrollView *_mainScrollView;
    UIButton *_selectItemBtn;
    NSMutableArray *_itemArray;
    NSMutableArray *_dataArray;
    NSMutableArray *_controlArray;
    NSInteger _oldIndex;
    NSUInteger _index;
    UIView *_line;

}
@property (nonatomic,strong)CategoryModel *categoryModel;
@end

@implementation BuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
    [self createUI];
    [self getItemData];
//    [self getCrossFielData];
}

- (void)initNavBar
{
    self.navigationItem.title = @"福利社";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.barTintColor = MainRedColor;
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)getItemData{

    _itemArray = [NSMutableArray array];
    _dataArray = [NSMutableArray array];
//    _controlArray = [NSMutableArray array];
    _controlArray = [@[] mutableCopy];
    
    [MCNetworkingLogin getLogin:buyItemString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *itemArray = responseObject[@"data"];
        for (int i = 0; i < itemArray.count; i ++) {
            NSLog(@"%@",itemArray[i]);
            _categoryModel = [[CategoryModel alloc]initWithDictionary:itemArray[i] error:nil];
            NSDictionary *dict =[[NSDictionary alloc]initWithObjectsAndKeys:[[BuyCollectionViewController alloc]init],_categoryModel.name, nil];
            [_itemArray addObject:dict];

        }
        TitleMenuView *titleMenu = [[TitleMenuView alloc]initWithFrame:CGRectMake(0, 64, VIEW_WEDTH - 30, VIEW_HEIGHT-64) WithViewControllers:_itemArray WithStyle:TitleMenuStyleLine WithTitleFont:13 AndTitleInterval:0];
        
        titleMenu.btnSelectedColor = [UIColor redColor];
        
        titleMenu.btnNormalColor = [UIColor blackColor];
        
        titleMenu.sliderColor = [UIColor redColor];
        
        [self.view addSubview:titleMenu];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}



- (void)createUI{
    _selectItemBtn = [[UIButton alloc]initWithFrame:CGRectMake(VIEW_WEDTH - 30, 64, 30, 30)];
    [_selectItemBtn setImage:[UIImage imageNamed:@"goods_category_indicator_open~iphone"] forState:UIControlStateNormal];
    [_selectItemBtn setImage:[UIImage imageNamed:@"goods_category_indicator_close~iphone"] forState:UIControlStateSelected];
    [_selectItemBtn addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectItemBtn];
   
}
//#pragma mark 创建 itemBtn
//-(void)createItemBtn:(NSArray *)itemArray{
//    
//    _itemScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, VIEW_WEDTH -30, 30)];
//    _itemScrollView.contentSize = CGSizeMake(itemArray.count*70, 0);
//    [self.view addSubview:_itemScrollView];
//
//    for (int i = 0; i < itemArray.count; i ++) {
//        
//        _categoryModel = [[CategoryModel alloc]initWithDictionary:itemArray[i] error:nil];
//     
//        UIButton *itemBtn = [[UIButton alloc]initWithFrame:CGRectMake(i*70, 0, 70, 30)];
//        itemBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        [itemBtn setTitle:_categoryModel.name forState:UIControlStateNormal];
//        [itemBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [itemBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//        itemBtn.tag = i;
//        [_itemArray addObject:itemBtn];
//        [itemBtn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_itemScrollView addSubview:itemBtn];
//    }
//
//    
//    /** 添加子控制器 */
//    for (int i=0 ; i < itemArray.count ;i++){
//        BuyCollectionViewController *buyVC = [[BuyCollectionViewController alloc]init];
//        [_controlArray addObject:buyVC];
//        
//    }
//    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 94, VIEW_WEDTH, VIEW_HEIGHT - 94 -49)];
//    _mainScrollView.contentSize = CGSizeMake(itemArray.count*VIEW_WEDTH, 0);
//    _mainScrollView.backgroundColor = [UIColor grayColor];
//    _mainScrollView.pagingEnabled = YES;
//    _mainScrollView.delegate = self;
//    [self.view addSubview:_mainScrollView];
//
////    [self loadViewControllerAtIndex:0];
//    
////    UIViewController *vc = [self.childViewControllers firstObject];
////    vc.view.frame = CGRectMake(0,0, VIEW_WEDTH, VIEW_HEIGHT - 94 -49);
////    [_mainScrollView addSubview:vc.view];
//    
//    for (int j= 0; j < itemArray.count; j++) {
//        UIViewController *lastvc = _controlArray[j];
//        lastvc.view.frame =CGRectMake(j*VIEW_WEDTH,0, VIEW_WEDTH, VIEW_HEIGHT - 94 -49);
//        [_mainScrollView addSubview:lastvc.view];
//    }
////    [self RedLine:0];
//
//
//}
//- (void)itemClick:(UIButton *)btn{
//    _index = btn.tag;
//    [self moveLine:_index];
////    for (int i = 0; i<_itemArray.count; i++) {
//////        UIButton * btn =_controlArray[i];
////        if (_index == i) {
////            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
////            if (btn.selected == NO) {
//                _mainScrollView.contentOffset = CGPointMake(_index*VIEW_WEDTH, 0);
////            }
////        }else{
////            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
////        }
////        
////    }
// 
////  [self loadViewControllerAtIndex:btn.tag];
//}
- (void)selectItem:(UIButton *)btn{
    if (btn.isSelected) {
        _selectItemBtn.selected = NO;
    }else{
        _selectItemBtn.selected = YES;
    }

}
///** 正在滚动 */
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    // 获得索引
//    _index = scrollView.contentOffset.x /_mainScrollView.frame.size.width;
//    [self moveLine:_index ];
//}

//- (void)loadViewControllerAtIndex:(NSInteger)index {
//
//    UIViewController *fromViewController = _controlArray[_oldIndex];// 获取当前viewController
//    
//    UIViewController *toViewController = _controlArray[index];// 获取将要切换的viewController
//    
//    if (self.childViewControllers.firstObject == toViewController) {
//        
//        return;
//        
//    }
//    
//    if (self.childViewControllers.count > 0) {
//        
//        self.view.userInteractionEnabled = NO;// 切换过程中禁用操作，等切换动画结束后恢复
//        
//        [fromViewController willMoveToParentViewController:nil];// fromViewController将要移除
//        
//        [self addChildViewController:toViewController];// 将toViewController添加至ContainerViewController
//        // 设置view的frame
//        if (index > _oldIndex) {
//            toViewController.view.frame = [self nextViewStartFrame:index- _oldIndex];
//        }else if (index < _oldIndex){
//            toViewController.view.frame = [self preViewStartFrame: _oldIndex - index];
//        }
//
//        // 官方提供的切换动画API，在这里执行切换动画
//        
//        [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//         // 执行动画
//            if (index > _oldIndex) {
//                
//                fromViewController.view.frame = [self preViewStartFrame:index- _oldIndex];
//                
//                toViewController.view.frame = [self newViewStartFrame:index- _oldIndex];
//            }else  if (index < _oldIndex) {
//                
//                fromViewController.view.frame = [self nextViewStartFrame: _oldIndex - index];
//                
//                toViewController.view.frame = [self newViewStartFrame: _oldIndex - index];
//                
//            }
//            
//        } completion:^(BOOL finished) {
//            
//         // 动画执行完毕，从父视图添加或移除层级关系
//            
//            if (finished) {
//                
//                [toViewController didMoveToParentViewController:self];
//                
//                [fromViewController removeFromParentViewController];
//                
//                self.view.userInteractionEnabled = YES;
//            }
//            
//        }];
//        
//    } else {
//        
//        [self addChildViewController:toViewController];
//        
//        [_mainScrollView addSubview:toViewController.view];
//        
//        [toViewController didMoveToParentViewController:self];
//        
//    }
//    _oldIndex = index;
//}
//- (CGRect)newViewStartFrame:(NSInteger)index{
//    
//    return CGRectMake(0.0,0, VIEW_WEDTH , VIEW_HEIGHT - 143);
//    
//}
//- (CGRect)nextViewStartFrame:(NSInteger)index{
//    
//    return CGRectMake(VIEW_WEDTH * index, 0, VIEW_WEDTH,  VIEW_HEIGHT - 143);
//    
//}
//- (CGRect)preViewStartFrame:(NSInteger)index{
//    
//    return CGRectMake(-VIEW_WEDTH* index,0, VIEW_WEDTH,  VIEW_HEIGHT - 143);
//    
//}
//
//- (void)changeView:(UIButton *)btn notSelected:(BOOL)selected{
//    NSInteger index = [_controlArray indexOfObject:btn];
//    [self moveLine:index];
//    for (int i = 0; i<_controlArray.count; i++) {
//        UIButton * btn =_controlArray[i];
//        if (btn.tag == i) {
//            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//
//        }else{
//            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        }
//        
//    }
//}
//- (void)RedLine:(NSInteger)indexs{
//    
//    _line= [[UIView alloc]initWithFrame:CGRectMake(0, 43, 70, 2)];
//    _line.backgroundColor = [UIColor redColor];
//    [self.view addSubview:_line];
//    
//}
//-(void)moveLine:(NSInteger)indexs
//{
//    [UIView animateWithDuration:0.2 animations:^{
//        
//        _line.frame = CGRectMake(indexs*70, CGRectGetMaxY(_itemScrollView.frame) -1, 70, 2);
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
