# ToronHot Dog

## Summary
**Created and Developed by Gregory P. Desrosiers (GregPDesSCH)**  
*University of Waterloo, Software Engineering 2019*

VERSION 1.0  
Start Date: January 27, 2018  
End Date: April 11, 2018

Project License Pending

Source Code and Design © 2018 Gregory Desrosiers. All rights reserved.


## About

This is a conceptual single page website application where tourists all over the world, and the residents of Toronto, can use it to help them look for hot dog stands in Toronto's core. The entire city of Toronto is large as a whole; there are so many places you can go. But what if you get lost somewhere and you want to grab a hot dog or a snack from a street stand along the way?

This web application is designed to search for hot dog stands within the entertainment and business districts of Toronto, with the option to include your own preferences. These are how far you want to reach maximum from a reference point, how much you want to pay, what foods you want, what drinks you want, and what condiments you want.

![Search Pane](search.png)

The resulting hot dog stands are displayed on a map with Google Maps. You can select your stand, review the menu for your reference, and ask for directions on getting there from where you are.

![Results Pane](results.png)

Whether you are at the corner of two popular roads, like Dundas Street and Spadina Avenue, a subway station like Wellesley subway station, a landmark such as the Hockey Hall of Fame, or for your navigation preferences, latitude and longitude coordinates, ToronHot Dog is made to take into account your current location and find a hot dog stand close by, whether with preferences or not.



## Technical Details

This is a one-page website application built using Ruby on Rails, an open-source website model-view-controller framework. It's the same framework used by both GitHub and Shopify to develop and deploy their websites to online users.

The core of the website is a PostgreSQL database. It uses relational tables to store data for long-term reads the website performs.

Data models and controllers are programmed using Ruby, a programming language that is interpreted using system-dependent executables. The website views are programmed using Embedded Ruby, an interface library as a compromise between Ruby, the backend language, and HTML, the official programming language for developing websites, as specified under the World Wide Web Consortium.

Twitter Bootstrap is used to provide the frontend look and feel. It's also used for some embedded behaviors. The main frontend behavior is written using jQuery, an interface library as a substitute for JavaScript that provides cleaner code for changing certain HTML elements in the pages, as well as certain actions including animations and exchanging data back and forth between frontend and backend. The exchange is carried out using AJAX [Asynchronous JavaScript and XML] under HTTP [HyperText Transfer Protocol].

Additional Resources and Libraries include Google Maps API v3 and Google Maps Directions API v3.

As this is a conceptual project done for educational purposes, all the data used here is mock data, but to the most realistic as possible to provide certain accuracy on what the full website would be if this was to be moved on to a commercialized website.


## Setup Instructions

**Requirements**

You'll need to install three components: PostgreSQL, Ruby, and Ruby on Rails. This website has been built using Ruby 2.3.3p222 (Revision 56859, November 21, 2016), and Ruby on Rails 5.1.5. You'll also need a Google account, as this website uses the Google Maps API and the Google Maps Directions API through a single API key. As Ruby on Rails depends on NodeJS for runtime, you'll need NodeJS as well.

*Optional Requirement*: You'll need a Git shell to download this repository, but you can also download this repo as an archived ZIP folder using the green button at the top of the page.




**Installation Instructions**

1. Use the following links to install Ruby.

