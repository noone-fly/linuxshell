# linuxshell
shell scripts

exec:
　　在bash下输入man exec，找到exec命令解释处，可以看到有”No new process is created.”这样的解释，这就是说exec命
令不产生新的子进程。那么exec与source的区别是什么呢?
　　exec命令在执行时会把当前的shell process关闭，然后换到后面的命令继续执行。
系统调用exec是以新的进程去代替原来的进程，但进程的PID保持不变。因此，可以这样认为，exec系统调用并没有创建新的
进程，只是替换了原来进程上下文的内容。原进程的代码段，数据段，堆栈段被新的进程所代替。

exec在对文件描述符进行操作的时候（也只有在这个时候），它不会覆盖你当前的shell。
几个例子：
1、exec 32、exec 3>/tmp/1.txt    //以“只写方式”打开/tmp/1.txt，文件描述符对应为3
3、exec 3<>/tmp/1.txt   //以“读写方式”打开/tmp/1.txt，文件描述符对应为3
4、exec 3<&-            //关闭文件描述符3

exec I/O重定向详解及应用实例
　　1、 基本概念(这是理解后面的知识的前提，请务必理解)
　　a、 I/O重定向通常与 FD有关，shell的FD通常为10个，即 0～9;
　　b、 常用FD有3个，为0(stdin，标准输入)、1(stdout，标准输出)、2(stderr，标准错误输出)，默认与keyboard、monitor
、monitor有关;
　　c、 用 来改变送出的数据信道(stdout, stderr)，使之输出到指定的档案;
　　e、 0 是 与 1> 是一样的;
　　f、 在IO重定向 中，stdout 与 stderr 的管道会先准备好，才会从 stdin 读进资料;
　　g、 管道“|”(pipe line):上一个命令的 stdout 接到下一个命令的 stdin;
　　h、 tee 命令是在不影响原本 I/O 的情况下，将 stdout 复制一份到档案去;
　　i、 bash(ksh)执行命令的过程：分析命令-变量求值-命令替代(``和$( ))-重定向-通配符展开-确定路径-执行命令;
　　j、 ( ) 将 command group 置于 sub-shell 去执行，也称 nested sub-shell，它有一点非常重要的特性是：继承父shell
的Standard input, output, and error plus any other open file descriptors。
　　k、 exec 命令：常用来替代当前 shell 并重新启动一个 shell，换句话说，并没有启动子 shell。使用这一命令时任何现
有环境都将会被清除。exec 在对文件描述符进行操作的时候，也只有在这时，exec 不会覆盖你当前的 shell 环境。
　　2、cmd &n 使用系统调用 dup (2) 复制文件描述符 n 并把结果用作标准输出
　　&- 关闭标准输出
　　n&- 表示将 n 号输出关闭
　　上述所有形式都可以前导一个数字，此时建立的文件描述符由这个数字指定而不是缺省的 0 或 1。如：
　　... 2>file 运行一个命令并把错误输出(文件描述符 2)定向到 file。
　　... 2>&1 运行一个命令并把它的标准输出和输出合并。(严格的说是通过复制文件描述符 1 来建立文件描述符 2 ，但效果
通常是合并了两个流。)
　　我们对 2>&1详细说明一下 ：2>&1 也就是 FD2=FD1 ，这里并不是说FD2 的值 等于FD1的值，因为 > 是改变送出的数据信
道，也就是说把 FD2 的 “数据输出通道” 改为 FD1 的 “数据输出通道”。如果仅仅这样，这个改变好像没有什么作用，因
为 FD2 的默认输出和 FD1的默认输出本来都是 monitor，一样的!
　　但是，当 FD1 是其他文件，甚至是其他 FD 时，这个就具有特殊的用途了。请大家务必理解这一点。
　　3、 如果 stdin, stdout, stderr 进行了重定向或关闭, 但没有保存原来的 FD, 可以将其恢复到 default 状态吗?
　　*** 如果关闭了stdin，因为会导致退出，那肯定不能恢复。
　　*** 如果重定向或关闭 stdout和stderr其中之一，可以恢复，因为他们默认均是送往monitor(但不知会否有其他影响)。如
恢复重定向或关闭的 stdout： exec 1>&2 ，恢复重定向或关闭的stderr：exec 2>&1。
　　*** 如果stdout和stderr全部都关闭了，又没有保存原来的FD，可以用：exec 1>/dev/tty 恢复。
　　4、 cmd >a 2>a 和 cmd >a 2>&1 为什么不同?
　　cmd >a 2>a ：stdout和stderr都直接送往文件 a ，a文件会被打开两遍，由此导致stdout和stderr互相覆盖。
　　cmd >a 2>&1 ：stdout直接送往文件a ，stderr是继承了FD1的管道之后，再被送往文件a 。a文件只被打开一遍，就是FD1
将其打开。
　　我想：他们的不同点在于：
　　cmd >a 2>a 相当于使用了两个互相竞争使用文件a的管道;
　　而cmd >a 2>&1 只使用了一个管道，但在其源头已经包括了stdout和stderr。
　　从IO效率上来讲，cmd >a 2>&1的效率应该更高!
　　exec 0exec 1>outfilename # 打开文件outfilename作为stdout
　　exec 2>errfilename # 打开文件 errfilename作为 stderr
　　exec 0&- # 关闭 FD1
　　exec 5>&- # 关闭 FD5


文件描述符在形式上是一个非负整数。实际上，它是一个索引值，指向内核为每一个进程所维护的该进程打开文件的记录表。当程序打开一个现有文件或者创建一个新文件时，内核向进程返回一个文件描述符。在程序设计中，一些涉及底层的程序编写往往会围绕着文件描述符展开。但是文件描述符这一概念往往只适用于UNIX、Linux这样的操作系统。
习惯上，标准输入（standard input）的文件描述符是 0，标准输出（standard output）是 1，标准错误（standard error）是 2。
文件描述符的有效范围是 0 到 OPEN_MAX。一般来说，每个进程最多可以打开 64 个文件（0 — 63）。对于 FreeBSD 5.2.1、Mac OS X 10.3 和 Solaris 9 来说，每个进程最多可以打开文件的多少取决于系统内存的大小，int 的大小，以及系统管理员设定的限制。Linux 2.4.22 强制规定最多不能超过 1,048,576
