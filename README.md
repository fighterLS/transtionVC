# transtionVC
学习使用viewController转场效果，学习交流

![image](https://github.com/fighterLS/transtionVC/blob/master/transition.gif) 

参考这篇：http://www.raywenderlich.com/86521/how-to-make-a-view-controller-transition-animation-like-in-the-ping-app  
简单的学习，将swift改成oc

扩展学习：尝试边缘手势，
  //边界手势
    UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    //设置从什么边界滑入
    edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [_navigationController.view addGestureRecognizer:edgePanGestureRecognizer];
 
 其他参考http://www.jianshu.com/p/d39f7d22db6c
