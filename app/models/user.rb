class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :trackable, :validatable

  serialize :latest_feed
  has_many :posts

  has_many :recruitments
  has_many :recruits, :through => :recruitments

  validates_presence_of :provider
  validates_presence_of :uid

  def self.from_omniauth(auth, params)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth, params)
  end

  def self.create_from_omniauth(auth, params)
    create! do |user|
      user.provider = auth["provider"]
      user.access_token = auth['credentials']['token']
      user.uid = auth["uid"]
      user.first_name = auth["info"]["first_name"]
      user.last_name = auth["info"]["last_name"]
      user.username = auth["info"]["nickname"]
      user.email = auth["info"]["email"]
      user.password = Devise.friendly_token[0,20]
      if auth['extra']
        if auth['raw_info']
          if auth['education']
            auth['extra']['raw_info']['education'].each do |school|
              if school['type'] == 'College'
                user.concentration = school['concentration'][0]['name'] if school['concentration']
                user.college = school['school']['name'] if school['school']
                break
              end
            end
          end
        end
      end

      User.find(params['id']).recruits << user if params['id'] 
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

end
