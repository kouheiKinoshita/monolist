class ItemsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @items = [] #カラの配列として初期化
    
    @keyword = params[:keyword] #text_field_tag :keywordの検索ワードを取得
    if @keyword.present?
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })
      
      results.each do |result|
        item = Item.find_or_initialize_by(read(result))
        @items << item #itemを[]に追加していく
      end
    end  
  end
  
  def show
    @item = Item.find(params[:id])
    @want_users = @item.want_users
    @have_users = @item.have_users
  end
end
