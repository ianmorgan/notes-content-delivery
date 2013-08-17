require 'rubygems'
#require 'sinatra'
require 'sinatra/base'
#require 'rack-flash'
require 'erb'
require 'aws-sdk'

require 'yaml'
require "benchmark"
# require 'redcarpet'
#require 'pygments.rb'
#require 'rubypython'

#require File.join(File.dirname(__FILE__), 'modules/helpers')
#require File.join(File.dirname(__FILE__), 'modules/string_mixins')
require File.join(File.dirname(__FILE__), 'modules/aws')


class NotesContentDeliveryApp < Sinatra::Base
  #enable :sessions
  #use Rack::Flash  ,  :accessorize => [:notice, :error]
  
  #helpers NotesHelpers
  helpers AWSIntegration
  
  #cache_control :public, :must_revalidate, :no_cache

#helpers NotesHelpers
#RubyPython.start()

  get '/' do
    erb :home
  end


  get '/content/:topic/:key' do 
    content = retrieve_by_key(params[:topic], params[:key])
    content  
  end

  get '/about' do 
    erb :about
  end

  not_found do
    erb :page_not_found
  end

end