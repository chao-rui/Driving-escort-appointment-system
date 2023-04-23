我是2023届西安石油大学软件专业毕业生，这是我的毕业设计——基于Web的汽车一对一驾驶陪练预约系统的设计与实现。

后端：springMVC 框架（4.3.8_RELEASE,jdk1.8）

数据库：MySQL

前端：JSP+Element UI



## 踩坑记录

### 1.后端向前端传递对象

1. 在pom.xml中添加依赖。

   ```xml
     <dependency>
          <groupId>com.fasterxml.jackson.core</groupId>
          <artifactId>jackson-databind</artifactId>
          <version>2.12.7.1</version>
   </dependency>
   ```

   

2. 在springMVC配置文件中添加如下。

   ```xml
   <mvc:annotation-driven>
           <mvc:message-converters>
               <bean class="org.springframework.http.converter.StringHttpMessageConverter"/>
               <bean class="org.springframework.http.converter.json.MappingJackson2HttpMessageConverter"/>
           </mvc:message-converters>
   </mvc:annotation-driven>
   ```

3. 在Controller中需要向前端返回的方法前添加注解@ResponseBody。

4. 理论上到这里就好了，但是我执行时遇到了报错：

   ```java
   java.lang.ClassNotFoundException: com.fasterxml.jackson.core.util.DefaultPrettyPrinter$Indenter
   ```

   原因：添加依赖后并jar包没有部署到工件中。

   解决方法：在项目结构->工件中重新部署一下，也就是先把原来的删了重新增加一遍。

### 2.多表查询

[Mybatis注解开发：使用注解实现一对一、一对多、多对多查询_mybatis 一对多 注解_丿涛哥哥的博客-CSDN博客](https://blog.csdn.net/qq_37829947/article/details/117229334)

## 遗留问题

1. 忘记密码（密码找回）
2. 管理员注册邀请码
3. 教练申请审核流程
4. 统计相关操作（驾校中的教练，车辆统计）

## 相关标志

user： 0 删除 1 新用户 2 普通用户 3 教练 4 驾校信息管理
car： 0 未分配 1 正常 2 预约中 3 正在维修 4 报废
appmnts： 0 预约未开始 1 预约中 2 预约结束 3 已评价
apply：0 申请中 1 申请未通过