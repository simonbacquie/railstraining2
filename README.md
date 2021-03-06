# README

Go into the application directory and type:

`up app`

(no, not really)

Check out `snippets.txt` in the root directory, that's pretty much all the commands we could be running. You can use it as a cheat sheet. I ran many of them for you already.

To get started ahead of time:

* `docker-compose build`

* `docker-compose up`

* install Postman if you don't have it already

* import RailsTraining2 Postman collection from this repo into Postman

To make sure the app is running, try `localhost:3000`. If it can't find the server, use `docker-machine ip` to figure out the IP, then use that instead of `localhost`. If you see a red ActiveRecord error saying database not found, you're good to go--we'll sort out the rest during the training.

In this training, we'll go over a Dockerized Rails setup provided by the ORATS project. We'll be working on a simple Rails API with JWT authentication, fill in some functionality, run a job, and write a new job. I'll also get to show you `pgcli`, which has been extremely useful for me lately.

You can think of this as the API backend that you could use for TodoMVC.
