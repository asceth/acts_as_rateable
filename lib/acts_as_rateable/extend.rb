module ActsAsRateable
  module Extend
    def self.included(base)
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)

      base.class_eval do
        has_many :ratings, :as => :rateable, :dependent => :delete_all
        @acts_as_rateable_options = {:max_rating => 5}
      end
    end

    module ClassMethods
      def acts_as_rateable(options = {})
        @acts_as_rateable_options.merge!(options)
      end

      def acts_as_rateable_options
        @acts_as_rateable_options
      end
    end

    module InstanceMethods
      # Rates the object by a given score. A user id should be passed to the method.
      def rate_it(score, user_id, opts = {})
        returning(ratings.find_or_initialize_by_user_id(user_id, :conditions => opts)) do |rating|
          rating.update_attributes!(opts.merge(:score => score))
        end
      end

      # Calculates the average rating. Calculation based on the already given scores.
      def average_rating(opts = {})
        @cache ||= {}
        @cache["#{opts[:category]}_#{opts[:tag]}_#{opts[:facet]}"] ||= (ratings.average(:score, :conditions => opts) || 0.0)
      end

      # Rounds the average rating value.
      def average_rating_round(opts = {})
        average_rating(opts).round
      end

      # Returns the average rating in percent.
      def average_rating_percent(opts = {})
        (average_rating(opts) / ratings.max_rating.to_f) * 100
      end

      # Checks whether a user rated the object or not.
      def rated_by?(user_id, opts = {})
        ratings.exists?(:user_id => user_id, :conditions => opts)
      end

      # Returns the rating a specific user has given the object.
      def rating_by(user_id, opts = {})
        rating = ratings.find_by_user_id(user_id, :conditions => opts)
        rating ? rating.score : nil
      end
    end # InstanceMethods
  end
end

