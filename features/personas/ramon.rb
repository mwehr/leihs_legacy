# coding: UTF-8

# Persona:  Ramon
# Job:      Leihs Developer and Administrator
#
require "#{Rails.root}/features/support/leihs_factory.rb"

module Persona
  
  class Ramon
    
    @@name = "Ramon"
    @@lastname = "C."
    @@password = "password"
    @@email = "ramon@zhdk.ch"
    
    def initialize
      setup_dependencies
      
      ActiveRecord::Base.transaction do 
        create_minimal_setup
        create_admin_user
        create_inventory_pool_a_ausleihe
        create_inventory_pool_it_ausleihe
      end
    end
    
    def setup_dependencies 
      # no dependencies for ramon
    end
    
    def create_minimal_setup
      LeihsFactory.create_default_languages
      LeihsFactory.create_default_authentication_systems
      LeihsFactory.create_default_roles
      LeihsFactory.create_default_building
    end
    
    def create_admin_user
      @user = FactoryGirl.create(:user, :firstname => @@name, :lastname => @@lastname, :login => @@name.downcase, :email => @@email)
      @user.access_rights.create(:role => Role.find_by_name("admin"))
      @database_authentication = FactoryGirl.create(:database_authentication, :user => @user, :password => @@password)
    end
    
    def create_inventory_pool_a_ausleihe
      description = "Wichtige Hinweise...\n Bitte die Gegenstände rechtzeitig zurückbringen"
      contact_details = "A Verleih  /  ZHdK\nav@zh-dk.ch\n+41 00 00 00 00"
      FactoryGirl.create(:inventory_pool, :name => "A-Ausleihe", :description => description, :contact_details => contact_details, :contract_description => "Gerät erhalten", :email => "av@zhdk.ch", :shortname => "A")
    end
    
    def create_inventory_pool_it_ausleihe
      description = "Bringt die Geräte bitte rechtzeitig zurück"
      contact_details = "IT Verleih  /  ZHdK\nav@zh-dk.ch\n+41 00 00 00 00"
      FactoryGirl.create(:inventory_pool, :name => "IT-Ausleihe", :description => description, :contact_details => contact_details, :contract_description => "Gerät erhalten", :email => "it@zhdk.ch", :shortname => "IT")
    end
  end  
end
