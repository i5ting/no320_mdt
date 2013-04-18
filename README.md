# Beeframework教程

老郭的Beeframework https://github.com/gavinkwoe/BeeFramework/

 
## Getting started with the source
no320_mdt and other extensions are provided as a submodules to this project. To be able to compile the source code you need first check out the module. Change directory into the top (this) directory of no320_mdt and run:

```
git clone https://github.com/i5ting/no320_mdt.git
cd no320_mdt
git submodule update --init --recursive
```

When building no320_mdt, make sure that "no320_mdt" is the selected target (it may be some of the plug-in targets by default).

##Still having trouble compiling CocosBuilder?
It is most likely still a problem with the submodules. Edit the .git/config file and remove the lines that are referencing submodules. Then change directory into the top directory and run:


```
git submodule update --init
```

When building no320_mdt, make sure that "no320_mdt" is the selected target (it may be some of the plug-in targets by default).





## 目前只是把架子搭起来了，内容会一点一点更新的

期待大家一起完善
