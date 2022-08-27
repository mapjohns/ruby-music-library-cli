class MusicLibraryController

    def initialize(path="./db/mp3s")
        MusicImporter.new(path).import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        input = gets.chomp()
        list_songs if input == "list songs"
        list_artists if input == "list artists"
        list_genres if input == "list genres"
        list_songs_by_artist if input == "list artist"
        list_songs_by_genre if input == "list genre"
        play_song if input == "play song"
        until input == "exit"
            input = gets.chomp()
        end
    end

    def list_songs
        s_music = Song.all.sort_by {|s| s.name}
        counter = 1
        s_music.each do |song|
            puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            counter += 1
        end
    end

    def list_artists
        a_music = Artist.all.sort_by {|a| a.name}
        counter = 1
        a_music.each do |artist|
            puts "#{counter}. #{artist.name}"
            counter += 1
        end
    end

    def list_genres
        g_music = Genre.all.sort_by {|g| g.name}
        counter = 1
        g_music.each do |genre|
            puts "#{counter}. #{genre.name}"
            counter += 1
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp()
        artist = Artist.find_by_name(input)
        if artist
            counter = 1
            a_music = artist.songs.sort_by {|a| a.name}
            a_music.each do |song|
                puts "#{counter}. #{song.name} - #{song.genre.name}"
                counter += 1
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp()
        genre = Genre.find_by_name(input)
        if genre
            counter = 1
            g_music = genre.songs.sort_by {|g| g.name}
            g_music.each do |song|
                puts "#{counter}. #{song.artist.name} - #{song.name}"
                counter += 1
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.chomp()
        if input.to_i >= 1 && input.to_i <= Song.all.size
            s_music = Song.all.sort_by {|s| s.name}
            song = s_music[input.to_i-1]
            puts "Playing #{song.name} by #{song.artist.name}"
        end
    end
end