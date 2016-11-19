//
//  HXTPictureLoopView.m
//  图片轮播
//
//  Created by mac on 16/8/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HXTPictureLoopView.h"
#import "HXTPictureLoopFlowLayout.h"
#import "HXTPictureLoopCell.h"

static NSString * const pictureLoopCellIdentifier = @"pictureLoopCellIdentifier";
const NSInteger kImageSectionCount  = 10;
//const NSInteger kImageItemCount     = 5;

@interface HXTPictureLoopView ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>
{
    UICollectionView *_collectionView;
    UIPageControl    *_pageControl;
    NSTimer          *_timer_2s;
    NSInteger        _kImageItemCount;
}
@end

@implementation HXTPictureLoopView

#define debug 0

+ (instancetype)pictureLoopViewWithImage:(NSArray *)imageArray
{
    return [[self alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 200) image:imageArray];
}

- (instancetype)initWithFrame:(CGRect)frame image:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSAssert(imageArray.count > 0, @"The picture can't be nil!");
        _kImageItemCount = imageArray.count;
        _pictureImageArray = imageArray;
        [self setupUI];
        [self addTimer];
    }
    return self;
}

- (void)setupUI
{
    if (debug == 1)
    {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
    }

    // 配置UICollectionView
    HXTPictureLoopFlowLayout *pictureLoopFlowLayout = [[HXTPictureLoopFlowLayout alloc]init];
    pictureLoopFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:pictureLoopFlowLayout];
    _collectionView = collectionView;
    [self addSubview:collectionView];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    // 注册cell
    [collectionView registerClass:[HXTPictureLoopCell class] forCellWithReuseIdentifier:pictureLoopCellIdentifier];
    
    // 让collectionView滚动到中间那一组
    NSIndexPath *middleIndexPath = [NSIndexPath indexPathForItem:0 inSection:kImageSectionCount / 2];
    [collectionView scrollToItemAtIndexPath:middleIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    // 加载pageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    _pageControl = pageControl;
    pageControl.numberOfPages = _kImageItemCount;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    [self addSubview:pageControl];
    
    // 设置pageControl的约束
    pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *pageControlCenterX = [NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *pageControlY = [NSLayoutConstraint constraintWithItem:pageControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self addConstraints:@[pageControlCenterX,pageControlY]];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (debug == 1)
    {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
        NSLog(@"CollectionView section number is:%zd", kImageSectionCount);
    }

    return kImageSectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (debug == 1)
    {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
        NSLog(@"CollectionView item number is:%zd", _kImageItemCount);
    }
    return _kImageItemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HXTPictureLoopCell *pictureCell = [collectionView dequeueReusableCellWithReuseIdentifier:pictureLoopCellIdentifier forIndexPath:indexPath];
//    pictureCell.indexPath = indexPath;
    pictureCell.pictureImage = self.pictureImageArray[indexPath.item];
    return pictureCell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger currentPage = (scrollView.contentOffset.x / scrollView.bounds.size.width)+0.499;
    // 获取当前的item
    NSInteger currentSection = currentPage / _kImageItemCount;
    NSInteger currentItem = currentPage % _kImageItemCount;
    //如果当前已经在中间的组，则直接返回
    if (currentSection == kImageSectionCount / 2) {
        return;
    }
    // collectionView滚动到中间一组
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForItem:currentItem inSection:kImageSectionCount / 2];
    [_collectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    if (debug == 1)
    {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
        NSLog(@"currentPage:%zd, currentSection:%zd, currentItem:%zd", currentPage, currentSection, currentItem);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger currentPage = (scrollView.contentOffset.x / scrollView.bounds.size.width)+0.499;
    _pageControl.currentPage = currentPage % _kImageItemCount;;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _timer_2s.fireDate = [NSDate distantFuture];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _timer_2s.fireDate = [NSDate dateWithTimeIntervalSinceNow:3.0];
}

- (void)addTimer
{
    _timer_2s = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer_2s forMode:NSRunLoopCommonModes];
}

// 自动跳转下一页
- (void)timerFireMethod:(NSTimer *)timer
{
    NSInteger currentPage = _pageControl.currentPage;
    NSInteger currentSection = kImageSectionCount / 2;
    
    if (currentPage == (_kImageItemCount - 1))
    {
        currentPage = 0;
        currentSection += 1;
    }
    else
    {
        currentPage++;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentPage inSection:currentSection];
    [self scrollViewDidEndDecelerating:_collectionView];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)setPictureImageArray:(NSArray *)pictureImageArray
{
    _pictureImageArray = pictureImageArray;
    NSAssert(pictureImageArray.count > 0, @"The picture can't be nil!");
    _kImageItemCount = pictureImageArray.count;
    
    if (debug == 1)
    {
        NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
        NSLog(@"The picture array count is: %zd", pictureImageArray.count);
    }
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    // 关闭定时器
    [_timer_2s invalidate];
}

@end
