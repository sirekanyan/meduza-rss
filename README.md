# meduza-rss
Full-Text RSS Feed for Meduza.io Website

This app can be deployed on your own server.

For example, you can use free [heroku](https://heroku.com) account to deploy it:
- Clone this repository: ``git clone https://github.com/sirekanyan/meduza-rss.git``
- Install command line tool for heroku from https://toolbelt.heroku.com/
- Create new ruby app and deploy it https://devcenter.heroku.com/articles/git
  - ``heroku git:remote a YOUR-APP-NAME``
  - ``git push heroku master``
- You may use [this service](https://uptimerobot.com/) to prevent heroku application from sleeping
