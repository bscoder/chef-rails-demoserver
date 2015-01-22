    git clone https://github.com/bscoder/chef-rails-demoserver.git demo-chef
    cd demo-chef
    bundle install

    knife solo bootstrap <my_vds>
    knife solo cook <my_vds> -N demo
