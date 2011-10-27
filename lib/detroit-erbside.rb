require 'detroit/tool'

module Detroit

  #
  class Erbside < Tool

    #  A T T R I B U T E S

    # Paths of lifes to render.
    attr_accessor :path

    # Alias for `path`.
    alias_accessor :include, :path

    # Exclude subpaths from `path`.
    attr_accessor :exclude

    # Exclude subpaths from `path` by matching basename.
    attr_accessor :ignore

    # Prompt on each write.
    attr_accessor :prompt


    #  A S S E M B L Y  S T A T I O N S

    #
    def station_generate
      generate
    end

    #  S E R V I C E  M E T H O D S

    # Render templates.
    def generate
      options = {}
      options[:prompt]  = prompt
      options[:exclude] = exclude
      options[:ignore]  = ignore

      ::Erbside::Runner.new(path, options).render
    end

  private

    #
    #def files
    #  amass(path, exclude, ignore)
    #end

    #
    def initialize_requires
      require 'erbside'
      require 'shellwords'
    end

    #
    def initialize_defaults
      @path = 'lib'
    end

  public

    def self.man_page
      File.dirname(__FILE__)+'/../man/detroit-erbside.5'
    end

  end

end
