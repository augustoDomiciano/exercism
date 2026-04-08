CLASS zcl_itab_nesting_ard DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF artists_type,
             artist_id   TYPE c LENGTH 50,
             artist_name TYPE c LENGTH 50,
           END OF artists_type.
    TYPES artists TYPE STANDARD TABLE OF artists_type WITH KEY artist_id.
    TYPES: BEGIN OF albums_type,
             artist_id  TYPE c LENGTH 50,
             album_id   TYPE c LENGTH 50,
             album_name TYPE c LENGTH 50,
           END OF albums_type.
    TYPES albums TYPE STANDARD TABLE OF albums_type WITH KEY artist_id album_id.
    TYPES: BEGIN OF songs_type,
             artist_id TYPE c LENGTH 50,
             album_id  TYPE c LENGTH 50,
             song_id   TYPE c LENGTH 50,
             song_name TYPE c LENGTH 50,
           END OF songs_type.
    TYPES songs TYPE STANDARD TABLE OF songs_type WITH KEY artist_id album_id song_id.


    TYPES: BEGIN OF song_nested_type,
             song_id   TYPE c LENGTH 50,
             song_name TYPE c LENGTH 50,
           END OF song_nested_type.
    TYPES: BEGIN OF album_song_nested_type,
             album_id   TYPE c LENGTH 50,
             album_name TYPE c LENGTH 50,
             songs      TYPE STANDARD TABLE OF song_nested_type WITH KEY song_id,
           END OF album_song_nested_type.
    TYPES: BEGIN OF artist_album_nested_type,
             artist_id   TYPE c LENGTH 50,
             artist_name TYPE c LENGTH 50,
             albums      TYPE STANDARD TABLE OF album_song_nested_type WITH KEY album_id,
           END OF artist_album_nested_type.
    TYPES nested_data TYPE STANDARD TABLE OF artist_album_nested_type WITH KEY artist_id.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_itab_nesting_ard IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


  DATA(artist_a) = VALUE artists( ( artist_id = '1' artist_name = 'Godsmack' )
                    ( artist_id = '2' artist_name = 'Shinedown' ) ).

  DATA(albums_a) = VALUE albums( ( artist_id = '1' album_id = '1' album_name = 'Faceless' )
                                 ( artist_id = '1' album_id = '2' album_name = 'When Lengends Rise' )
                                 ( artist_id = '2' album_id = '1' album_name = 'The Sound of Madness' )
                                 ( artist_id = '2' album_id = '2' album_name = 'Planet Zero' )
                               ).

    DATA(songs_a) = VALUE songs( ( artist_id = '1' album_id = '1' song_id = '1' song_name = 'Straight Out Of Line' )
                                 ( artist_id = '1' album_id = '1' song_id = '2' song_name = 'Changes' )
                                 ( artist_id = '1' album_id = '2' song_id = '1' song_name = 'Bullet Proof' )
                                 ( artist_id = '1' album_id = '2' song_id = '2' song_name = 'Under Your Scars' )
                                 ( artist_id = '2' album_id = '1' song_id = '1' song_name = 'Second Chance' )
                                 ( artist_id = '2' album_id = '1' song_id = '2' song_name = 'Breaking Inside' )
                                 ( artist_id = '2' album_id = '2' song_id = '1' song_name = 'Dysfunctional You' )
                                 ( artist_id = '2' album_id = '2' song_id = '2' song_name = 'Daylight' )
                               ).

DATA album_artist_n TYPE TABLE OF artist_album_nested_type.

SELECT at~artist_id, at~artist_name, ab~album_id, ab~album_name, sg~song_id, sg~song_name
FROM @artist_a AS at
INNER JOIN @albums_a as ab ON at~artist_id = ab~artist_id
INNER JOIN @songs_a as sg ON sg~artist_id = ab~artist_id AND sg~album_id = ab~album_id
INTO TABLE @DATA(artist_album__song_n).

out->write( artist_album__song_n ).

  ENDMETHOD.

ENDCLASS.
