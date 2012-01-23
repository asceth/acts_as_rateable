class Rating < ActiveRecord::Base
  belongs_to :rateable, :polymorphic => true
  belongs_to :user
  validates_presence_of :score
  validates_uniqueness_of :user_id, :scope => [:rateable_id, :rateable_type, :category, :tag, :facet]
  validate :max_rating_allowed_by_parent

  def key
    "#{category}_#{tag}_#{facet}"
  end

  private

  def max_rating_allowed_by_parent
    if score < 1
      errors.add(:score, "must be greater than or equal to 1")
    elsif score > max_rating
      errors.add(:score, "must be less than or equal to #{max_rating}")
    end
  end

  def rateable_options
    rateable.ratings.options
  end

  def max_rating
    rateable_options[:max_rating]
  end
end
