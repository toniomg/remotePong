//
//  MainViewController.m
//  remotePong
//
//  Created by Antonio MG on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () {
@private
    int myDirection;
    int ballSpeed;
    
}

-(void)createNet;

@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;
@property (strong, nonatomic) RPSimpleSprite *ball; 
@property (strong, nonatomic) RPSimpleSprite *barOne; 
@property (strong, nonatomic) NSArray *middleNet; 

@end


typedef struct {
    int x;
    int y;
    
} vectorDic;


@implementation MainViewController

@synthesize context = _context;
@synthesize effect = _effect;
@synthesize ball = _ball;
@synthesize barOne = _barOne;
@synthesize middleNet = middleNet;

#define DIRECTION_UP_RIGHT  1
#define DIRECTION_UP_LEFT 2
#define DIRECTION_DOWN_RIGHT 3
#define DIRECTION_DOWN_LEFT 4

#define VECTOR_UP_RIGHT GLKVector2Make(1, 1)
#define VECTOR_UP_LEFT GLKVector2Make(-1, 1)
#define VECTOR_DOWN_RIGHT GLKVector2Make(1, -1)
#define VECTOR_DOWN_LEFT GLKVector2Make(-1, -1)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Open GL Methods

- (void)setupGL {
    
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    [EAGLContext setCurrentContext:self.context];
    
    CGRect totalFrame = self.view.frame;
    
    self.effect = [[GLKBaseEffect alloc] init];
    
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, totalFrame.size.width, 0, totalFrame.size.height, -1, 1);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    CGPoint startPosition = CGPointMake(100, 100);
    
    //Init the ball
    self.ball = [[RPSimpleSprite alloc] initWithSize:CGSizeMake(20, 20) origin:startPosition effect:self.effect];
    
    //Init the first bar
    int barWidth = 20;
    int barHeight = 80;
    int barY = 40;
    
    self.barOne =  [[RPSimpleSprite alloc] initWithSize:CGSizeMake(barHeight, barWidth) origin:CGPointMake(totalFrame.size.width/2 - barHeight/2, barY) effect:self.effect];
    
    //Create the middle net:
    [self createNet];

    myDirection = DIRECTION_DOWN_RIGHT;
    
    ballSpeed = 6;

}

-(void)createNet{
    
    CGRect totalFrame = self.view.frame;
    
    int netWidth = 10;
    int netHeight = 40;
    
    RPSimpleSprite *middleNet1 = [[RPSimpleSprite alloc] initWithSize:CGSizeMake(netHeight, netWidth) origin:CGPointMake(-10, totalFrame.size.height - netWidth) effect:self.effect];
    RPSimpleSprite *middleNet2 = [[RPSimpleSprite alloc] initWithSize:CGSizeMake(netHeight, netWidth) origin:CGPointMake(50, totalFrame.size.height - netWidth) effect:self.effect];
    RPSimpleSprite *middleNet3 = [[RPSimpleSprite alloc] initWithSize:CGSizeMake(netHeight, netWidth) origin:CGPointMake(110, totalFrame.size.height - netWidth) effect:self.effect];
    RPSimpleSprite *middleNet4 = [[RPSimpleSprite alloc] initWithSize:CGSizeMake(netHeight, netWidth) origin:CGPointMake(170, totalFrame.size.height - netWidth) effect:self.effect];
    RPSimpleSprite *middleNet5 = [[RPSimpleSprite alloc] initWithSize:CGSizeMake(netHeight, netWidth) origin:CGPointMake(230, totalFrame.size.height - netWidth) effect:self.effect];
    RPSimpleSprite *middleNet6 = [[RPSimpleSprite alloc] initWithSize:CGSizeMake(netHeight, netWidth) origin:CGPointMake(290, totalFrame.size.height - netWidth) effect:self.effect];
    
    middleNet = [[NSArray alloc] initWithObjects:middleNet1, middleNet2, middleNet3, middleNet4 , middleNet5, middleNet6, nil];
    
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationIsPortrait(interfaceOrientation));
}

