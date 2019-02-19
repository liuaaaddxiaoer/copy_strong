# 简介

在ARC下我们写属性的时候有时候会写`copy`有时候会写`strong`，有时候一个属性两者都可以写,但是会带来不一样的潜在的风险,一图胜过千言,下图解释了不同情况下的深浅拷贝情况

![深浅拷贝图](https://github.com/liuaaaddxiaoer/copy_strong/raw/master/IMG_1972.JPG)

# NSString (测试`copy`,`strong`对NSString的影响)

```NSString
    @property(nonatomic, strong) NSString *testStrongStr;
    @property(nonatomic, copy) NSString *testCopyStr;
```

* 直接赋值
```NSString
    NSString *str = @"str test";
    self.testStrongStr = str;
    self.testCopyStr = str;
    NSLog(@"%p---%p---%p",str,_testStrongStr,_testCopyStr);
    结果  0x102adc088---0x102adc088---0x102adc088
```
结论: `strong`修饰的NSString是指针复制, `copy`修饰的NSString是指针复制

* copy赋值

```NSString
    self.testStrongStr = [str copy];
    self.testCopyStr = [str copy];
    NSLog(@"%p---%p---%p",str,_testStrongStr,_testCopyStr);
```
结果和结论同上

* mutableCopy赋值

```NSString
    self.testStrongStr = [str mutableCopy];
    self.testCopyStr = [str mutableCopy];
    NSLog(@"%p---%p---%p",str,_testStrongStr,_testCopyStr);
    NSLog(@"\n%@--%@--%@",[str class],[_testStrongStr class],[_testCopyStr class]);
    结果 0x10eb78088---0x6000002523c0---0xa0030414f1003048
        __NSCFConstantString--__NSCFString--NSTaggedPointerString
```
结论: `strong`修饰的在mutablecopy的时候是内容复制会产生新的对象类型是 __NSCFString类型 --->可变字符串
`copy`修饰的在mutablecopy的时候是内容复制会产生新的对象但是类型是 __NSTaggedPointerString的类型 -> 不可变
> 参考 TaggedPointer技术 https://www.jianshu.com/p/4a76b2ebf0c6 用来节省64位机器下的内存和运行效率

* 赋值对象是可变的时候的情况

```NSString
     NSMutableString *mutaStr = [[NSMutableString alloc] initWithString:@"mutaStr tes"];
    self.testStrongStr = mutaStr;
    self.testCopyStr = mutaStr;
    [mutaStr appendString:@"--222"];
    NSLog(@"%p---%p---%p",mutaStr,_testStrongStr,_testCopyStr);
    NSLog(@"\n%@---%@---%@",mutaStr,_testStrongStr,_testCopyStr);
//    [[mutaStr copy] appendString:@"1"];
    NSLog(@"%@",[[mutaStr copy] class]);
    结果: 0x604000246090---0x604000246090---0xa1a04450857900cb
    mutaStr tes--222---mutaStr tes--222---mutaStr tes
    __NSCFString 也可能是 __NSTaggedPointerString类型取决于字符串是否大于11位参考 `TaggedPointer技术` 
```
结论: `strong`当赋值对象是可变的时候的也是指针复制, `copy`会产生新对象产生的对象不可变

* 可变copy赋值情况

```NSString
    NSMutableString *mutaStr = [[NSMutableString alloc] initWithString:@"mutaStr tes"];
    self.testStrongStr = [mutaStr copy];
    self.testCopyStr = [mutaStr copy];
    [mutaStr appendString:@"--222"];
    NSLog(@"%p---%p---%p",mutaStr,_testStrongStr,_testCopyStr);
    NSLog(@"\n%@---%@---%@",mutaStr,_testStrongStr,_testCopyStr);
//    [[mutaStr copy] appendString:@"1"];
    NSLog(@"%@",[[mutaStr copy] class]);
    结果: 0x6040002593b0---0xa1a04450857900cb---0xa1a04450857900cb
    mutaStr tes--222---mutaStr tes---mutaStr tes
```
结论: 不可变对象copy的时候回产生新对象但是统一字符串产生的对象的地址一致

* 可变mutableCopy赋值情况

```NSString
    NSMutableString *mutaStr = [[NSMutableString alloc] initWithString:@"mutaStr tes"];
    self.testStrongStr = [mutaStr mutableCopy];
    self.testCopyStr = [mutaStr mutableCopy];
    [mutaStr appendString:@"--222"];
    NSLog(@"%p---%p---%p",mutaStr,_testStrongStr,_testCopyStr);
    NSLog(@"\n%@---%@---%@",mutaStr,_testStrongStr,_testCopyStr);
//    [[mutaStr copy] appendString:@"1"];
    NSLog(@"%@",[[mutaStr mutableCopy] class]);
    [[mutaStr mutableCopy] appendString:@"1"];
//    [self.testCopyStr performSelector:@selector(appendString:) withObject:@"1"];  // 会crash 由于copy修饰因此是不可变的·

    结果: 0x604000249060---0x604000249180---0xa1a04450857900cb
        mutaStr tes--222---mutaStr tes---mutaStr tes
```
结论: 都产生新对象但是copy修饰的产生的对象是不可变的


# NSMutableString (测试`copy`,`strong`对NSMutableString的影响)

分类和上面一致直接写结论

*直接赋值

    strong赋值是指针赋值copy是内容赋值而且可变字符串的类型变成了不可变的


*copy赋值

    都是内容赋值都是不可变的


*mutableCopy赋值

    strong修饰的变成了可变字符串 copy修饰的变成了不可变字符串

# NSArray (测试`copy`,`strong`对NSArray的影响)

*直接赋值

    strong和copy都是指针赋值

*copy赋值

    同上

*mutableCopy赋值

    strong可变数组  copy不可变数组

# NSMutableArray (测试`copy`,`strong`对NSMutableArray的影响)
    同上

# NSDictionary (测试`copy`,`strong`对NSDictionary的影响)

    和数组基本一致

# NSMutableDictionary (测试`copy`,`strong`对NSMutableDictionary的影响)

    和NSDictionary基本一致但是特别需要注意的是可变字典再进行copy操作生成的字典类型是
    `__NSFrozenDictionaryM`是不可变的字典


> 类簇 例如 SafeKit等框架可以用来防止线上数组字典等类型的崩溃

