Vampire Front End
=================


## Getting Started

Hopefully this guide will help you successfully run the Vampire web server!


### Requirements

- Some variant of Linux with Node.js 10+ installed.
  I use elementary OS (Ubuntu 18.04 LTS).
  - Run `node -v`. If it outputs something like `v10.17.0`, you're good!  
    If you have a different version, it may still be compatible (not tested). If not, run:
    - `curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash`
  - This will add a source file for the official Node.js 10.x repo, grab the signing key and run `apt update`.  
    Once the installer has completed, install (or upgrade) Node.js:
    - `sudo apt install nodejs`
  - Finally, run `node -v` to verify whether the installation was successful.
- A recent version of .NET Core **SDK 2.2.x** installed.
  - Run `dotnet --version`. If it outputs something like `2.2.402`, you're good! Otherwise:
    - Follow the installation instructions here: [Ubuntu/Linux](https://dotnet.microsoft.com/download/linux-package-manager/ubuntu18-04/sdk-2.2.402 "SDK 2.2.402") | [Windows/macOS](https://dotnet.microsoft.com/download/dotnet-core/2.2 "SDK 2.2.402")
  - After the installation has completed, run `dotnet --version` to verify whether the installation was successful.
- Microsoft SQL Server 2017 Express running (not tested with 2019 or other servers).
  - If you prefer to run the server in a container, first install Docker: [Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04) | [macOS](https://database.guide/how-to-install-sql-server-on-a-mac/)
    - If you have &lt; 2GB RAM (like me :disappointed:), use: [mssql_server_tiny](https://github.com/justin2004/mssql_server_tiny#how-to-use)
    - Otherwise, run: `sudo docker pull microsoft/mssql-server-linux:2017-latest`
    - and then run: `sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Pa5sw0rD' -p 1433:1433 -d microsoft/mssql-server-linux`
  - If you prefer to run the server directly, follow the "Install SQL Server" instructions: [Ubuntu](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-2017) | [Linux](https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup?view=sql-server-ver15)
  - (Optional) Install Azure Data Studio (SSMS alternative) to keep track of the database: [Azure Data Studio](https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-ver15)
  - Now run `ss -tulpn | grep :1433`. If it outputs something like `tcp LISTEN`, the server is running!
  - If you are using Docker, navigate to the VampireBackEnd folder and open `appsettings.Development.json`
    - Change `ConnectionString` to `"Server=localhost,1433\\SQLEXPRESS;Database=Vampire;User=sa;Password=Pa5sw0rD;"`
  - Finally, update the database by running `dotnet ef database update` in the VampireBackEnd folder.
    - You may need to run this again if Bob decides to make changes to the database.


If you are using Microsoft Windows, then figuring out
how to install everything is left as an exercise to the reader! :stuck_out_tongue_winking_eye:

Once NPM and .NET Core SDK are successfully installed, simply run:
```
npm install
```
This will install the packages from `package.json` into a `node_modules` folder.


## Run Server

After running `npm install` and the SQL server, start the web server:

```
./start
```

To start only the front end server, run:

```
npm start
```

### Common Issues

- Getting `net::ERR_CERT_AUTHORITY_INVALID` errors when making API requests?
  - Navigate to [localhost:5000](http://localhost:5000) in your browser and accept accept the certificate

