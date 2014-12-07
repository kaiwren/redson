module Redson
  class Logger
    attr_accessor :level
    
    DEBUG = 1
    INFO = 2
    WARN = 3
    ERROR = 4
    FATAL = 5
    UNKNOWN = 6
    
    STRING_MAP = {
      1 => 'D',
      2 => 'I',
      3 => 'W',
      4 => 'E',
      5 => 'F',
      6 => 'U'
    }
    def initialize
      self.level = DEBUG
    end
    
    def d(message)
      log(DEBUG, message)
    end
    
    def i(message)
      log(INFO, message)
    end
    
    def w(message)
      log(WARN, message)
    end
    
    def e(message)
      log(ERROR, message)
    end
    
    def f(message)
      log(FATAL, message)
    end
    
    def u(message)
      log(UNKNOWN, message)
    end
    
    def log(severity, message)
      if(severity >= @level)
        code = STRING_MAP[severity]
        `console.log(code + ' | ' + Date.now() + ' | ' + message)`
      end
    end
  end
  
  class NullLogger
    attr_accessor :level
    def d(message);end
    def i(message);end
    def w(message);end
    def e(message);end
    def f(message);end
    def u(message);end
    def log(severity, message);end
  end
  
  @_redson_logger = Logger.new
  
  def self.mute_logger!
    @_redson_logger = NullLogger.new
  end
  
  def self.logger
    self.l
  end
  
  def self.l
    @_redson_logger
  end
end