require 'rvideo'
class Asset < ActiveRecord::Base
  # belongs_to :creation
  belongs_to :item, :polymorphic => true

  STD_WIDTH = 480

  # Paperclip
  has_attached_file :item,
  :default_url => "/images/portfolio/waiting.gif",
  :styles => {
    :tiny   => ["90x90#", "jpg"],
    :thumb  => ["57x57#", "jpg"],
    :small  => ["130x90#", "jpg"],
    :preview => ["188x145#", "jpg"]
  }

  # Acts as State Machine
  # http://elitists.textdriven.com/svn/plugins/acts_as_state_machine
  acts_as_state_machine :initial => :pending

  state :pending
  state :converting
  state :converted, :enter => :set_new_filename
  state :error
  state :done

  event :convert do
    transitions :from => :pending, :to => :converting
  end

  event :is_picture do
    transitions :from => :pending, :to => :done
  end
  
  event :ready do
    transitions :from => :converted, :to => :done
  end

  event :converted do
    transitions :from => :converting, :to => :converted
  end

  event :failed do
    transitions :from => :converting, :to => :error
  end

  # This method is called from the controller and takes care of the converting
  def convert
    self.convert!
    success = system(convert_command)
    
    logger.info "Success: " + success
    
    exit_status = $?.exitstatus
    
    logger.info "Exit status: " + exit_status
    
    if success && exit_status == 0
      self.converted!
      self.item.reprocess_for_video_thumnbails!
      self.ready!
    else
      self.failed!
    end
  end
  
  def url(style = :original)
    unless done?
      "/images/waiting-#{style}.gif"
    else
      item.url(style)
    end
  end

  protected

  # This method creates the ffmpeg command that we'll be using
  def convert_command
    if ENV['RAILS_ENV'] == "production" || ENV['RAILS_ENV'] == "staging"
      file = RVideo::Inspector.new(:file => item.path, :ffmpeg_binary => '/usr/local/bin/ffmpeg')
    else
      file = RVideo::Inspector.new(:file => item.path)
    end
    
    logger.info "ItemPath: " + item.path
    logger.info "File.debug: #{file.to_yaml}"
    logger.info "File.height: " + file.height.to_s
      
    height_to = ((STD_WIDTH*file.height)/file.width).floor
    
    flv = File.join(File.dirname(item.path), "#{id}.flv")
    File.open(flv, 'w')

    command = <<-end_command
    ffmpeg -i #{ item.path }  -ar 22050 -ab 32 -acodec libmp3lame
    -s #{ STD_WIDTH }x#{ height_to } -vcodec flv -r 25 -qscale 8 -f flv -y #{ flv }
    end_command
    
    logger.info "Command: " + command
    
    command.gsub!(/\s+/, " ")
  end

  # This update the stored filename with the new flash video file
  def set_new_filename
    File.delete item.path
    update_attribute(:item_file_name, "#{id}.flv")
  end

end
