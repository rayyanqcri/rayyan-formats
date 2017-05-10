require "rayyan-formats/version"
require "rayyan-formats-core"
require "rayyan-formats-plugins"
require "rayyan-scrapers"
require 'logger'

module RayyanFormats
  class Command
    def initialize(args)
      # check arguments
      raise "Must provide input file name(s) as the first arguments followed by the output file name\n" +
            "USAGE: #{File.basename($0)} <input-file1> [<input-file2> [<input-file3> [...]]] <output-file>" \
            if args.length < 2

      @output_file = args.pop
      @input_files = args
      @ext = File.extname(@output_file).delete('.')

      raise "Output file name must have an extension" if @ext.empty?

      # configure RayyanFormats
      logger = Logger.new(STDERR)
      logger.level = Logger::WARN
      Base.logger = logger
      Base.plugins = Base.available_plugins
      Base.max_file_size = 1_073_741_824 # 1GB
    end

    def run
      begin
        plugin = Base.get_export_plugin(@ext)
        out, total, grand_total = File.open(@output_file, "w"), 0, 0
        @input_files.each do |input_filename|
          total = 0
          Base.import(Source.new(input_filename)) { |target|
            out.puts plugin.export(target, {include_abstracts: true})
            total += 1
          }
          grand_total += total
          $stdout.puts "Imported #{total} #{total == 1 ? 'entry' : 'entries'} from: #{input_filename}"
        end
        $stdout.puts "Exported #{grand_total} #{grand_total == 1 ? 'entry' : 'entries'} to: #{@output_file}"
      ensure
        out.close if out
      end
    end
  end
end
