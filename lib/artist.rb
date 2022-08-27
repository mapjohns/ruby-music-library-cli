class Artist
    attr_accessor :name
    extend Concerns::Findable

    @@all = []

    def initialize(name)
        @name = name
        # save
    end
    
    def self.create(name)
        artist = Artist.new(name)
        artist.save
        artist
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def songs
        Song.all.select {|song| song.artist == self}
    end

    def genres
        genres = []
        self.songs.each do |song|
            genres << song.genre if !genres.include?(song.genre)
        end
        genres
    end

    def add_song(song)
        if song.artist == nil && self.songs.include?(song) == false
            song.artist = self
        end
    end

    def new_song(name, genre)
        Song.new(name, self, genre)
    end
end