#pragma mark - GLKView and GLKViewController delegate methods


- (void)update{
    
    
    GLKVector2 position = self.ball.position; 
    GLKVector2 positionBar = self.barOne.position;
    
    //NSLog(@"%f", position.x + self.ball.totalSize.width);
    
    if (position.x + self.ball.totalSize.width >= 320) {
        
        if (myDirection == DIRECTION_UP_RIGHT)
            myDirection = DIRECTION_UP_LEFT;
        
        else if (myDirection == DIRECTION_DOWN_RIGHT)
            myDirection = DIRECTION_DOWN_LEFT;
        
        //ballSpeed++;
        
    }
    else if (position.x <= 0){
        
        if (myDirection == DIRECTION_DOWN_LEFT)
            myDirection = DIRECTION_DOWN_RIGHT;
        
        else if (myDirection == DIRECTION_UP_LEFT)
            myDirection = DIRECTION_UP_RIGHT;
        
        //ballSpeed++;
        
    }
    else if (position.y <= 0){
        
        if (myDirection == DIRECTION_DOWN_LEFT)
            myDirection = DIRECTION_UP_LEFT;
        else if (myDirection == DIRECTION_DOWN_RIGHT)
            myDirection = DIRECTION_UP_RIGHT;
        
        //ballSpeed++;
    }
    else if (position.y + self.ball.totalSize.height >= 480) {
        
        if (myDirection == DIRECTION_UP_RIGHT)
            myDirection = DIRECTION_DOWN_RIGHT;
    
        else if (myDirection == DIRECTION_UP_LEFT)
            myDirection = DIRECTION_DOWN_LEFT;
    
        //ballSpeed++;
    }
    
    //Check if touches the bar!
    else if (position.y -self.ball.totalSize.height < positionBar.y && position.x + self.ball.totalSize.width > positionBar.x && position.x < self.barOne.totalSize.width + positionBar.x){
        
        if (myDirection == DIRECTION_DOWN_RIGHT)
            myDirection = DIRECTION_UP_RIGHT;
        else if (myDirection == DIRECTION_DOWN_LEFT)
            myDirection = DIRECTION_UP_LEFT;
        
    }
    
    GLKVector2 curMove;
    
    if (myDirection == DIRECTION_UP_RIGHT) {
        curMove = GLKVector2MultiplyScalar(VECTOR_UP_RIGHT, ballSpeed);
    }
    
    else if (myDirection == DIRECTION_UP_LEFT){
        curMove = GLKVector2MultiplyScalar(VECTOR_UP_LEFT, ballSpeed);
    }
    else if (myDirection == DIRECTION_DOWN_LEFT) {
        curMove = GLKVector2MultiplyScalar(VECTOR_DOWN_LEFT, ballSpeed);
    }
    
    else if (myDirection == DIRECTION_DOWN_RIGHT){
        curMove = GLKVector2MultiplyScalar(VECTOR_DOWN_RIGHT, ballSpeed);
    }
    
    
    [self.ball update:curMove];
    
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.0f, 0.0f, 0.0f, 0.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    
    [self.ball render];
    [self.barOne render];
    
    for (int i = 0; i < [middleNet count] ; i++)
    {
        [[middleNet objectAtIndex:i] render];
    }

}


#pragma mark Touch Methods

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGPoint movedTouch = [[touches anyObject] locationInView: self.view];
    
    
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) 
    {
        CGFloat scale = [[UIScreen mainScreen] scale];
        
        float newPositionX = movedTouch.x;
        if (scale > 1.0) 
        {
            newPositionX = newPositionX/2;
        }
    }
    
    self.barOne.position = GLKVector2Make(movedTouch.x - self.barOne.totalSize.width/2, self.barOne.position.y);
    
    //NSLog(@"POS: %f", self.barOne.position.x);
    
    
}


@end
