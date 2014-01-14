require 'detroit-standard'

module Detroit

  ##
  # Erbside tool is an inline templating tool for source code.
  # It can be useful for keeping information uptodate that is 
  # static in code, but dynamic to the project itself. A good
  # example a `VERSION` constant.
  #
  #     module MyApp
  #       VERSION = "1.2.0"  #:erb: VERSION = "<%= version %>"
  #       ...
  #
  class Erbside < Tool

    # Designed to work with the standard assembly. This tool
    # attaches to `generate` station.
    #
    # @!parse
    #   include Standard
    #
    assembly Standard

    # Loction of manpage for tool.
    MANPAGE = File.dirname(__FILE__) + '/../man/detroit-erbside.5'

    # Load requirements and set attribute defaults.
    #
    # @return [void]
    def prerequisite
      require 'erbside'
      require 'shellwords'

      @path = 'lib'
    end

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

    # Metadata resources, default is project metadata.
    attr_accessor :resources

    # Alias for resources.
    alias_accessor :resource, :resources

    # Render templates.
    def generate
      options = {}
      options[:prompt]    = prompt
      options[:exclude]   = exclude
      options[:ignore]    = ignore
      options[:resources] = resources || metadata

      ::Erbside::Runner.new(path, options).render
    end

    # This tool ties into the `generate` station of the standard
    # assembly.
    #
    # @return [Boolean]
    def assemble?(station, options={})
      return true if station == :generate
    end

  private

    # If project metadata responds to `#to_h` then we can us it.
    def metadata
      data = super
      if data.respond_to?(:to_h)
        data.to_h
      else
        nil
      end
    end

    #
    #def files
    #  amass(path, exclude, ignore)
    #end

  end

end
