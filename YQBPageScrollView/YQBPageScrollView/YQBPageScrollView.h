#import <UIKit/UIKit.h>
#import "YQBTitleModel.h"
#import "UITableView+ConvenienceMethod.h"
#import "UIView+YQBFrame.h"


@class YQBPageScrollView;
@protocol YQBPageTableViewDelegate <NSObject>
-(void)pageScrollView:(YQBPageScrollView *)pageScrollView tableViewForIndexOfTitle:(NSUInteger)index;
@end


@interface YQBPageScrollView : UIView <UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

///集合视图每一项的宽度
@property (assign,nonatomic) CGFloat itemW;

///当前选中标题颜色 默认黑色
@property (strong,nonatomic) UIColor * selectedTitleColor;

///未选中标题颜色  默认黑色
@property( strong, nonatomic)UIColor * unselectedTitleColor;

///选中字体大小  默认12
@property( strong, nonatomic)UIFont * selectedTitleFont;

///未选中字体大小 默认12
@property( strong, nonatomic)UIFont * unselectedTitleFont;

///集合视图数据数组    通过设置标题数组得来
@property (strong,nonatomic) NSMutableArray<YQBTitleModel *> * titleModelMA;

///代理
@property (weak,nonatomic) id<YQBPageTableViewDelegate>delegate;

#pragma mark - 视图部分

///设置布局
@property (strong,nonatomic) UICollectionViewFlowLayout      * flowLayout;

///上面一个集合视图 默认高度35
@property (strong,nonatomic) UICollectionView * collectionView;


///集合视图 添加一个 滑块视图 默认宽高 {35 ,2}
@property (strong,nonatomic) UIView * sliderView;

///分割线视图
@property (strong,nonatomic) UIView * breakLineView;

///顶部集合视图和下面的滚动视图中间的视图 默认创建该视图，并且底部提供一个分割线
@property (strong ,nonatomic) UIView *centerView;

@property (assign, nonatomic) CGFloat  centerViewHeight;

///中部视图 底部分割线
@property (strong ,nonatomic) UIView *centerViewBottomLine;

///下面一个滚动视图 嵌套多个tableview
@property (strong,nonatomic) UIScrollView * scrollView;

///字符串对应tableview
@property (strong,nonatomic) NSMutableDictionary<NSString *,__kindof UIView* > * viewMD;

#pragma mark - 初始化方法
+(instancetype)pageScrollViewWithFrame:(CGRect)frame titles:(NSArray *)titles;

#pragma mark - 公开方法
/**
 初始化集合视图的数据

 @param titles 标题数组
 */
-(void)setTitleModelMAWithTitles:(NSArray *)titles;

-(void)changeTitle:(NSString *)title forPageIndex:(NSUInteger )index;

/*
 加载当前选中title对应的tableview及其data
 */
-(void)autoLoadCurrentViewData;

/**
 加载对应index
 */
-(void)selectViewWithIndex:(NSUInteger)index;

/**
 添加索引页index对应的视图view

 @param view 当前页视图
 @param titleKey 为获取当前页设置的key 用于外部获取当前视图
 @param index 当前页索引值，用户内部获取当前视图 实际存储为view.tag = index;
 */
-(void)addPageView:(__kindof UIView *)view forKey:(NSString *)titleKey index:(NSUInteger)index;
@end
