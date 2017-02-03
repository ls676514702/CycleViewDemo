//
//  ViewController.m
//  CycleImageDemo
//
//  Created by 梁森 on 17/2/2.
//  Copyright © 2017年 Personal Project. All rights reserved.
//

#import "ViewController.h"
#import "LSCycleView.h"
@interface ViewController ()

@end

@implementation ViewController{
//    保存数据模型
    NSArray<NSURL *> *_urls;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
    LSCycleView *lsc = [[LSCycleView alloc] initWithUrls:_urls];
    lsc.frame = CGRectMake(10, 10, 300, 200);
    [self.view addSubview:lsc];
    
}
//加载数据
- (void)loadData{
    NSMutableArray *Marray = [NSMutableArray array];
    for (int i=0; i<3; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%02zd.jpg",i+1];
       NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        [Marray addObject:url];
    }
    _urls = Marray.copy;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
