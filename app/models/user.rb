class User < ActiveRecord::Base
  authenticates_with_sorcery!
  # attr_accessible :title, :body

  attr_accessible :username, :email, :password, :password_confirmation

  has_many :reviews




  validates_length_of :password, :minimum => 6, :message => "password must be at least 6 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password

  validates :email, :uniqueness => true

  validates :email, :presence => true




  # def self.authenticate_regardless_of_activation_state(*credentials)
  #   raise ArgumentError, "at least 2 arguments required" if credentials.size < 2
  #   credentials[0].downcase! if @sorcery_config.downcase_username_before_authenticating
  #   user = find_by_credentials(credentials)

  #   set_encryption_attributes()

  #   _salt = user.send(@sorcery_config.salt_attribute_name) if user && !@sorcery_config.salt_attribute_name.nil? && !@sorcery_config.encryption_provider.nil?
  #   user if user && credentials_match?(user.send(@sorcery_config.crypted_password_attribute_name),credentials[1],_salt)
  # end

  def self.authenticate_regardless_of_activation_state(*credentials)
	  prevent_check = self.sorcery_config.before_authenticate.delete(:prevent_non_active_login)
	  user = self.authenticate(*credentials)
	  self.sorcery_config.before_authenticate << prevent_check if prevent_check
	  return user
  end


end
