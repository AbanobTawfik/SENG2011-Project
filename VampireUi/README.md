Vampire Frontend
================


## Getting Started

Hopefully this guide will help you successfully run the Angular app!


### Requirements

- Some variant of Linux with Node.js 10.x installed.
  I use elementary OS (Ubuntu 18.04 LTS).
  - Run `node -v`. If it outputs something like `v10.17.0`, you're good! Otherwise, run:
    - `curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash`
  - This will add a source file for the official Node.js 10.x repo, grab the signing key and run `apt update`.  
    Once the installer has completed, install (or upgrade) Node.js:
    - `sudo apt install nodejs`
  - Finally, run `node -v` to verify whether the installation was successful.
- The latest version of Angular CLI **7** installed.
  - Run `ng version`. If it shows something like `Angular CLI: 7.3.9`, you're good! Otherwise, run:
    - `npm install -g @angular/cli@7.3.9`
  - g stands for global installation. We include it so we can use the CLI in any Angular project later.  
    After the installation is completed, run `ng version` to verify whether the installation was successful.


If you are using Microsoft Windows, then figuring out
how to setup Angular is left as an exercise to the reader! :stuck_out_tongue_winking_eye:  
Although ensure that you install Angular CLI **7** (not 8) to avoid any dependency issues.

Once NPM and Angular CLI are both installed, simply run:
```
npm install
```
This will install the packages from `package.json` into a `node_modules` folder.


## Run Server

```
ng serve
```

