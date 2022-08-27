class Genre
    attr_accessor :name
    extend Concerns::Findable

    @@all = []

    def initialize(name)
        @name = name
        # save
    end
    
    def self.create(name)
        genre = Genre.new(name)
        genre.save
        genre
    end

    def save
        @@all << self
    end

    def songs
        Song.all.select {|song| song.genre == self}
    end

    def artists
        artists = []
        self.songs.each do |song|
            artists << song.artist if !artists.include?(song.artist)
        end
        artists
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

end