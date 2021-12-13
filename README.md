## InstaFurniture

At InstaFurniture, we are aiming to make used furniture trading more safe and efficient for Columbia students. Check out
our demo at [YouTube](https://youtu.be/V18nBwmLKLc)!

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

#### MacOS

```bash
# Install rbenv
brew install rbenv
echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.zshrc
brew install ruby-build

# Check rbenv installation -- make sure everything is OK
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash

# Install Ruby 2.6.6
rbenv install --verbose 2.6.6
rbenv global 2.6.6

# Check that ruby version is 2.6.6
ruby -v
```

#### Linux

```bash
# Install rbenv
sudo apt install rbenv
echo 'export PATH="$HOME/.rbenv/shims:$PATH"' >> ~/.bashrc
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# Check rbenv installation -- make sure everything is OK
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash

# Install Ruby 2.6.6
rbenv install --verbose 2.6.6
rbenv global 2.6.6

# Check that ruby version is 2.6.6
ruby -v
```

### Setting up (Instructions to run and test the project)

#### 1. Clone repo, install gems and dependencies

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
```

#### 2. Set up API Keys

Make sure you added a `.env` file in the project root directory following instructions in [API Keys](#API-Keys)

#### 3. Setup db and run tests

```bash
bundle exec rake db:migrate db:test:prepare db:seed
bundle exec rspec
bundle exec cucumber
```

#### API Keys

- Obtain API key from [mapquest](https://developer.mapquest.com/)
- Set up Google auth and obtain client id and client secret
- Set up Amazon S3 bucket and obtain region and bucket name; set up IAM user with S3FullAccess permission, obtain access
  key id, secret access key
- In the project root directory, create a file named `.env` with following content

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

For heroku deployment, make sure [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) is installed. Then, use
the following command to set the environment variable

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

First, make sure [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) is installed.

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

[https://insta-furniture.herokuapp.com/](https://insta-furniture.herokuapp.com/)

### GitHub Repo

[https://github.com/zhaomh1998/InstaFurniture](https://github.com/zhaomh1998/InstaFurniture)
