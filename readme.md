# Minimart

A web site and relational database to support a simple shopping cart system.

## Install

git clone git@github.com:darkoverlordofdata/minimart.git

set sql connection string.

	for example:

	Server=sqlserver.sequelizer.com;Database=db0123456789;User ID=user;Password=reallylongpassword;


	copy Minimart\Web.template.config to Minimart\Web.config

	copy Minimart.Tests\App.template.config to Minimart.Tests\App.config

	In both config files, replace the token $CONNECTION_STRING$ with the connection string value.

	In the Sql Server Explorer window in visual studio, connect to the same server, and open a new query.

	Paste Minimart\create.db.sql into the query window and execute. 



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