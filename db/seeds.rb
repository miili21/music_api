# Limpiar la base de datos antes de empezar
Release.destroy_all
Album.destroy_all
Artist.destroy_all

puts "Creando datos de prueba..."

# 1. Crear Artistas
BTS = Artist.create!(name: "BTS")
Lady_Gaga = Artist.create!(name: "Lady Gaga")
Olivia_Rodrigo = Artist.create!(name: "Olivia Rodrigo")

# 2. Crear Álbumes
Arirang = Album.create!(title: "Arirang")
The_Fame = Album.create!(title: "The Fame")
You_Seen_Pretty_Sad_For_a_Girl_So_In_Love = Album.create!(title: "You Seen Pretty Sad For a Girl So In Love")

# 3. Crear Lanzamientos (Releases) vinculados
# Pasado
Release.create!(
  title: "Poker Face",
  release_date: Date.new(2008, 11, 23),
  album: The_Fame,
  artists: [ Lady_Gaga ]
)

# Reciente (Para probar el filtro 'past')
Release.create!(
  title: "SWIM",
  release_date: 1.month.ago,
  album: Arirang,
  artists: [ BTS ]
)

# Futuro (Para probar el filtro 'upcoming')
Release.create!(
  title: "Nuevo Single Promocional",
  release_date: 2.month.from_now,
  album: You_Seen_Pretty_Sad_For_a_Girl_So_In_Love,
  artists: [ Olivia_Rodrigo ]
)

puts "Se crearon #{Artist.count} artistas, #{Album.count} álbumes y #{Release.count} lanzamientos."