[https://www.ruby-lang.org/en/downloads/](https://www.ruby-lang.org/en/downloads/)

[https://www.ruby-lang.org/en/documentation/installation/](https://www.ruby-lang.org/en/documentation/installation/)


2. Once installation is finished, check to see that the execution is properly installed by entering the following commands in order on the terminal:
```
ruby -v
```

If you get something similar to these lines of output:
```
ruby 2.3.3p222 (2016-11-21 revision 56859) [i386-mingw32]
```
you're all set, as Ruby is working properly.



3. Ruby on Rails does not have an official installer by default. Therefore, do a Google Search to find instructions on installing Ruby on Rails for the given operating system you have. In my case, I am on Windows 10 x64, so I used [RailsInstaller](http://installrails.com/) to find the installation bundle I need. It came with a version of Ruby that's the same as above.

One friendly way you can install the latest version of Ruby on Rails is by using [RubyGems](https://rubygems.org/pages/download), which is a package manager specifically for Ruby. It's practically useful for Ruby-based development. After installing, you can use the following command to install Ruby on Rails:
```
gem install rails
```

It will then install all dependencies and Ruby on Rails for you. One of them is NodeJS, which is a JavaScript runtime environment; *Ruby on Rails depends on it in order to run the server*.



4. Once you've installed Ruby on Rails and its dependencies, do the same thing as Step 2, but with this command instead:
```
rails --version
```

If you get something similar to this:
```
Rails 5.1.5
```
you're all set, as Ruby on Rails is working properly.



5. Next, install PostgreSQL 10 from [the official PostgreSQL Downloads page.](https://www.postgresql.org/download/)
*If you are installing for Windows, Mac OS, or Linux, using the interactive installer is highly recommended for your convenience. When you get to the step where you need to define the username and password for the superuser, make sure to keep notes of these later on. Ruby on Rails needs these credentials in order to communicate with the database.*

6. To check that PostgreSQL 10 is working properly, run the PostgreSQL 10 SQL Shell (or psql for short) on your system.

7. Enter the credentials for the default user you've provided the credentials for in the interactive setup utility.

8. Enter the following command:
```
SELECT version();
```

If you see the version number in the output, such as 10.2, you're all set; PostgreSQL is now working properly.




**API Key**

1. To retrieve the API key you'll need, use the following link:

[https://developers.google.com/maps/documentation/javascript/get-api-key](https://developers.google.com/maps/documentation/javascript/get-api-key)

*Do NOT share this API key with anyone.*

2. Create a file called *application.yml* in the config folder.

3. Add the following key code pair
```
GOOGLE_MAPS_DEVELOPMENT_API_KEY: '<YOUR_API_KEY>'
```
replacing `<YOUR_API_KEY>` with the key you got from the Google API Console. *Be sure the key is enclosed in single quotes.*

4. Save the file.



**Server Setup**

Before the website's server can run, it needs to know the credentials to access the database.

1. Go to config/application.yml.

2. Add the following two key-value pairs:
```
POSTGRESQL_DATABASE_USERNAME: '<DEFAULT_POSTGRESQL_USERNAME>'
POSTGRESQL_DATABASE_PASSWORD: '<YOUR_POSTGRESQL_DEFAULT_PASSWORD>'
```

Replace the `<DEFAULT_POSTGRESQL_USERNAME>` and `<YOUR_POSTGRESQL_DEFAULT_PASSWORD>` fields with the credentials you've kept upon installing PostgreSQL 10. Make sure the values are between the single quotes.

3. Save the file.



Now, it needs to have a database to connect it to and fetch data from.

1. Open the PostgreSQL 10 SQL Shell (or psql for short).

2. Press Enter on all fields except the password; the shell is asking for the credentials to sign in as a database client. It should already hold the default user values for you except the password.

3. Enter the password for the default user.

4. The website has three environments to which it can run in: development, test, and production. We want to use the development environment, so enter the following command in the shell:
```
CREATE DATABASE toronhot_dog_development;
```

Wait for the command to finish processing. You should see an output message that says `CREATE DATABASE`.

5. Exit the PostgreSQL 10 SQL Shell.



As ToronHot Dog only fetches data from the database, we need to create the tables and add data to it. A few files already included in this repo will do this for you.

1. Open up a computer terminal, such as Command Prompt on Windows.

2. Navigate to the directory of this website.

3. Enter `rails db:migrate`

4. Wait between 30 to 60 seconds. This built-in migration script creates the tables and adds data for you.




**How to Run the Website**

*Before running the website, be sure that you have your PostgreSQL credentials and Google Maps API key in place. Also, make sure that Ruby and Ruby on Rails are installed.*

1. Open up a computer terminal. On my machine, being Windows 10 Home on 64-bit architecture, I simply use Command Prompt.
*NOTE: On Windows, make sure that the Command Prompt is able to recognize the rails command. If it's not, you need to add the installation path of your installed version of Ruby on Rails to the PATH variable in the Environment Variables Utility through Advanced System Settings.*

2. Navigate to the root directory of the website; that is, the same directory as the repo you've cloned this from.

3. Type in the following command:
```
rails server
```
This will start up the Ruby on Rails server.

4. Depending on your system, you may need to install certain libraries and source code packages for this website to run. This will be highlighted by an error message that has the following command:
```
bundle install
```
Run that command to install the required packages. Then repeat Step 3.

5. Wait for the terminal to say "Use Ctrl-C to stop" or something similar depending on the platform.

6. Open up any web browser (Internet Edge, Firefox, Google Chrome, etc.)

7. Type in the following in the URL bar and press enter: `https://127.0.0.0:3000`

8. Wait for the page to load; about 10 to 20 seconds. *Ruby on Rails needs to execute the controllers and parse the view templates first into HTML, CSS, and JavaScript, before they can be loaded onto your browser.*

9. Upon loading, you should see an interface consisting of multiple labels, radio buttons, combo boxes, and checkboxes. You can now do your hot dog stand searches!





## Credits

**DEVELOPMENT TEAM**

*Project Designer and Programmer*

Gregory P. Desrosiers


*Development Mentor*

David Pagurek van Mossel



**UNIVERSITY OF WATERLOO**

*Original SE 464 Instructor*

Werner Dietl


*Producer*

Derek Rayside


*Executive Producers*

Patrick Lam, Pearl Sullivan  


*President and Vice-Chancellor*

Feridun Hamdullahpur




**SPECIAL THANKS**

*External Influences*

Andrew Codispoti, Anish Chopra, Aaron Morais   
City of Toronto  
Toronto Transit Commission  


*Google Kitchener*

Caitlin McDonough


*Shopify, Inc.*

Allie Speers, Jenn Vanden Elzen


*GitHub, Inc.*

Veronica Ramirez, former 2016 Summer Interns


*Websites and QA*

[StackOverflow.com](https://stackoverflow.com/)  
[Ruby on Rails Guides](http://guides.rubyonrails.org)  


*Functionality Providers*

Yukihiro Matsumoto, inventor of Ruby  
David Heinemeir Hansson, inventor of Ruby on Rails  
World Wide Web Consortium  
Google, Inc.  
The Rails Community  
The Ruby on Rails Community  
The jQuery Foundation  


*Tools*

GitHub ATOM 1.25.0 x64  
jQuery 3.3.1  
Ruby 2.3.3p222 (2016-11-21 revision 56859)  
Ruby on Rails 5.1.5  
PostgreSQL 10.2, compiled by Visual C++ build 1800, 64-bit  
Google Chrome v65.0.3325.181  
Git v2.11.0.windows.1
Google Maps (for actual location coordinates)


*Version Control Systems*

GitHub, Inc.


*Follow me on [LinkedIn](https://www.linkedin.com/in/gregorydesrosiers/)*  
[https://gregpdessch.github.io](https://gregpdessch.github.io)


Google Maps, the API, the Directions API, and the Google logo are trademarks of Google. © 2018 Google.

Approved for academic use by the University of Waterloo and Google Inc.

Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
