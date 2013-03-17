require 'detroit-standard'

module Detroit

  #
  class Erbside < Tool

    system :standard

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

    # Render templates.
    def generate
      options = {}
      options[:prompt]  = prompt
      options[:exclude] = exclude
      options[:ignore]  = ignore

      ::Erbside::Runner.new(path, options).render
    end

    #  A S S E M B L Y  M E T H O D S

    #
    def assemble?(station, options={})
      case station
      when :generate then true
      end
    end

    # Attach to `generate` station.
    def assemble(station, options={})
      case station
      when :generate then generate
      end
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
