//
//  ViewController.m
//  UIViewGeometry
//
//  Created by Admin on 31.08.16.
//  Copyright © 2016 Ehlakov Victor. All rights reserved.
//
/*
 Ученик
 
 1. В цикле создавайте квадратные UIView с черным фоном и расположите их в виде шахматной доски
 2. доска должна иметь столько клеток, как и настоящая шахматная
 
 Студент
 
 3. Доска должна быть вписана в максимально возможный квадрат, т.е. либо бока, либо верх или низ должны касаться границ экрана
 4. Применяя соответствующие маски сделайте так, чтобы когда устройство меняет ориентацию, то все клетки растягивались соответственно и ничего не вылетало за пределы экрана.
 
 Мастер
 5. При повороте устройства все черные клетки должны менять цвет :)
 6.Сделайте так, чтобы доска при поворотах всегда строго находилась по центру
 
 Супермен
 8. Поставьте белые и красные шашки (квадратные вьюхи) так как они стоят на доске. Они должны быть сабвьюхами главной вьюхи (у них и у клеток один супервью)
 9. После каждого переворота шашки должны быть перетасованы используя соответствующие методы иерархии UIView
 */
#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic,strong) UIView *viewMain;
@property (nonatomic,assign) NSInteger width;
@property (nonatomic,assign) NSInteger height;
@property (nonatomic,assign) CGRect rect;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.color = [UIColor blackColor];
    self.array = [NSMutableArray array];
    
    self.width = self.view.bounds.size.width;
    self.height = self.view.bounds.size.height;
    self.rect = CGRectMake([self comparisonForViewSides:self.view]*0.1, [self requiredYCoordinate:self.view], [self comparisonForViewSides:self.view]*0.8, [self comparisonForViewSides:self.view]*0.8);

    self.viewMain = [[UIView alloc]initWithFrame:self.rect];
    self.viewMain.autoresizingMask =   UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin  | UIViewAutoresizingFlexibleBottomMargin;

    self.viewMain.center = self.view.center;
    [self.view addSubview:self.viewMain];
    self.size  = self.width / 10;

    for (int coefficientVertical = 0; coefficientVertical < 8; ) {
        for (int coefficientHorizontal = 0; coefficientHorizontal < 8;) {
        
            UIView *viewFirst = [[UIView alloc]initWithFrame:CGRectMake(self.size * coefficientHorizontal, self.size+self.size * coefficientVertical, self.size, self.size)];
            [self orientationView:viewFirst andColor:self.color];
            
            UIView *viewSecond = [[UIView alloc]initWithFrame:CGRectMake(self.size * (coefficientHorizontal+1), self.size+self.size * (coefficientVertical+1), self.size, self.size)];
            [self orientationView:viewSecond andColor:self.color];
            
            coefficientHorizontal +=2;
        }
        coefficientVertical +=2;
    }

    // Do any additional setup after loading the view, typically from a nib.
}

-(void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    self.viewMain.center = self.view.center;
    [self returnRandomColor];
    for (UIView *anyView in self.array) {
        anyView.backgroundColor = self.color;
    }
}
-(CGFloat) requiredYCoordinate: (UIView*) view {
    if (view.bounds.size.height > view.bounds.size.width) {
        return (view.bounds.size.height - view.bounds.size.width)/2;
    }else{
        return (view.bounds.size.width - view.bounds.size.height)/2;
    }
}
-(CGFloat) comparisonForViewSides: (UIView*) view {
    if (view.bounds.size.height > view.bounds.size.width) {
        return view.bounds.size.width;
    }else{
        return view.bounds.size.height;
    }

}
-(UIColor*) returnRandomColor{
    int red = arc4random() % 256;
    int green = arc4random() % 256;
    int blue = arc4random() % 256;
    self.color = [UIColor colorWithRed:red / 256.0f green:green / 256.0f blue:blue / 256.0f alpha:1.0];
    return self.color;
}

-(void) orientationView: (UIView*) view andColor: (UIColor*) color{
    view.backgroundColor = color;
    [self.array addObject:view];
    [self.viewMain addSubview:view];
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
