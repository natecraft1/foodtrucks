class TwitterController < ApplicationController

  def search
    # open-uri is necessary to be able to use the CGI::escape method
    require 'open-uri'
    
    # get our query from the url
    @query = CGI::escape params[:q]
    
    # the base url of the twitter search api
    # baseurl = 'https://api.twitter.com/1.1/search/tweets.json'
    baseurl = 'https://api.twitter.com/1.1/statuses/user_timeline.json'
    
    # build a request url using the user-specified query
    url = baseurl + '?screen_name=' + @query

    # initialize an empty array to hold the tweets
    @tweets = []
    
    # use the getTwitterData method to perform the request and return the response
    data = getTwitterData(url)
    #puts data
    
    # push each response into the @tweets array
    data.each do |status|
      unless status['geo'].nil?
            @tweets.push status
      end
    end
    render json: @tweets
    
    # get the url of the next page of results
    #next_page_url = data['search_metadata']['next_results']
    
    # build a url which we could use to get another page of data
    #url = baseurl + next_page_url

    # uncomment the next line to dump out @tweets as json for debugging
    # render json: @tweets
  end

  def getTwitterData (url)
    # define our app's public and private keys
    consumer_key = '0dwuDZkLEtJNotiBa5GHgg'
    consumer_secret = 'gML2Gr91KAHnnUi7c7Vi7ZWINx2FUIAOdUt6TSN8'
    
    # define our user access tokens
    access_token = '19741986-XevrLQiKjIPnsk3nVfazWHtZvaj1tfZZTvum2kmKx'
    access_token_secret = 'bnbgNUhyqtMtdL0yuxG27c6CfSarSbmdJQLSIIAdI'
    
    # instantiate a Consumer object using our app's keys
    consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {
      :site => 'https://api.twitter.com',
      :scheme => :header
    })
    
    # define an AccessToken object using a combination of our Consumer object and out access tokens
    request_wrapper = OAuth::AccessToken.from_hash(consumer,
      oauth_token: access_token,
      oauth_token_secret: access_token_secret
    )
    
    # send a GET request to the URL
    response = request_wrapper.request(:get, url)
    
    # parse the response as JSON and return it
    JSON.parse(response.body)
  end

end
