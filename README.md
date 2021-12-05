## InstaFurniture

### Name | UNI
```
Member 1 Name: Duo Chen
Member 1 UNI:  dc3565
Member 2 Name: Hanwei Tang
Member 2 UNI:  ht2568
Member 3 Name: Minghui Zhao
Member 3 UNI:  mz2866
Member 4 Name: Yizhuo Wu
Member 4 UNI:  yw3689
```
### Install Ruby
```bash
# Install rbenv (NOTE: on mac, use `brew install rbenv`)
sudo apt install rbenv

# Install Ruby 2.6.6
rbenv install --verbose 2.6.6
rbenv global 2.6.6

# Add path to bashrc (NOTE: on mac, .bashrc should be replaced by .zshrc)
echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.bashrc

# Check that ruby version is 2.6.6
ruby -v

```
### Setting up (Instructions to run and test the project)
```bash
git clone https://github.com/zhaomh1998/InstaFurniture.git
cd InstaFurniture

# Resolve postgresql installation error
sudo apt install libpq-dev  # NOTE: on Mac, use `brew install postgresql` 

# Resolve ExecJS::RuntimeUnavailable: Could not find a JavaScript runtime
sudo apt install nodejs  # NOTE: on Mac, use `brew install node`

# (Mac only) Resolve mimemagic installation error 
brew install shared-mime-info

gem update bundler

bundle install
bundle exec rake db:migrate db:test:prepare db:seed
bundle exec rspec
bundle exec cucumber
```

#### API Keys
- Obtain API key from [mapquest](https://developer.mapquest.com/)
- Set up Google auth and obtain client id and client secret
- Set up Amazon S3 bucket and obtain region and bucket name; set up IAM user with S3FullAccess permission, obtain access key id, secret access key
- In the root directory, create a file named `.env` with following content
```
MAPQUEST_APIKEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
MAPQUEST_APIKEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
GOOGLE_CLIENT_ID=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
GOOGLE_CLIENT_SECRET=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
S3_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX
S3_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
S3_REGION=XX
S3_BUCKET=XX
DEVELOPMENT=1
```
For heroku deployment, use the following command to set the environment variable
```bash
heroku config:set MAPQUEST_APIKEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
heroku config:set GOOGLE_CLIENT_ID=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
heroku config:set GOOGLE_CLIENT_SECRET=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
heroku config:set S3_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX
heroku config:set S3_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
heroku config:set S3_REGION=XX
heroku config:set S3_BUCKET=XX
```

### Heroku Deployment
```bash
heroku create
# You should see heroku in `git remote -v`
# To remove a previous heroku remote, use `git remote rm heroku`
git push heroku main
# Note: To deploy from non-main branch, use
git push heroku <branch>:main

# Follow above "API Keys" to set up KEYs
heroku config:set XXX=XXXXX

# Initialize the databases
heroku run rake db:migrate db:seed

# To view any errors, use
heroku logs

# To use heroku terminal for any debugging or run rake commands, use
heroku run bash
```
### Heroku Demo Deployment
[ https://insta-furniture.herokuapp.com/](https://insta-furniture.herokuapp.com/)

### GitHub Repo
[https://github.com/zhaomh1998/InstaFurniture/tree/proj-demo](https://github.com/zhaomh1998/InstaFurniture/tree/proj-demo)

### User stories
As a student just arrive the campus,I have to go through the pain of moving in the new apartment, buying new furniture is expensive given that we only use them for one or two years, but for used ones, it’s difficult to find someone we trust on craigslist or facebook marketplace.
Thus I want to have access to a list of second-hard furniture that caters to my needs and is close to my neighborhood or campus.
So that I can purchase them within a very short period of time

As a student about to move out from the apartment, it’s not only a waste but also not environmentally-friendly to throw them away, furniture is not something we can throw in trash cans or dumpsters, sometimes we even need to pay for someone to dispose
Thus I want a platform that enables me to easily upload furniture item pictures, along with brief descriptions(title, labels, zip code) and contact information.
So that I can help find buyers who are interested in my used furniture and sell them, minimize the cost of disposing used furniture and protect the environment
