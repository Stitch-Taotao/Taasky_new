//
//  Mark.h
//  Taasky
//
//  Created by I_MT on 2017/3/9.
//  Copyright © 2017年 Ray Wenderlich. All rights reserved.
//

#ifndef Mark_h
#define Mark_h
1.控制器的调用顺序，containerVC的viewdidload->DetailVC.viewdidload->MenuViewControllerVC.viewdidload
    假想：先调用父控制器的viewdidload，再对父控制器下的自控制器按照添加顺序的逆向进行调用（如果都第一时间显示的话...），好吧，尽是猜测罢了。

#endif /* Mark_h */
