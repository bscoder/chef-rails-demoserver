    git clone https://github.com/bscoder/chef-rails-demoserver.git demo-chef
    cd demo-chef
    bundle install

add your publics ssh_keys for user webmaster

    vim nodes/demo.json


    knife solo bootstrap <my_vds>
    knife solo cook <my_vds> -N demo
