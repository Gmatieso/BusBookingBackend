# Deploying a Rails App

This guide is dedicated to deploying a Rails application on Railway.
# Railway CLI installation

Create an account and log in to Railway https://railway.app/

After successful account creation, install the Railway CLI using either of the
following options;
- Installation with brew(only applicable to Mac users) => brew install railway
- Installation with npm => npm i -g @railway/cli
Login using railway login, which will pop up a browser tab to authenticate into an
existing railway session.

From within your project locally, create a new project on Railway using; railway init
- Running the above command will prompt you to either create a new project
from a template or start an empty project; select, empty.
- You will then be prompted to enter the project name, enter a name of your
choice.
- After the two prompts, Railways CLI will automatically set the environment to
production, and then a browser window will appear, where you will complete
the configurations of the app.
# Adding a DB
From the browser window, select add new service, then databases, and then
PostgreSQL. This will provision a new DB for your project. You can add as many
services as you want.
You can also simply run; railway add and select your choice DB from the terminal

# Configuring the Project for Deployment

From the dashboard of the project, add any environment variables, in this case, the
PORT variable. Therefore select, Add new variable, then enter the PORT and assign
the value of 3000
Create a file with the name Procfile - Note: The name is case-sensitive.
In the file add, web: rake db:migrate && bin/rails server -b 0.0.0.0 -p $PORT
- In the above command, we are creating a web instance and then migrating
the DB, and finally running the server binding to the IP and getting the port
from the environment variable.
- NOTE: The commands in this file are executed every time your app restarts
or whenever you try to redeploy.

Create a file lib/tasks/fake-assets.rake and add the following code;
## image here 
- At this point, we are just being clever to override the action done by
bundle exec rake assets:precompile. Remember in our full API app we don’t
have assets.
Navigate to the database.yml file and change the production setting to point to the
remote database.
## image here 

Inside production.rb and development.rb files inside the config/environments
folder add **config.hosts << "<name-of-app>-production.up.railway.app"**
  - Note: The brackets <> inside the quotes are meant to mark the beginning and
end of your app name, therefore if the name of your app is we-care then the
setting should be **config.hosts << "we-care-production.up.railway.app"**
  
 ## image here 
  
# Connecting the local and remote app
  
  On the Railway dashboard, select the app you created, then from the settings copy
the project id, and now on the command line within your project run; **railway link
<project-id>**
  - In the above step, you are connecting your local app to the remote app -
  think of it as git remote add …
  - NOTE: You can also link to your GitHub repository, and the project will be
  deployed every time you push the code to it.
  
 # Deploy the App
   To deploy your app run; railway up
   - The above command will trigger a build of your project and then push your
      code to the Railway server.
   - Navigate, to the settings of the app and choose, create domain to get the link
      to your app
   - After a successful deployment, you can find the link from the dashboard or it
      will be printed on the terminal. FYI it’s the same link you just used in your
      environments config
To check for logs, navigate to the Railway dashboard, select your app and then
select view logs. But because developers like seeing stuff on the terminal, just run
railway logs to see the log tail.
  
  # Delete the latest deployment
  Run **railway down**
  
 # Running more commands
  To seed your data in the database, run; railway run rake db:seed
  - You can run any command just like you would do locally as long as you
    begin the command with railway run
  
 # References
  CLI |Railway Docs https://docs.railway.app/develop/cli





# BusBookingBackend
