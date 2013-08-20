require 'rubygems'
#require 'sinatra'
require 'sinatra/base'
#require 'rack-flash'
require 'erb'
require 'json'
require 'aws-sdk'

require 'yaml'
require "benchmark"
# require 'redcarpet'
#require 'rubypython'

require File.join(File.dirname(__FILE__), 'modules/aws')
require File.join(File.dirname(__FILE__), 'modules/elastic_search')


class NotesContentDeliveryApp < Sinatra::Base

  
  #helpers NotesHelpers
  helpers AWSIntegration
  helpers ElasticSearchIntegration
  

  get '/' do
    erb :home
  end

  get '/content/:topic/:slug' do 
    content = retrieve_by_key(params[:topic], params[:slug])
    content  
  end
  
  get '/slugs/:topic' do 
     slugs = all_slugs_for_topic(params[:topic])
     slugs.to_json  
   end
   
  get '/topics' do
     { 'java' => 'Java', 
       'scala' => 'Scala',
       'ruby' => 'Ruby',
       'unix' => 'Unix',
       'html' => 'HTML',
       'design' => 'Design',
       'functional-programming' => 'Functional Programming'
       }.to_json   
      
  end

  get '/about' do 
    erb :about
  end

  not_found do
    erb :page_not_found
  end

end