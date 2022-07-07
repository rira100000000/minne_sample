class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:tag_id])
    @ordertags =OrderTag.where(tag_id: @tag.id)
    @order_ids = @ordertags.map {|n| n.order_id}
    @orders = @order_ids.map{|n| Order.find(n)}
  end
end
