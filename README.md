### Automating application deployment using bash script
The script in the `automate.sh` is meant to enable the automation of deployment
of a node frontend application that uses yarn as the package manager to a **nginx server** in an Ubuntu machine.
The script is commented but I'll just give a brief description of how to use the script to deploy a frontend application written in node to an nginx and make everything work as required.
#### Requirements
The script is tested only on the LTS versions of ubuntu from **14.04** to **18.04**, so to run the scripts, you must be on an ubuntu machine for everything to work fine.
 - Ubuntu 14.04 or later

#### Using the script
First of all you need to clone the repo using,
``` bash
   git clone https://github.com/silaskenneth/automatescripts
```
To use the script, first set your `GITHUB_REPO` in a `.env` file from the `.env.example` file, then run `source .env` to export the variables in the file.
For instance to add this repo to your environment, in the `.env` file input the following.
``` bash
    export GITHUB_REPO=https://github.com/silaskenneth/automatescripts 
```

After the above step, navigate to the automatescripts directory and run 

``` bash
 bash automate.sh

 ```
 and wait for the application to build.

 After it is done just head to your `/var/www/html` you'll notice 2 new files generated in the directory that is,
  - `bundle.js`
  - `index.html`

  You can now navigate to your browser on `localhost` to confirm that everything worked by seeing your application show up on the browser.
