module Api
  module V1
    class OrderingsController < ApplicationController
      before_action :set_food, only: %i[create replace]

      def index
        orderings = Ordering.active
        if orderings.exists?
          render json: {
            orderings_ids: orderings.map { |orderings| orderings.id },
            restaurant: orderings[0].restaurant,
            count: orderings.sum { |orderings| orderings[:count] },
            amount: orderings.sum { |orderings| orderings.total_amount },
          }, status: :ok
        else
          render json: {}, status: :no_content
        end
      end
      
      def create
        if Ordering.active.other_restaurant(@ordered_food.restaurant.id).exists?
          return render json: {
            existing_restaurant: Ordering.other_restaurant(@ordered_food.restaurant.id).first.restaurant.name,
            new_restaurant: Food.find(params[:food_id]).restaurant.name,
          }, status: :not_acceptable
        end

        set_ordering(@ordered_food)

        if @ordering.save
          render json: {
            ordering: @ordering
          }, status: :created
        else
          render json: {}, status: :internal_server_error
        end
      end

      def replace
        Ordering.active.other_restaurant(@ordered_food.restaurant.id).each do |ordering|
          ordering.update_attribute(:active, false)
        end

        set_ordering(@ordered_food)

        if @ordering.save
          render json: {
            ordering: @ordering
          }, status: :created
        else
          render json: {}, status: :internal_server_error
        end
      end





      private

      def set_food
        @ordered_food = Food.find(params[:food_id])
      end

      def set_ordering(ordered_food)
        if ordered_food.ordering.present?
          @ordering = ordered_food.ordering
          @ordering.attributes = {
            count: ordered_food.ordering.count + params[:count],
            active: true
          }
        else
          @ordering = ordered_food.build_ordering(
            count: params[:count],
            restaurant: ordered_food.restaurant,
            active: true
          )
        end
      end
    end
  end
end
