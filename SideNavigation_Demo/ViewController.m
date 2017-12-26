//
//  ViewController.m
//  SideNavigation_Demo
//
//  Created by Derek on 25/12/17.
//  Copyright © 2017年 Derek. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

#define SC_HIGHT [UIScreen mainScreen].bounds.size.height
#define SC_WIDTH [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController




-(instancetype)init{
 
    self=[super init];
    
    if (self) {
        
       self.leftSlideNavView=[[UIView alloc]init];
       self.leftSlideNavViewClearPan=[[UIView alloc]init];
       //self.leftSlideNavDetailView=[[UIView alloc]init];
       self.rightSlideNavView=[[UIView alloc]init];
       self.leftBarBTN=[[UIButton alloc]init];

    }
    return  self;
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self setUI];
    [self setLeftSideView];
    [self clickToHideAndShow:self.leftBarBTN];
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self setUI];
    [self setLeftSideView];
    [self clickToHideAndShow:self.leftBarBTN];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self setUI];
    [self setLeftSideView];
    [self clickToHideAndShow:self.leftBarBTN];//
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self setUI];
    [self setLeftSideView];
    [self clickToHideAndShow:self.leftBarBTN];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //[self setUI];
    
    //[self setLeftSideView];
    
    [self setHomeUI];
}

-(void)setUI{
    
    self.title=@"侧滑姿势";
    
    self.view.backgroundColor=[UIColor blueColor];
    
    self.navigationController.navigationBar.frame=CGRectMake(0, 0, SC_WIDTH, 64);
    
    self.leftBarBTN=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.leftBarBTN setBackgroundImage:[UIImage imageNamed:@"playholder.png"] forState:UIControlStateNormal];
    //self.leftBarBTN.backgroundColor=[UIColor blackColor];
    [self.leftBarBTN setTitle:@"click" forState:UIControlStateNormal];
    [self.leftBarBTN addTarget:self action:@selector(clickToHideAndShow:) forControlEvents:UIControlEventTouchUpInside];
    self.leftBarBTN.tag=100;
    UIBarButtonItem * leftBTNItem=[[UIBarButtonItem alloc]initWithCustomView:self.leftBarBTN];
    
    self.navigationItem.leftBarButtonItem=leftBTNItem;


}
-(void)tapToSlide:(UITapGestureRecognizer *)sender{

    [self clickToHideAndShow:self.leftBarBTN];
}
- (void)handleSwipeFromLeft:(UISwipeGestureRecognizer *)recognizer{
        if(recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"swipe left");
            
            [self clickToHideAndShow:self.leftBarBTN];
    }
    
}
- (void)handleSwipeFromRight:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"swipe right");
        [self clickToHideAndShow:self.leftBarBTN];
    }
}
-(void)setLeftSideView{
    
    [self.leftSlideNavView removeFromSuperview];
    //[self.leftSlideNavDetailView removeFromSuperview];
    
    
    self.leftSlideNavView=[[UIView alloc]init];
    self.leftSlideNavView.clipsToBounds=YES;
    self.leftSlideNavView.frame=CGRectMake(-SC_WIDTH+60,0,SC_WIDTH,SC_HIGHT);
    self.leftSlideNavView.backgroundColor=[UIColor clearColor];

    self.leftSlideNavDetailView=[[UIView alloc]init];
    self.leftSlideNavDetailView.userInteractionEnabled=YES;
    self.leftSlideNavDetailView.clipsToBounds=YES;
    self.leftSlideNavDetailView.frame=CGRectMake(0,0,SC_WIDTH-60,SC_HIGHT);
    self.leftSlideNavDetailView.backgroundColor=[UIColor colorWithRed:41/255.0 green:47/255.0 blue:60/255.0 alpha:1];
    [self.leftSlideNavView addSubview:self.leftSlideNavDetailView];

    [self.view addSubview:self.leftSlideNavView];
    
    UIButton * mybutton=[[UIButton alloc]initWithFrame:CGRectMake(20, 84, 100, 50)];
    mybutton.userInteractionEnabled=YES;
    mybutton.backgroundColor=[UIColor redColor];
    [mybutton addTarget:self action:@selector(clickTopush:) forControlEvents:UIControlEventTouchUpInside];
    [self.leftSlideNavDetailView addSubview:mybutton];
    
    UITapGestureRecognizer * ButtonTapRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTopush:)];
    [mybutton addGestureRecognizer:ButtonTapRecognizer];
    
    self.leftSlideNavViewClearPan=[[UIView alloc]initWithFrame:CGRectMake(self.leftSlideNavDetailView.frame.size.width, 0, 60, SC_HIGHT)];
    self.leftSlideNavViewClearPan.backgroundColor=[UIColor clearColor];
    [self.leftSlideNavView addSubview:self.leftSlideNavViewClearPan];
    
    UISwipeGestureRecognizer * leftRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFromLeft:)];
    [leftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.leftSlideNavViewClearPan addGestureRecognizer:leftRecognizer];
    
    
    UISwipeGestureRecognizer * rightRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFromRight:)];
    [rightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.leftSlideNavViewClearPan addGestureRecognizer:rightRecognizer];
    
    
}


