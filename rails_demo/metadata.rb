name             'rails_demo'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures rails_demo'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'


depends 'apt'
depends 'apache2'
depends 'mysql'
depends 'postgresql'
depends 'build-essential'
depends 'git'
depends 'rvm'
depends 'swap'
