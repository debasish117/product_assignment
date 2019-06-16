# README

This README would normally document whatever steps are necessary to get the
application up and running.

**Application Dependencies**

1. Ruby version 2.4.1
2. Rails version 5.2.3
3. DB ( postgresql version 10.1 )

**Initial Setup to be done**

1. Move to the application path and run bundle install for fetching the gems.
2. To create a new database and dumping the seed data to db, run **rails db:create db:migrate db:seed** 
3. The seed data will create a default admin user with login credentials .
4. Finally to import the data, run **rails import:data** and provide the directory path name, exact file name when prompted 
5. Running the server and browsing will take user to the login screen.

**Creating Customers**
1. User needs to fill in the signup form, and login to be view the suppliers and products .
