//
//  ViewController.m
//  Mission Briefing
//
//  Created by Ben Gohlke on 1/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "MissionBriefingViewController.h"

@interface MissionBriefingViewController ()
{
    //used NSString *agentName and *agentPassword in order to test with my name to see if it works.
    NSString *agentName;
    NSString *agentPassword;
    //per David Johnson's help. see selfDestruct, fireTimer related code and password secure entry. credit to David Johnson
    NSTimer *selfDestructTimer;
    int selfDestructTimerCount;
    
}

@property (strong, nonatomic) IBOutlet UITextField *agentNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *agentPasswordTextField;
@property (strong, nonatomic) IBOutlet UILabel *greetingLabel;
@property (strong, nonatomic) IBOutlet UITextView *missionBriefingTextView;



- (IBAction)authenticateAgent:(UIButton *)sender;

@end

@implementation MissionBriefingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    agentName = @"heather summy";
    agentPassword = @"monchichi";
    selfDestructTimerCount = 5;

    //
    // 1. These three UI elements need to be emptied on launch
    //    Hint: there is a string literal that represents empty (H--use the common empty @"" for all three)
    //
    
    [self.agentNameTextField setText:@""];
    [self.agentPasswordTextField setSecureTextEntry:YES];
    self.greetingLabel.text = @"";
    self.missionBriefingTextView.text = @"";

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)authenticateAgent:(UIButton *)sender
{
    // This will cause the keyboard to dismiss when the authenticate button is tapped
    if ([self.agentNameTextField isFirstResponder])
    {
        [self.agentNameTextField resignFirstResponder];
    }
    
    //
    // 2. Check whether there is text in BOTH the name and password textfields. (Yes. *agentNameTextField and *agentPasswordTextField. Need to create a NSString to make sure both fields are required before processing. nsstring equality objective c compare with empty)
    //
    
    NSString *nameText = self.agentNameTextField.text;
    NSString *passwordText = self.agentPasswordTextField.text;
    //David Johnson helped me with combining the next line of code.
    if (([nameText isEqualToString:agentName])
        && ([passwordText isEqualToString:agentPassword]))
    {
        
        //
        // 3. The greetingLabel needs to be populated with the the string "Good evening, Agent #", where # is the last name of
        //    the agent logging in. The agent's full name is listed in the text field, but you need to pull out just the last
        //    name. Open the Apple Documentation and go to the page for NSString. There is a section in the left called "Dividing
        //    Strings". You should be able to find a method that allows you to break up a string using a delimiter. In our case,
        //    the delimiter would be a space character.
        //
        
        NSString *fullName = nameText;
        NSArray *components = [fullName componentsSeparatedByString:@" "];
        //H-do not need NSString *firstName = components[0]; code below in order to work, since i am only wanting the last name and therefor this will error out as 'unused'.
        //NSString *firstName = components[0];
        NSString *lastName = components[1];
        
        //NSArray *agentLastName = [agentNameTextField: @""];
        // Additional step(s) to remove only the last name (H--nsstring agent "%@, Last Name)
        
        //changed from [1] to last name since first name and last name were split up into Strings mentioned above, instead of an Array and separated by components.
        self.greetingLabel.text = [NSString stringWithFormat: @"Good morning, Agent %@", lastName];
        
        //
        // 4. The mission briefing textview needs to be populated with the briefing from HQ, but it must also include the last
        //    name of the agent that logged in. You will notice in the text a "%@" string after the word "Agent". This
        //    instructs the system to replace the "%@" with an actual value at runtime. Perhaps you could use the text in the
        //    textfield to get the agent's last name.
        //
        //    Set the textview text property to the paragraph in "MissionBriefing.txt", last name.
        //
      
        self.missionBriefingTextView.text = [NSString stringWithFormat: @"This mission will be an arduous one, fraught with peril. You will cover much strange and unfamiliar territory. Should you choose to accept this mission, Agent %@, you will certainly be disavowed, but you will be doing your country a great service. This message will self destruct in 5 seconds.", lastName];
        
        //
        // 5. The view's background color needs to switch to green to indicate a successful login by the agent.
        //
        //    The color's RGB value is Red: 0.585, Green: 0.78, Blue: 0.188 with an alpha of 1. There is a class method on the
        //    UIColor class that returns a color object with custom defined RGBA values. Open the documentation and look for a
        //    method on UIColor that can take red, green, blue and alpha values as arguments.
        //
        //    Once you have the color object, you should be able to set the view's background color to this object.
        //
        
        UIColor *authenticatedBackgroundColor = [UIColor greenColor];
        // Additional step to set the above color object to self.view's background color
        self.view.backgroundColor = authenticatedBackgroundColor;
//        self.view.backgroundColor = [UIColor colorWithRed:0.585 green:0.78 blue:0.188 alpha:1];
        
        selfDestructTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(fireTimer:) userInfo:nil repeats:true];
    }
  else
    {
        //
        // 6. The view's background color needs to switch to red to indicate a failed login by the agent.
        //
        //    The color's RGB value is Red: 0.78, Green: 0.188, Blue: 0.188 with an alpha of 1. There is a class method on the
        //    UIColor class that returns a color object with custom defined RGBA values. Open the documentation and look for a
        //    method on UIColor that can take red, green, blue and alpha values as arguments.
        //
        //    Once you have the color object, you should be able to set the view's background color to this object.
        //
        //UIColor *accessDeniedBackgroundColor = [UIColor redColor];
        // Additional step to set the above color object to self.view's background color
        self.view.backgroundColor = [UIColor colorWithRed:0.78 green:0.188 blue:0.188 alpha:1];
    }
    
}

- (void)fireTimer:(NSTimer *)timer {
    if (selfDestructTimerCount == 0) {
        [timer invalidate];
        @throw NSInternalInconsistencyException;
    }
    NSArray *components = [agentName componentsSeparatedByString:@" "];
    NSString *lastName = components[1];
    
    self.missionBriefingTextView.text = [NSString stringWithFormat: @"This mission will be an arduous one, fraught with peril. You will cover much strange and unfamiliar territory. Should you choose to accept this mission, Agent %@, you will certainly be disavowed, but you will be doing your country a great service. This message will self destruct in %d seconds.", lastName, selfDestructTimerCount];
    
    selfDestructTimerCount--;
}

@end
