Clone current project and install all dependencies

    git clone https://github.com/bscoder/chef-rails-demoserver.git demo-chef
    cd demo-chef
    bundle install
    librarian-chef install
    
add your public ssh_keys for user webmaster

    vim nodes/demo.json


prepare your new VDS

    knife solo bootstrap <my_vds>
    knife solo cook <my_vds> -N demo
