//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Keith Wedinger on 12/21/12.
//  Copyright (c) 2012 Keith Wedinger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clearOperandStack;

@end
