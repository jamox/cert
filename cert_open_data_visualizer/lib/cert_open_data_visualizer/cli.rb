module CertOpenDataVisualizer
  class CLI
    attr_accessor :argv

    def initialize(argv)
      @argv = argv
    end

    def start
      visualizer = CertDataVisualizer.new
      commands = {fetch: "fetch!",
                  clean: "clean_cache!",
                  crear: "clean_cache!",
                  first: "print_first_format",
                  second: "print_second_format",
                  app: "start-app",
                  city: "filter_by_city",
                  v: "version",
                  version: "version",
                  help: "print_help"}

      return help if @argv[0].nil?
      command = @argv.shift.to_sym

      exec = commands[command]

      return run_app if exec == "start-app"
      return print_version if exec == "version"
      return help if exec == "print_help"
      return visualizer.send(exec, *argv) if exec
      puts "Invalid command #{command}"
    end


    def help
      puts <<EOF
CertOpenDataVisualizer
Commands are:
  first  - prints results in format required for first print
  second - prints results in format required for second print
  help   - shows this
  clean  - cleanes cache
  fetch  - fetches new data if neccessary
  app    - launces web server for visualizations in http://127.0.0.1:4567
  city   - `city hel` - list details for each city containing `hel`

Commands may download and parse data when neccesary.

A file cache is utilised for faster results.
ie. information is calculated only when necessary, and cached for
further use. Cache may be cleared using `clean`
EOF
    end

    def print_version
      puts CertOpenDataVisualizer::VERSION
    end

    def run_app
      CertOpenDataVisualizer::Frontend::App.run!
    end

  end
end

