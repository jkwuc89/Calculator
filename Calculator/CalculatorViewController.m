//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Keith Wedinger on 12/20/12.
//  Copyright (c) 2012 Keith Wedinger. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userEnteringNumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display = _display;
@synthesize userEnteringNumber = _userEnteringNumber;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    if ( _brain == nil ) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    NSLog( @"Digit pressed = %@", digit );
    double currentDisplayValue = [self.display.text doubleValue];
    if ( currentDisplayValue != 0 ||
         ( currentDisplayValue == 0 && [digit doubleValue] != 0 ) ) {
        if ( self.userEnteringNumber ) {
            self.display.text = [self.display.text stringByAppendingString:digit];
        } else {
            self.userEnteringNumber = true;
            self.display.text = digit;
        }
    }
}

- (IBAction)operationPressed:(UIButton *)sender {
    NSLog( @"Operation pressed = %@", sender.currentTitle );
    // Prevent user from having to tap enter twice to push 2 operands
    if ( self.userEnteringNumber ) {
        [self enterPressed];
    }
    double result = [self.brain performOperation:sender.currentTitle];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (IBAction)enterPressed {
    NSLog( @"Enter pressed" );
    [self.brain pushOperand:[self.display.text doubleValue]];
     self.userEnteringNumber = false;
}


- (IBAction)allClearPressed {
    NSLog( @"All Clear pressed" );
    self.display.text = @"0";
    [self.brain clearOperandStack];
}
@end
