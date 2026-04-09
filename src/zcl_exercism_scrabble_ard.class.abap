CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
DATA lv_char TYPE string.
DATA lt_char TYPE i LENGTH 2 VALUE 0.
DO strlen( input ) TIMES.
  lv_char = substring(
    val = input
    off = sy-index - 1
    len = 1
    ).
  IF lv_char CO 'AaEeIiOoUuLlNnRrSsTt'.
    lt_char += 1.
  ELSEIF lv_char CO 'DdGg'.
    lt_char += 2.
  ELSEIF lv_char CO 'BbCcMmPp'.
    lt_char += 3.
  ELSEIF lv_char CO 'FfHhVvWwYy'.
    lt_char += 4.
  ELSEIF lv_char CO 'Kk'.
    lt_char += 5.
  ELSEIF lv_char CO 'JjXx'.
    lt_char += 8.
  ELSEIF lv_char CO 'QqZz'.
    lt_char += 10.
  ENDIF.
ENDDO.

result = lt_char.
  ENDMETHOD.

ENDCLASS.
