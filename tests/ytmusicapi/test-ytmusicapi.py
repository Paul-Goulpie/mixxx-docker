#!/usr/bin/env python3

from ytmusicapi import YTMusic

from ytmusicapi import OAuthCredentials

client_id = 'XXXXXXXXXXXXXXXXXXXXXXX'
client_secret = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

ytmusic = YTMusic('oauth.json', oauth_credentials=OAuthCredentials(client_id=client_id, client_secret=client_secret))

# Initialisation en mode anonyme (accès public uniquement)
#ytmusic = YTMusic(oauth='oauth.json')

# Recherche d'un morceau
results = ytmusic.search("Daft Punk One More Time", filter="songs")

# Affichage du premier résultat
if results:
    song = results[0]
    print("Titre :", song["title"])
    print("Artiste(s) :", ", ".join(a["name"] for a in song["artists"]))
    print("Album :", song.get("album", {}).get("name", "Inconnu"))
    print("Durée :", song["duration"])
    print("Vidéo ID :", song["videoId"])
    print("Lien :", f"https://music.youtube.com/watch?v={song['videoId']}")
else:
    print("Aucun résultat trouvé.")

print("")


liked = ytmusic.get_liked_songs(limit=5)
for song in liked['tracks']:
    print(f"{song['title']} – {song['artists'][0]['name'] if song['artists'] else '' }")
