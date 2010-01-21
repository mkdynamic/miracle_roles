# Miracle Roles

A dead simple roles plugin for Rails. 

## Install

### 1 &mdash; Get the gem

Add the dependency to your config/environent.rb:

    Rails::Initializer.run do |config|
      ...
      config.gem "miracle_roles"
      ...
    end
  
Now install it

    sudo rake gems:install

### 2 &mdash; Add :roles column to model

Generate a migration to add column to your model (Users, in this example):

    script/generate migration add_roles_to_users
  
Then in the migration that's generated, define the following:

    class AddRolesToUsers < ActiveRecord::Migration
      def self.up
        add_column :users, :roles, :string
      end
  
      def self.down
        remove_column :users, :roles
      end
    end
  
### 3 &mdash; Include module and define roles

Include the Miracle::Roles in your model:

    class User < ActiveRecord::Base
      include Miracle::Roles
      define_roles :admin, :supervisior, ...
      
      ...
    end
  
## Usage

Now you can manage roles in any of the following ways:

    @user.add_role(:admin)
    @user.remove_role(:admin)
    @user.roles = [:admin, :supervisor]
  
Enjoy!

~ Mark Dodwell (<a href="http://twitter.com/madeofcode">@madeofcode</a>)