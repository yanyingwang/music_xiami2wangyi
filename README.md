# MusicXiami2wangyi
* 备注：值此虾米服务停用之际，重新修复部分问题，维持了使用性。  ---- 2020-01-07
* 网易windows客户端(导入曲库使用)：<https://github.com/yanyingwang/music_xiami2wangyi/raw/master/cloudmusicsetup_2.1.1.30494_baidupc.exe>
* 用Ruby实现的，抓取用户虾米音乐的加心歌曲，生成酷狗kgl文件格式，以来导入到用户的网易云音乐歌单的工具。
* 另：如果你用过了[Xiamilist](http://www.jianshu.com/p/21bafe882455)这个工具，但却发现不是很好用，那么本工具很可能是你正在迫切寻找和需要的的。


## 如你在使用中，发现有缺歌现象，请逐个排查确确实问题后，联系我修复问题：
1. 查看生成的xiami-17xxxxx.kgl文件，确定歌曲是否已被抓取。
2. 如果歌曲确定以备抓取，请确认文件名是否被正确抓取。
3. 如果文件名正确，请到网易云音乐搜索此文件名歌曲，以确认网易曲库存在此歌曲。
4. 如果确认网易曲库存在此歌曲，亦或此歌曲的命名不同但是有相似规律，请记录之。
5. 联系我时，请提供以上信息，以供我快速排除修复问题。




## [Quartz](https://www.xquartz.org/)
请首先安装Quzrtz在MacOS系统上，因为本项目在解析虾米网站的时候，使用了chrome浏览器渲染页面，以来跳过反爬虫机制。

## chromeriver

    $ bundle config build.ffi --with-cflags="-Wno-error=implicit-function-declaration"
    $ brew install automake autoconf libtool
    $ brew install chromedriver

## /tmp/.X11-unix问题
请执行以下命令来修复xfvb在macos下的[问题](https://github.com/leonid-shevtsov/headless/issues/80)。
~~~shell
mkdir /tmp/.X11-unix
sudo chmod 1777 /tmp/.X11-unix
sudo chown root /tmp/.X11-unix/
~~~

## 虾米客户端
目前新版的虾米客户端已经不支持歌单导入，但可以[下载](https://raw.githubusercontent.com/yanyingwang/music_xiami2wangyi/master/cloudmusicsetup_2.1.1.30494_baidupc.exe)旧版的PC客户端安装使用导入歌单功能。

# 使用手册

## 确定自己虾米用户的ID：
登录自己的虾米音乐主页即可通过url链接判断出自己虾米用户的ID，如作者本人的主页为<http://www.xiami.com/u/3278030>，则我的用户ID为3278030。

## 克隆本仓库：

    $ git clone git@github.com:yanyingwang/music_xiami2wangyi.git

## 进入根目录并且进而进入console：

    $ cd music_xiami2wangyi && bundle && ./bin/console

## 生成用户实例，注意替换作者ID成自己的用户ID：

    $ m = MusicXiami2wangyi.new("3278030")

## 抓取导出歌单：

    $ m.gen_xml_songs

## 歌单示例：
作者导出的本人的虾米歌单，作为示例如下：

<https://github.com/yanyingwang/music_xiami2wangyi/blob/master/xiami-170403.kgl>


## 导入歌单：
如果导出歌单成功，即在此目录下生成类似`xiami-170403.kgl`的文件。然后打开网易云音乐客户端（注意：ubuntu客户端不支持导入歌单）导入歌单即可。

## 完全方法索引示例：
~~~ruby
m = MusicXiami2wangyi.new("3278030")

m.count_page_end_num
m.page_end_num
m.page_nums

m. crawl_music_file_names
m.songs

m.gen_xml_songs
m.xml_songs
~~~


## 使用示例之图片：
![cmd](https://raw.githubusercontent.com/yanyingwang/music_xiami2wangyi/master/screenshots/cmd.png)

![import](https://raw.githubusercontent.com/yanyingwang/music_xiami2wangyi/master/screenshots/import.png)

![import-done](https://raw.githubusercontent.com/yanyingwang/music_xiami2wangyi/master/screenshots/import-done.png)






## Installation

Add this line to your application's Gemfile:

```ruby
gem 'music_xiami2wangyi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install music_xiami2wangyi

## Usage

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/music_xiami2wangyi. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

