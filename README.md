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

### Setting up (Instructions to run and test the project)
```bash
git clone git@github.com:zhaomh1998/InstaFurniture.git
cd InstaFurniture
bundle install
bundle exec rake db:migrate
bundle exec rake db:test:prepare
bundle exec rake db:seed
bundle exec rake rspec
bundle exec rake cucumber
```

### Heroku Demo Deployment
[https://obscure-tundra-88655.herokuapp.com/](https://obscure-tundra-88655.herokuapp.com/ )

### GitHub Repo
[https://github.com/zhaomh1998/InstaFurniture](https://github.com/zhaomh1998/InstaFurniture)
