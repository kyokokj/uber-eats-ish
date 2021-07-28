module Api
  module V1
    class OrdersController < ApplicationController
      def create
        posted_orderings = Ordering.where(id: params[:ordering_ids])
        order = Order.new(
          total_price: total_price(posted_orderings),
        )
        if order.save_with_update_orderings!(posted_orderings)
          render json: {}, status: :no_content
        else
          render json: {}, status: :internal_server_error
        end
      end

      private

      def total_price(posted_orderings)
        posted_orderings.sum {|ordering| ordering.total_amount } + posted_orderings.first.restaurant.fee
      end
    end
  end
end
