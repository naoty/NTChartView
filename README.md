# NTChartView

NTChartView is an easily charting library for iOS.

## Requirements

- iOS 5.0 or later
- Xcode 4.4 or later

## Usage

### Line chart

```objc
- (void)viewDidLoad
{
    NTLineChartView *lineChartView = [[NTLineChartView alloc] initWithFrame:self.view.bounds];
    lineChartView.dataSource = self;
    [self.view addSubview:lineChartView];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.lineChartView refreshWithFrame:self.view.bounds];
}

#pragma mark - NTLineChartViewDataSource

- (NSInteger)numberOfLinesInLineChartView:(NTLineChartView *)lineChartView
{
    return 2;
}

- (NSArray *)lineChartView:(NTLineChartView *)lineChartView dataForLineAtIndex(NSInteger)index
{
    if (index == 0) {
        return @[@[@1, @20], @[@2, @10], @[@3, @50], @[@4, @80]];
    } else {
        return @[@[@1, @50], @[@2, @60], @[@3, @30], @[@4, @40]];
    }
}
```
