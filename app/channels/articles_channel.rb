class ArticlesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'articles'
  end
end
