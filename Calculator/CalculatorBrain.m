//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Keith Wedinger on 12/21/12.
//  Copyright (c) 2012 Keith Wedinger. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack {
    if ( _operandStack == nil ) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void)pushOperand:(double)operand {
    NSLog( @"Adding %f to operand stack", operand );
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)popOperand {
    NSNumber *operandObj = [self.operandStack lastObject];
    if ( operandObj != nil ) {
        [self.operandStack removeLastObject];
    }
    NSLog( @"Popping %@ off operand stack", operandObj );
    return [operandObj doubleValue];
}

- (double)performOperation:(NSString *)operation {
    NSLog( @"Performing operation '%@'", operation );
    double result = 0;
    if ( [operation isEqualToString:@"+"] ) {
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        result = [self popOperand] - [self popOperand];
    } else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"/"]) {
        result = [self popOperand] / [self popOperand];
    }
    [self pushOperand:result];
    return result;
}

- (void)clearOperandStack {
    NSLog( @"Removing all operands from the stack" );
    [self.operandStack removeAllObjects];
}

@end
