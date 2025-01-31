---
layout: post
title: "多线程的基本概念"
description: ""
category: 软件开发
tags: [多线程]
lastmod: 2013-07-05
---

多线程编程必须理解的一些基本概念，适用于所有编程语言。内容：
并发式编程
多任务操作系统
多线程vs多进程
线程安全
线程的生命周期
线程的类型

# 并发式编程

不同的编程范式对软件有不同的视角。并发式编程将软件看做任务和资源的组合——任务之间竞争和共享资源，当资源满足时执行任务，否则等待资源。

并发式编程使得软件易于理解和重用，在某些场景能够极大提高性能。

# 多任务操作系统

要实现并发，首先需要操作系统的支持。现在的操作系统大部分都是多任务操作系统，可以“同时”执行多个任务。

多任务可以在进程或线程的层面执行。
进程是指一个内存中运行的应用程序，每个进程都有自己独立的一块内存空间。多任务操作系统可以“并发”执行这些进程。
线程是指进程中乱序、多次执行的代码块，多个线程可以“同时”运行，所以认为多个线程是“并发”的。多线程的目的是为了最大限度的利用CPU资源。比如一个JVM进程中，所有的程序代码都以线程的方式运行。

这里面的“同时”、“并发”只是一种宏观上的感受，实际上从微观层面看只是进程/线程的轮换执行，只不过切换的时间非常短，所以产生了“并行”的感觉。

# 多线程vs多进程

操作系统会为每个进程分配不同的内存块，而多个线程共享进程的内存块。这带来最直接的不同就是创建线程的开销远小于创建进程的开销。

同时，由于内存块不同，所以进程之间的通信相对困难。需要采用pipe/named pipe，signal, message queue, shared memory,socket等手段；而线程间的通信简单快速，就是共享进程内的全局变量。

但是，进程的调度由操作系统负责，线程的调度就需要我们自己来考虑，避免死锁，饥饿，活锁，资源枯竭等情况的发生，这会增加一定的复杂度。而且，由于线程之间共享内存，我们还需要考虑线程安全性的问题。

# 线程安全

因为线程间共享进程中的全局变量，所以当其他线程改变了共享的变量时，可能会对本线程产生影响。

所谓线程安全的约束是指一个函数被多个并发线程反复调用时，要一直产生正确的结果。要保证线程安全，主要是通过加锁的方式保证共享变量的正确访问。

比线程安全更严格的约束是"可重入性"，即函数在一个线程内执行的过程中被暂停，接下来又在另一个线程内被调用，之后在返回原线程继续执行。在整个过程中都能保证正确执行。保证可重入性，通常通过制作全局变量的本地拷贝来实现。

# 线程的生命周期

所谓的xx生命周期，其实就是某对象的包含产生和销毁的一张状态图。线程的生命周期如下图所示：

![multi-thread-states](/images/2013/multi_thread/thread_state.jpg)

各状态的说明如下：

- New新建。新创建的线程经过初始化后，进入Runnable状态。
- Runnable就绪。等待线程调度。调度后进入运行状态。
- Running运行。
- Blocked阻塞。暂停运行，解除阻塞后进入Runnable状态重新等待调度。
- Dead消亡。线程方法执行完毕返回或者异常终止。
 

可能有3种情况从Running进入Blocked：

- 同步：线程中获取同步锁，但是资源已经被其他线程锁定时，进入Locked状态，直到该资源可获取（获取的顺序由Lock队列控制）
- 睡眠：线程运行sleep()或join()方法后，线程进入Sleeping状态。区别在于sleep等待固定的时间，而join是等待子线程执行完。当然join也可以指定一个“超时时间”。从语义上来说，如果两个线程a,b, 在a中调用b.join()，相当于合并(join)成一个线程。最常见的情况是在主线程中join所有的子线程。
- 等待：线程中执行wait()方法后，线程进入Waiting状态，等待其他线程的通知(notify）。

# 线程的类型

- 主线程：当一个程序启动时，就有一个进程被操作系统（OS）创建，与此同时一个线程也立刻运行，该线程通常叫做程序的主线程（Main Thread）。每个进程至少都有一个主线程，主线程通常最后关闭。
- 子线程：在程序中创建的其他线程，相对于主线程来说就是这个主线程的子线程。
- 守护线程：daemon thread，对线程的一种标识。守护线程为其他线程提供服务，如JVM的垃圾回收线程。当剩下的全是守护线程时，进程退出。
- 前台线程：相对于守护线程的其他线程称为前台线程。

