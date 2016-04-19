//
//  ViewController.m
//  动态下载字体
//
//  Created by 杨卢青 on 16/4/11.
//  Copyright © 2016年 杨卢青. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>

@interface ViewController ()

@property (strong, nonatomic) NSString *errorMessage;

@end

@implementation ViewController

- (void)asynchronouslySetFontName:(NSString *)fontName
{
    UIFont* aFont = [UIFont fontWithName:fontName size:12.];
    // If the font is already downloaded
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        // Go ahead and display the sample text.
        NSUInteger sampleIndex = [_fontNames indexOfObject:fontName];
        _fTextView.text = [_fontSamples objectAtIndex:sampleIndex];
        _fTextView.font = [UIFont fontWithName:fontName size:24.];
        return;
    }
    
    // Create a dictionary with the font's PostScript name.
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];
    
    // Create a new font descriptor reference from the attributes dictionary.
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    
    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)desc];
    CFRelease(desc);
    
    __block BOOL errorDuringDownload = NO;
    
    // Start processing the font descriptor..
    // This function returns immediately, but can potentially take long time to process.
    // The progress is notified via the callback block of CTFontDescriptorProgressHandler type.
    // See CTFontDescriptor.h for the list of progress states and keys for progressParameter dictionary.
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler( (__bridge CFArrayRef)descs, NULL,  ^(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {
        
        //NSLog( @"state %d - %@", state, progressParameter);
        
        double progressValue = [[(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingPercentage] doubleValue];
        
        if (state == kCTFontDescriptorMatchingDidBegin) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Show an activity indicator
                [_fActivityIndicatorView startAnimating];
                _fActivityIndicatorView.hidden = NO;
                
                // Show something in the text view to indicate that we are downloading
                _fTextView.text= [NSString stringWithFormat:@"Downloading %@", fontName];
                _fTextView.font = [UIFont systemFontOfSize:14.];
                
                NSLog(@"Begin Matching");
            });
        } else if (state == kCTFontDescriptorMatchingDidFinish) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Remove the activity indicator
                [_fActivityIndicatorView stopAnimating];
                _fActivityIndicatorView.hidden = YES;
                
                // Display the sample text for the newly downloaded font
                NSUInteger sampleIndex = [_fontNames indexOfObject:fontName];
                _fTextView.text = [_fontSamples objectAtIndex:sampleIndex];
                _fTextView.font = [UIFont fontWithName:fontName size:24.];
                
                // Log the font URL in the console
                CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)fontName, 0., NULL);
                CFStringRef fontURL = CTFontCopyAttribute(fontRef, kCTFontURLAttribute);
                NSLog(@"%@", (__bridge NSURL*)(fontURL));
                CFRelease(fontURL);
                CFRelease(fontRef);
                
                if (!errorDuringDownload) {
                    NSLog(@"%@ downloaded", fontName);
                }
            });
        } else if (state == kCTFontDescriptorMatchingWillBeginDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Show a progress bar
                _fProgressView.progress = 0.0;
                _fProgressView.hidden = NO;
                NSLog(@"Begin Downloading");
            });
        } else if (state == kCTFontDescriptorMatchingDidFinishDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Remove the progress bar
                _fProgressView.hidden = YES;
                NSLog(@"Finish downloading");
            });
        } else if (state == kCTFontDescriptorMatchingDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Use the progress bar to indicate the progress of the downloading
                [_fProgressView setProgress:progressValue / 100.0 animated:YES];
                NSLog(@"Downloading %.0f%% complete", progressValue);
            });
        } else if (state == kCTFontDescriptorMatchingDidFailWithError) {
            // An error has occurred.
            // Get the error message
            NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
            if (error != nil) {
                _errorMessage = [error description];
            } else {
                _errorMessage = @"ERROR MESSAGE IS NOT AVAILABLE!";
            }
            // Set our flag
            errorDuringDownload = YES;
            
            dispatch_async( dispatch_get_main_queue(), ^ {
                _fProgressView.hidden = YES;
                NSLog(@"Download error: %@", _errorMessage);
            });
        }
        
        return (bool)YES;
    });
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_fontNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    // Try to retrieve from the table view a now-unused cell with the given identifier.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // If no cell is available, create a new one using the given identifier.
    if (cell == nil) {
        // Use the default cell style.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    // Set up the cell.
    cell.textLabel.text = _fontNames[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self asynchronouslySetFontName:_fontNames[indexPath.row]];
    
    // Dismiss the keyboard in the text view if it is currently displayed
    if ([self.fTextView isFirstResponder])
        [self.fTextView resignFirstResponder];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fontNames = [[NSArray alloc] initWithObjects:
                      @"STXingkai-SC-Light",
                      @"DFWaWaSC-W5",
                      @"FZLTXHK--GBK1-0",
                      @"STLibian-SC-Regular",
                      @"LiHeiPro",
                      @"HiraginoSansGB-W3",
                      nil];
    self.fontSamples = [[NSArray alloc] initWithObjects:
                        @"汉体书写信息技术标准相",
                        @"容档案下载使用界面简单",
                        @"支援服务升级资讯专业制",
                        @"作创意空间快速无线上网",
                        @"兙兛兞兝兡兣嗧瓩糎",
                        @"㈠㈡㈢㈣㈤㈥㈦㈧㈨㈩",
                        nil];
}
@end
