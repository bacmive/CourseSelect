国科大选课系统[![Build Status](https://travis-ci.org/bacmive/CourseSelect.svg?branch=master)](https://travis-ci.org/bacmive/CourseSelect)   
[运行demo](my1web.herokuapp.com)
### 系统部署

#### 本地部署
```
以下部署步骤在 Mac 和 Linux 环境下均可执行：   
将此项目clone到本地：git clone https://github.com/bacmive/CourseSelect.git
cd CourseSelect
bundle install
rails db:migrate
rails db:seed
rails s
然后再浏览器中输入localhost:3000执行预览
```   
#### Heroku云部署
```
	本项目已经在 Heroku 上进行了部署，链接为： https://my1web.herokuapp.com/。   
1.	创建Heroku账号，并在本地（Mac/Linux）下安装Heroku CLI(Heroku命令行工具)   
2.	上一步安装完成后，在本地远程登录heroku账号使用命令：heroku login –i   
3.	创建新的heroku应用使用命令：heroku create ApplicationName   
4.	保证当前本地的项目目录已经被git管理，然后运行git push heroku master将本地项目部署到heroku上   
5.	打开heroku open，再访问项目网站   
```

 
