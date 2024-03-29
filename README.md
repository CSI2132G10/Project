## Installation Guide
### Part 1 - Getting The Project
1. First, recognize what operating system you are planning to install and run the project on, but specifically, whether you are planning on using Windows or MacOS/Linux.
   
   We recommend using MacOS/Linux ~~as they are actually designed competently~~ because it is much easier to set up and install the necessary dependencies, but installation can also be achieved on Windows.
2. Verify that the following dependencies are installed and/or downloaded.
	1. [Java](https://www.java.com/en/download/help/download_options.html)
	2. [PostgreSQL](https://www.postgresql.org/download/) (including pgadmin4)
		1. On MacOS, we recommend using [Homebrew](https://brew.sh/) to install PostgreSQL with `brew install postgresql`.
	3. [Apache tomcat](https://tomcat.apache.org/download-10.cgi)
3. Next, find and choose a location on your local machine that you will use to install and set up the project. 
   
   4. Clone the GitHub [project](https://github.com/CSI2132G10/Project) repository using `git clone https://github.com/CSI2132G10/Project`, or simply download the project as a .zip file.![](https://lh7-us.googleusercontent.com/WpNtDpE_I48jbKId4C84Pe623oU_leACiNVJw5Fjjid88qR1LpLK9x5oZgyKtHpaIPHfFm9RVku2v-ILT6WCXQY4YMP6JrKlMNnfwxaxWvsBtwq3_MkJro6KHolGyjorJGcDwrnkDYH9zK0ex8CU9C0)
   
### Part 2 - Setting Up The Database
1. Create an empty database using pgadmin4  
   
   Use the default settings wherever possible.  
   
2. Verify/Input The Following:
   Name: `postgres`  
   Host name/address: `127.0.0.1` or `localhost`  
   Username: `postgres`  
   Password: `admin`  
   Port: `5432`
   
3. To build and populate the database, you must use `database.sql` and `data.sql` located in the `sql` directory in the project files.  
   
   Simply copy or drag & drop the contents of `database.sql` into pgAdmin4’s query tool for the database and run.  
   
   Afterward, do the same with `data.sql`. This should populate the database with all the necessary data.
   ![](https://lh7-us.googleusercontent.com/umxZ55rI9qhqhuBWsCC2gTE_cqK86FRXOoik7Rr6ts0T5G2QV1y4yiUW8svbC8OfN7afGYOVQeEQeYO_fKXag-5r-yzkh_PPQ1QGpsxMiqIKWEXrh7CjGi6i453Ko8GnY0jlBkoTEDytzbXleO0ftAE) ![](https://lh7-us.googleusercontent.com/LcoiNyIiN-b28QzZv-I9O3X5KSWvMjEjLHw7mO7IMHLvzClEAXZG0513baGegwp4fwzzfPgbByyivBx2i_-u06RIAS8iPrkAq-jI6gure4DD_NpSLVYNrjHGfY-DPgvWaJJMZZBdXdAo3pDj_TyVJL0)

### Part 3 - Installing the Web App (Tomcat)
1. Now we must startup an Apache Tomcat server. This can be done through the command line or through your editor of choice, although we only list installation steps for Visual Studio Code.
	- **Command Prompt (Windows):**
	   Navigate to the bin directory of your tomcat installation and type `startup`.  
	   
	   NOTE: You may need to change your `PATH` environment variable for this to work. The `JAVA_HOME` section must be set to the location of your JDK installation location.  
	   
	- **Command-Line Interface (Linux/MacOS):** 
	   Navigate to the `bin` directory of your tomcat installation using `cd <where_you_downloaded_tomcat>/bin` and run the command `./startup.sh`.
	    
	- **Visual Studio Code:**  
	   Install the Community Server Connectors extension. 
	   
	   There should be a drop-down box called “SERVERS” in the bottom left. 
	   
	   Open the drop-down and right click on the Community Server Connector and select “Create new server”. 
	   
	   Select “use server on disk” and link to your local Apache tomcat installation. Right click on the new server and select “Start Server”.
2. If you have done everything successfully, we are now running tomcat as a tomcat server. 
   
   To verify this, open any browser and visit [http://localhost:8080/](http://localhost:8080/). 
   
   If you have done everything correctly, you should see a webpage that looks like:![](https://lh7-us.googleusercontent.com/skcWxVBn4uxPxG4QIlHW59wpHrsuJz6Fgxz8WUcJWhJiV4gijnUiWzbjaFDmv3AiQeLBJpw-GQt0kRGLiqSISZ9w4gsy0MdCbn2tt5nzP2c_dPu9wTcTWaHy6xJCuG0N7GjXCDTeeFMTk7xvapfZYGw)

3. We then need to add users to our manager webapp, which we can do by navigating to `<apache_installation>/conf/` and, using your text editor of choice, uncomment the section containing:
```
   <user username="admin" password="<must-be-changed>" roles="manager-gui"/>
   <user username="robot" password="<must-be-changed>" roles="manager-script"/>
```
   And change the sections containing `<must-be-changed>` to a password of your choice.

4. Afterwards, go back to the web page and click on “Manager App” in the top-right and enter your apache tomcat that you just obtained in the previous step.
   
5. Scroll down to the `WAR file to deploy` subsection of the `Deploy` section.  ![](https://lh7-us.googleusercontent.com/5HmfSyP5LriUuVTPi4yW1bYrFswjSwwpjlAT064DZJP1GpWaJXFdCSybCQctmcy137gz8I1KuGA6x4rMht34j6m0JKJpVcI5c2cRC0AHq4aI7gRWKwVjrYY7i5Vsk-G0AMh04aD7ViahvRYzqUXPYPA)
   
   This is where you are going to deploy the project's `WAR` file.
6. Select “Browse” and navigate to the `project.war` file in the project directory. ![](https://lh7-us.googleusercontent.com/5HmfSyP5LriUuVTPi4yW1bYrFswjSwwpjlAT064DZJP1GpWaJXFdCSybCQctmcy137gz8I1KuGA6x4rMht34j6m0JKJpVcI5c2cRC0AHq4aI7gRWKwVjrYY7i5Vsk-G0AMh04aD7ViahvRYzqUXPYPA)
   Once selected, click “Deploy”. 
   
7. Finally, find the “Applications” list towards the top of Tomcat’s Manager App. Click on the application labeled “/project” under the "Path" column and it will open the web app.![](https://lh7-us.googleusercontent.com/aTzXAT1a7OPBCkXWSHXrSoLtL3Kerz1UX7QQD3wUUshR5RlhbOgNHZN9x74lg1ctbGD4MIO3fkFlab_4OceWk9QSGn-hTatSpJdtCQ4367kUBOmD3zz9xrbgqzen8XmSO_o6kNvCBMteRyZyQyk5eNk)

8. That’s it! You have successfully installed and set-up everything! You should now see a page that looks like the following: ![](https://lh7-us.googleusercontent.com/7YcJrax0GND2c7xIhm1wdlBu0cy-irMcTSGHwKge61pXCKYw61ymgH5aruSAbJMefyChLUTw7Y4-b_Fj9bENC9HqlBRabqQQr9Ioww-PciN-JMAmOG0sjQTmZa4iZweH3R99pzh1Njsbvk4VGbDRAcQ)
