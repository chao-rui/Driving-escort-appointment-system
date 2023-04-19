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