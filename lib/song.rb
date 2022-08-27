require 'pry'
class Song
    attr_accessor :name, :artist, :genre
    extend Concerns::Findable

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
    end
    
    def self.create(name)
        song = Song.new(name)
        song.save
        return song 
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

    def self.new_from_filename(filename)
        file = filename.split(" - ")
        artist = Artist.find_or_create_by_name(file[0])
        genre = Genre.find_or_create_by_name(file[2][0..-5])
        if self.find_by_name(file[1]).nil?
            song = Song.new(file[1], artist, genre)
        end
    end

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        song.save
        song
    end
end