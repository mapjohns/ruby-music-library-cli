class MusicImporter

    def initialize(path)
        @path = path
    end

    def path
        @path
    end

    def files
        Dir.each_child(@path).select {|file| file.match(/.mp3/)}
    end

    def import
        files.each do |file|
            Song.create_from_filename(file)        
        end
    end
end