=======================================
========반드시 읽고 실행해주세요========
=======================================

Server.xml 파일의 Host태그 안쪽 제일 아래에
<Context docBase="LifeBook" path="/LifeBook" reloadable="true" source="org.eclipse.jst.jee.server:LifeBook">
	  	<Resource auth="Container" driverClassName="oracle.jdbc.OracleDriver" maxActive="100" maxIdle="30" maxWait="10000" name="jdbc/oracle" password="1234" type="javax.sql.DataSource" url="jdbc:oracle:thin:@localhost:1521:xe" username="lifebook"/>
</Context>
위 코드를 넣어주세요.

이후 SQL Developer를 실행한 후
System계정에서 CreateUserLifeBook.sql 스크립트,
생성된 lifebook 계정에서 p1.sql 스크립트를 각각 실행해주신 후

intro/intro.jsp 파일을 실행해 주세요.