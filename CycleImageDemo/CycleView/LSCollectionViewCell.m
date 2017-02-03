//
//  LSCollectionViewCell.m
//  CycleImageDemo
//
//  Created by 梁森 on 17/2/3.
//  Copyright © 2017年 Personal Project. All rights reserved.
//

#import "LSCollectionViewCell.h"

@implementation LSCollectionViewCell{
    UIImageView *_iconImage;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:self.bounds];
        _iconImage = iconImage;
        [self addSubview:iconImage];
    }
    return self;
}
- (void)setUrl:(NSURL *)url{
    _url = url;
//    获取二进制数据
    NSData *data = [NSData dataWithContentsOfURL:url];
//    将二进制数据转换为图片
    _iconImage.image = [UIImage imageWithData:data];
}
@end