-(void)clickTopush:(UIButton *)sender{
    NSLog(@"clickTopush");
    DetailViewController * d=[DetailViewController new];
    [self.navigationController pushViewController:d animated:YES];
}
-(void)setHomeUI{
    
    
    self.homeIMportance=[[UIView alloc]init];
    self.homeIMportance.frame=CGRectMake(20, 84, SC_WIDTH-40, (SC_HIGHT-64-49-100)/4);
    self.homeIMportance.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.homeIMportance];
    
    self.homeAnnunciatorBoards=[[UIView alloc]init];
    self.homeAnnunciatorBoards.frame=CGRectMake(20, 84+(SC_HIGHT-64-49-100)/4 +20 , SC_WIDTH-40, (SC_HIGHT-64-49-100)/4);
    self.homeAnnunciatorBoards.backgroundColor=[UIColor yellowColor];
    [self.view addSubview:self.homeAnnunciatorBoards];
    
    self.homeActivity=[[UIView alloc]init];
    self.homeActivity.frame=CGRectMake(20, 84+(SC_HIGHT-64-49-100)/4 * 2 +20+20, SC_WIDTH-40, (SC_HIGHT-64-49-100)/4);
    self.homeActivity.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:self.homeActivity];
    
    self.homeNew=[[UIView alloc]init];
    self.homeNew.frame=CGRectMake(20, 84+(SC_HIGHT-64-49-100)/4 * 3 + 20+20+20, SC_WIDTH-40, (SC_HIGHT-64-49-100)/4);
    self.homeNew.backgroundColor=[UIColor blackColor];
    [self.view addSubview:self.homeNew];
    
}
-(void)clickToHideAndShow:(UIButton *)sender{

    
    sender.selected=!sender.selected;
    
    
    __weak typeof (self) weakSelf = self;
    
    if (sender.selected==NO) {
        
        //NSLog(@"点击了执行了这里");
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            weakSelf.navigationController.navigationBar.frame=CGRectMake(SC_WIDTH-60, 0, SC_WIDTH, 64);
            
            weakSelf.view.frame=CGRectMake(weakSelf.navigationController.navigationBar.frame.origin.x, 0, SC_WIDTH, SC_HIGHT);
            
            weakSelf.leftSlideNavView.frame=CGRectMake(-SC_WIDTH+60, 0, SC_WIDTH, SC_HIGHT);
            
            NSLog(@"点击了执行了这里");
        }];

        
    }else{
    
        NSLog(@"点击了执行了那里");
        
        [UIView animateWithDuration:0.5 animations:^{
            
            weakSelf.leftSlideNavView.frame=CGRectMake(-SC_WIDTH+60, 0, SC_WIDTH, SC_HIGHT);
            weakSelf.leftSlideNavView.backgroundColor=[UIColor clearColor];
            //self.navigationController.navigationBar.hidden=YES;
            weakSelf.navigationController.navigationBar.frame=CGRectMake(0, 0, SC_WIDTH, 64);
            weakSelf.view.frame=CGRectMake(0, 0, SC_WIDTH, SC_HIGHT);
            
            
        }];

    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
