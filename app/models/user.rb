require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
 
  
  apply_simple_captcha :message => "image and text were different", :add_to_base => true
  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  has_many :entries, :dependent => :destroy
  has_many :events
  
  #    :after_add => :say_hello,
  #    :before_remove => :say_goodbye

  before_create :make_activation_code 

  
  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :password_reset_code
  
  #重置密码
  def forgot_password
    @forgotten_password = true
    self.make_password_reset_code
  end

  def reset_password
    # First update the password_reset_code before setting the
    # reset_password flag to avoid duplicate email notifications.
    update_attributes(:password_reset_code => nil)
    @reset_password = true
  end

  def recently_forgot_password?
    @forgotten_password
  end

  def recently_reset_password?
    @reset_password
  end

  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  protected
    
  #激活码
  def make_activation_code
  
    self.activation_code = self.class.make_token
  end
  #重置码
  def make_password_reset_code
    self.password_reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end

  #say_method
  #  private
  #
  #  def say_hello(event)
  #    STDOUT.write("hello #{event.title} ")
  #  end
  #
  #  def say_goodbye(event)
  #    STDOUT.write("goodbye #{event.title} ")
  #  end
#  class Fixnum
#    def prime?
#      ('1' * self) !~ /^1?$|^(11+?)\1+$/
#    end
#  end


end
