//
//  ViewController.m
//  KVOControllerDemo
//
//  Created by Keita on 8/11/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

#import "ViewController.h"
#import <KVOController/FBKVOController.h>
#import "Person.h"

static void *person1Context = &person1Context;

@interface ViewController ()

@property (nonatomic, strong) FBKVOController *KVOController;
@property (nonatomic, strong) Person *person1;
@property (nonatomic, strong) Person *person2;
@property (nonatomic, strong) Person *person3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.person1 = [[Person alloc] init];
    self.person2 = [[Person alloc] init];
    self.person3 = [[Person alloc] init];
    
    [self actionsWithKVOController];
    
    [self changeNames];
    
    NSLog(@"viewDidLoad got called.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeNames {
    self.person1.name = @"Thom Yorke";
    self.person2.name = @"Jonny Greenwood";
    self.person3.name = @"Ed O'brien";
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:(NSCoder *)aDecoder];
    
    if (self) {
        _KVOController = [FBKVOController controllerWithObserver:self];
        NSLog(@"initWithCoder got called.");
    }
    
    return self;
}

- (void)actionsWithKVOController {
    
    [_KVOController observe:self.person1 keyPath:@"name" options:NSKeyValueObservingOptionNew context:person1Context];
    
    [_KVOController observe:self.person2 keyPath:@"name" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
        // Respond to Changes
        NSLog(@"block got called.");
        NSString *changedName = change[NSKeyValueChangeNewKey];
        NSLog(@"new name: %@", changedName);
    }];
    
    [_KVOController observe:self.person3 keyPath:@"name" options:NSKeyValueObservingOptionNew action:@selector(nameDidChange:)];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == person1Context) {
        if ([keyPath isEqualToString:@"name"]) {
            NSLog(@"observeValueForKeyPath method got called.");
            NSLog(@"%@", change[NSKeyValueChangeNewKey]);
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)nameDidChange: (NSDictionary *)change {
    NSLog(@"nameDidChange method got called.");
    NSLog(@"%@", change[NSKeyValueChangeNewKey]);
}

- (void)unobserveWithKVOController {
    [_KVOController unobserveAll];
}

@end
