//
//  ViewController.m
//  testtest
//
//  Created by 诸葛渊 on 2017/1/5.
//  Copyright © 2017年 诸葛渊. All rights reserved.
//

#import "ViewController.h"
#define RGBA(r,g,b,a)           [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)            RGBA(r,g,b,1.0f)
// 当前屏幕宽度

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

// 当前屏幕高度

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIWebView *_webView;
    
    //记录滚轮是否滑动
    NSString *guildStr;
    NSString *selectStr;
    NSMutableArray *dataMutArray;
    UIButton *bgButton;
    
    
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
//    _webView.delegate = self;
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"pdf"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [_webView loadRequest:request];
//    [self.view addSubview:_webView];
    
    dataMutArray = [NSMutableArray arrayWithArray:@[@"学生",@"工人",@"教师",@"保安",@"医生",@"护士",@"服务员"]];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(80, 140, 70, 30)];
    [button setTitle:@"弹出框" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark - 弹框
- (void)buttonAction{
    guildStr = @"0";
    bgButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    bgButton.backgroundColor = RGBA(0, 0, 0, 0.3);
    [bgButton addTarget:self action:@selector(bgButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgButton];
    
    UIView *cycanView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 180, kScreenWidth, 40)];
    cycanView.backgroundColor = [UIColor orangeColor];
    [bgButton addSubview:cycanView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, cycanView.bounds.size.height)];
    titleLabel.text = @"选择身份";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [cycanView addSubview:titleLabel];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, cycanView.bounds.size.height)];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [cancelButton addTarget:self action:@selector(bgButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cycanView addSubview:cancelButton];
    
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 48, 0, 48, cycanView.bounds.size.height)];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cycanView addSubview:confirmButton];
    
    UIPickerView *selectPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 140, kScreenWidth, 140)];
    // 显示选中框
    selectPickerView.showsSelectionIndicator = YES;
    selectPickerView.backgroundColor = [UIColor whiteColor];
    selectPickerView.delegate = self;
    selectPickerView.dataSource = self;
    selectPickerView.autoresizingMask = UIViewAutoresizingNone;
    [bgButton addSubview:selectPickerView];
}

#pragma mark - 隐藏弹框
- (void)bgButtonAction:(UIButton *)sender{
    [bgButton removeFromSuperview];
}
#pragma mark - 弹框确定按钮
- (void)confirmButtonAction:(UIButton *)sender{
    if ([guildStr isEqualToString:@"0"]) {
        selectStr = [NSString stringWithFormat:@"%@",dataMutArray[0]];
    }
    [bgButton removeFromSuperview];
}
#pragma mark - UIPickerView代理方法
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return dataMutArray.count;
}
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return kScreenWidth;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    guildStr = @"1";
    selectStr = [NSString stringWithFormat:@"%@",[dataMutArray objectAtIndex:row]];
    NSLog(@"selectStr:%@",selectStr);
}
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [dataMutArray objectAtIndex:row];
}

//重写方法,改变字体大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = [UIFont systemFontOfSize:17];
        pickerLabel.textColor = [UIColor blackColor];
        pickerLabel.textAlignment = 1;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    //在该代理方法里添加以下两行代码删掉上下的黑线
//    [[pickerView.subviews objectAtIndex:1] setHidden:YES];
//    [[pickerView.subviews objectAtIndex:2] setHidden:YES];
    
//    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(85, 55, kScreenWidth - 85 * 2, 1.8)];
//    lineView1.backgroundColor = RGB(245, 245, 245);
//    [pickerView addSubview:lineView1];
//    
//    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(85, 82, kScreenWidth - 85 * 2, 1.8)];
//    lineView2.backgroundColor = RGB(245, 245, 245);
//    [pickerView addSubview:lineView2];
    
    return pickerLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
