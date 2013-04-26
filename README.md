CUSLayout
=========

Auto layout for iOS.Simlar to Android,SWT,SWING API.It solves the problem of iPhone, iPhone5, iPad, resolution, rotation etc.

CUSLayout为iOS下提供托管定位机制，系统提供的绝对定位方式极不方便使用，另外iPhone的4寸屏幕的出现和iPad令iOS开发者在布局需要花更多的时间，然而iOS6.0提供的AutoLayout机制令人失望，所以笔者参考Android、SWT、SWING等布局机制，编写了适合iOS下使用的CUSLayout，使用CUSLayout有以下几个好处：
1、简化编码，不需要考虑到像素级别，仅针对区域性编程，极大的提高编程效率
2、良好的可读性，通过布局类型即可初步了解布局意图和子控件大致摆放方式，省去了令人繁琐的还原坐标的步骤
3、在UIView容器翻转、大小变化、支持多种分辨率时，自动处理
4、CUSLayou基于UIView布局，可完美迁移到任何应用种，不会影响原有应用
5、API简单易用，学习成本很低，通过样例程序，即可初步掌握
https://github.com/JJMM/CUSLayout
心动不如行动，搞起！

 ![image](https://github.com/JJMM/CUSLayout/raw/master/CUSLayoutIntr.gif)