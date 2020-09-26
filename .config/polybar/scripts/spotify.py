#!/usr/bin/env python3
import dbus

if __name__ == '__main__':
    try:
        session_bus = dbus.SessionBus()
        spotify_bus = session_bus.get_object("org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2")

        spotify_properties = dbus.Interface(spotify_bus, "org.freedesktop.DBus.Properties")
        metadata = spotify_properties.Get("org.mpris.MediaPlayer2.Player", "Metadata")

        artist = metadata['xesam:artist'][0]
        song = metadata['xesam:title']

        if len(song) > 25:
            song = song[0:25] + '...'
            if ('(' in song) and (')' not in song):
                song += ')'

        output = artist + ': ' + song
        print(output)
    except:
        print("")
