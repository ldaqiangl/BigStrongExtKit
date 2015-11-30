//
//  ViewController.m
//  BigStrongExtKit
//
//  Created by 董富强 on 15/8/19.
//  Copyright (c) 2015年 董富强. All rights reserved.
//

#import "ViewController.h"
#import "BSExtKit.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorFromString_Ext:@"#EEEEEE"];
    
    /*1、SQLite数据库操作Demo */
    /*
    NSString *tableName = @"user_table";
    BSDatabaseOperation *store = [[BSDatabaseOperation alloc] initDBWithName:@"test.db"];
    [store createTableWithName:tableName];
    NSString *key = @"1";
    NSDictionary *user = @{@"id": @1, @"name": @"tangqiao", @"age": @30};
    [store putObject:user withId:key intoTable:tableName];
    
    NSDictionary *queryUser = [store getObjectById:key fromTable:tableName];
    NSLog(@"query data result: %@", queryUser);
     */
    
    
    /*2、UILabel autlayout操作*/
    /*
    self.label.text = @"women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子women dou shi害孩子";
     */
    
    
    /*3、keychain保存重要数据，如：设备唯一标识*/
    
    
    /*4、控制并发线程 */
    int data = 3;
    __block int mainData = 0;
    
    __block dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_queue_create("StudyBlocks", NULL);
    dispatch_async(queue, ^(void) {
        int sum = 0;
        for(int i = 0; i < 100; i++)
        {
            sum += data;
            
            NSLog(@" >> Sum: %d", sum);
        }
        
        dispatch_semaphore_signal(sem);

    });
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    for(int j=0;j<5;j++)
    {
        mainData++;
        NSLog(@">> Main Data: %d",mainData);
    }
    
//    dispatch_release(sem);
//    dispatch_release(queue);
//    
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    for (int i = 0; i < 100; i++)
//    {
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        dispatch_group_async(group, queue, ^{
//            NSLog(@"%i",i);
//            sleep(2);
//            dispatch_semaphore_signal(semaphore);
//        });
//    }
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
