class User < ActiveRecord::Base
  has_many :tried_beer_types
  has_many :beer_types, through: :tried_beer_types
  has_many :user_flavors
  has_many :flavors, through: :user_flavors
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  def recommend_liked_beer
    #This will recommend a type the user enjoys.
  end

  def recommend_new_beer
    # Code goes here to recommend this users a new untried beer
  end

  # Input Array of Fav Id's, No output, Save all flavors
  def collect_user_flavors(flavor_ids)
    # flavor_ids = [2, 3, 5, 6, 7]
    # Take clicked flavors and create UserFlavor table entries
    user = self
    flavor_ids.each do |f_id|
      flavor = Flavor.find(f_id)
      UserFlavor.create(flavor: flavor, user: user)
    end
  end

  def wheel_data_user_data
    # Take general data for wheel as well as user data and return for wheel
  end


  def taged_types_and_rating_them_return(tagged_type_ids, rating, comment)
    had_a_new_beer(tagged_type_ids, rating, comment)
    return BeerType.descriptions_for_drank_type(tagged_type_ids)
  end

  private

  def had_a_new_beer(tagged_type_ids, rating, comment)
    rating = TriedBeerRating.create(rating: rating, comment: comment, user: self)
    tagged_type_ids.each do |type_id|
      RatingBeerType.create(beer_type_id: type_id, tried_beer_rating: rating)
    end
  end

end





