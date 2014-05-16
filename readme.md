# Minimart

A web site and relational database to support a simple shopping cart system.

## Install

Unzip the attached file or 

    git clone git@github.com:darkoverlordofdata/minimart.git


*First*, you'll need to set up the Sql database. In Sql Server Mgmt Studio or in the Sql Server Explorer window in visual studio, connect to your sql server, and create a new database - the name doesn't matter, just note it for later. Open a new query window, paste the contents of minimart\Minimart\create.db.sql into the query window and select execute. 

Using the database name from above, construct your sql connection string. .

* As an example, PaaS generally uses a connection string formatted like this:

    Server=myServerAddress;Database=myDataBase;User ID=nyUserName;Password=myPassword;

* If you are using integrated security, use a connection string formatted like this:

    Driver={SQL Server Native Client 11.0};Server=myServerAddress; Database=myDataBase;Trusted_Connection=yes;

*Next*, set the application to use this Sql connection:
* copy minimart\Minimart\Web.template.config to minimart\Minimart\Web.config
* copy minimart\Minimart.Tests\App.template.config to minimart\Minimart.Tests\App.config
* In both config files, replace the token $CONNECTION_STRING$ with the new connection string value.

*Last*, deploy to IIS:
* In VS, right click on the Minimart project.
* Select Publish...
* Enter or select the appropriate connection settings for your environment
* Click Publish



## License

(The MIT License)

Copyright (c) 2014 Bruce Davidson &lt;darkoverlordofdata@gmail.com&gt;

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.