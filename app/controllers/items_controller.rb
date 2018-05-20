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
        item = Item.new(read(result))
        @items << item #itemを[]に追加していく
      end
    end  
  end
  
  private
  
  def read(result)
    code = result["itemCode"]
    name = result["itemName"]
    url = result["itemUrl"]
    image_url = result["mediumImageUrls"].first["imageUrl"].gsub("?_ex=128x128", "")
    #gsubは第一引数を第二引数に置換するメソッド-> 画像を削除
    
    return {
      code: code,
      name: name,
      url: url,
      image_url: image_url,
    }
  end
end
