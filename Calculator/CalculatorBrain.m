//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Keith Wedinger on 12/21/12.
//  Copyright (c) 2012 Keith Wedinger. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack {
    if ( _programStack == nil ) {
        _programStack = [[NSMutableArray alloc] init];
    }
    return _programStack;
}

- (void)pushOperand:(double)operand {
    NSLog( @"Adding %f to operand stack", operand );
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}

- (double)performOperation:(NSString *)operation {
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.programStack];
}

// Read only program property only needs a getter
// Return a snapshot of the program stack
- (id)program {
    // Returns a immutable copy of the program stack
    return [self.programStack copy];
}

+ (NSString *)getDescriptionOfProgram:(id)program {
    // TODO: Implmenet later
    return nil;
}

// Recursively run this method until stack is empty to complete
// the operations on the stack
+ (double)popOperandOffStack:(NSMutableArray *)stack {
    double result = 0;
    
    // Use id because top of stack could be an operand or an operation
    // This also checks for an empty stack.
    id topOfStack = [stack lastObject];
    if ( topOfStack ) {
        [stack removeLastObject];
    }

    // We only deal with NSNumber's and NSString's.
    // Anything else in the stack will return 0.
    if ( [topOfStack isKindOfClass:[NSNumber class]] ) {
        result = [topOfStack doubleValue];
    } else if ( [topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        NSLog( @"Performing operation '%@'", operation );
        if ( [operation isEqualToString:@"+"] ) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"-"]) {
            result = [self popOperandOffStack:stack] - [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"*"]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"/"]) {
            result = [self popOperandOffStack:stack] / [self popOperandOffStack:stack];
        } else if ([operation isEqualToString:@"x²"]) {
            double operand = [self popOperandOffStack:stack];
            result = operand * operand;
        } else if ([operation isEqualToString:@"√x"]) {
            result = sqrt( [self popOperandOffStack:stack] );
        }
    }
    
    return result;
}

+ (double)runProgram:(id)program {
    NSMutableArray *stack;
    // Check the program arg
    if ( [program isKindOfClass:[NSArray class]] ) {
        // We need a mutable copy of the program
        stack = [program mutableCopy];
    }
    return [self popOperandOffStack:stack];
}

- (void)clearOperandStack {
    NSLog( @"Removing %u items from the stack", self.programStack.count );
    [self.programStack removeAllObjects];
}

@end
