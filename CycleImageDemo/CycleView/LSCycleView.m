//
//  LSCycleView.m
//  CycleImageDemo
//
//  Created by 梁森 on 17/2/2.
//  Copyright © 2017年 Personal Project. All rights reserved.
//

#import "LSCycleView.h"
#import "LSCollectionViewFlowLayout.h"
#import "LSCollectionViewCell.h"

@interface LSCycleView()<UICollectionViewDataSource,UICollectionViewDelegate>
@end
static NSString *const cellId = @"cellId";
@implementation LSCycleView{
    NSArray<NSURL *> *_urls;
    NSTimer *_timer;
    NSInteger _currentPage;
}
//初始化collectionView的方法
- (instancetype)initWithUrls:(NSArray *)urls
{
    self = [super initWithFrame:CGRectZero collectionViewLayout:[[LSCollectionViewFlowLayout alloc]init]];
    if (self) {
        _urls = urls;
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[LSCollectionViewCell class] forCellWithReuseIdentifier:cellId];
//        开启异步，保证主线程有其它操作的时候，先让其它操作完成之后在做此操作
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_urls.count inSection:0];
            [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        });
        [self setTimer];
        
    }
    return self;
}
//设置定时器
- (void)setTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    _timer = timer;
//    添加到runloop中，保证我们在做其它操作的时候不会影响到定时器
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
//移除定时器
- (void)removeTimer{
    [_timer invalidate];
    _timer = nil;
}
- (void)nextPage{
//    设置每一秒滚动至下一页
    _currentPage++;
    NSInteger page = _currentPage%_urls.count;
    CGFloat offsetX = page*self.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self setContentOffset:offset];
}

#pragma mark --数据源方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _urls.count*300;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSURL *url = _urls[indexPath.item%_urls.count];
    cell.url = url;
    return cell;
}

#pragma mark --代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.bounds.size.width;
    _currentPage = currentPage;
    if (currentPage==0 || currentPage == [self numberOfItemsInSection:0]-1) {
        if (currentPage==0) {
            currentPage = _urls.count;
        }else{
            currentPage = _urls.count-1;
        }
    }
    scrollView.contentOffset = CGPointMake(currentPage*scrollView.bounds.size.width, 0);
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //停止轮播图片，如果不停止的话，会一次性轮播多张图片
     [self removeTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setTimer];
}

@end
