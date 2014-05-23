CUSLayout
=========
CUSLayout for iOS managed positioning mechanism, the iOS SDK provides absolute positioning is very inconvenient to use, in addition to the emergence of 4-inch screen of the iPhone and iPad to make iOS developer need to spend more time in the layout, however iOS6.0 AutoLayout the mechanism is disappointing, I refer to Android, SWT, Swing layout mechanism, the preparation of for iOS CUSLayout, use CUSLayout has the following advantages:<br>1.Simplify coding, you do not need to take into account the pixel level, only for regional programming, which greatly improves the efficiency of programming<br>2.Good readability, layout type can be a preliminary understanding of layout intent and child controls roughly placed, eliminating the need for a very tedious restore coordinate steps<br>3.When the the UIView container Flip, size change, supporting multiple resolutions, automatic processing<br>4.UIView category which makes it easy to create layout constraints in old code<br>5.The API is simple and easy-to-use, low cost learning through the sample program to preliminary master<br>

------------------------------------
Adding JSONModel to your project
====================================
- 1.Open your existing project (or create a new one)
- 2.Drag and drop the CUSLayoutExample.xcodeproj file downloaded from github previously from Finder to your project (either root or under Frameworks)

- 3.In YOUR project configuration:<br>
in the Build Phases, Add CUSLayout (the lib, not the example app) as a Target Dependency<br>
in the Link Binary With Libraries section, add the libCUSLayout.a library<br>
- 4.In YOUR Prefix.pch file, add:

    \#import “CUSLayout.h”

- 5.In YOUR project configuration, on the “Build Settings” tab

- locate the “User Header Search Paths” setting, and set the Release value to "${PROJECT_DIR}/CUSLayout" (including quotes!) and check the “Recursive” check box.
- The Debug value should already be set, but if it’s not, change that as well.
- Also locate the “Always Search User Paths” value and set it to YES.
- Finally, find the “Other Linker Flags” option, and add the value -ObjC (no quotes).

------------------------------------
API
====================================
###Base Layout
CUSFillLayout<br>
CUSStackLayout<br>
CUSLinnerLayout<br>
###Advanced Layout
CUSRowLayout<br>
CUSTableLayout<br>
CUSGridLayout<br>

------------------------------------
Basic usage
====================================
###CUSFillLayout
```objective-c
//only one code,auto set the frame of parent to the subview.
view.layoutFrame = [[CUSFillLayout alloc]init];

```

------------------------------------
Example
====================================
![image](https://github.com/JJMM/CUSResources/raw/master/CUSLayout/FillLayout.jpg)<br>
![image](https://github.com/JJMM/CUSResources/raw/master/CUSLayout/StackLayout.jpg)<br>
![image](https://github.com/JJMM/CUSResources/raw/master/CUSLayout/LinnerLayout.jpg)<br>
![image](https://github.com/JJMM/CUSResources/raw/master/CUSLayout/RowLayout.jpg)<br>
![image](https://github.com/JJMM/CUSResources/raw/master/CUSLayout/TableLayout.jpg)<br>
![image](https://github.com/JJMM/CUSResources/raw/master/CUSLayout/GridLayout.jpg)<br>
![image](https://github.com/JJMM/CUSResources/raw/master/CUSLayout/LayoutManager.jpg)

## License
CUSLayout is licensed under the terms of the [Apache License, version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html). Please see the [LICENSE](LICENSE) file for full details.

## Contributions

Contributions are totally welcome. We'll review all pull requests and if you send us a good one/are interested we're happy to give you push access to the repo. Or, you know, you could just come work with us.<br>

Please pay attention to add Star, your support is my greatest motivation, thank you.