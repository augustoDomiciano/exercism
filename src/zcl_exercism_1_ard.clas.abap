CLASS zcl_exercism_1_ard DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_type,
             group       TYPE group,
             number      TYPE i,
             description TYPE string,
           END OF initial_type,
           itab_data_type TYPE STANDARD TABLE OF initial_type WITH EMPTY KEY.

*    METHODS fill_itab
*      RETURNING
*        VALUE(initial_data) TYPE itab_data_type.

*    METHODS add_to_itab
*      IMPORTING initial_data        TYPE itab_data_type
*      RETURNING
*                VALUE(updated_data) TYPE itab_data_type.
*
*    METHODS sort_itab
*      IMPORTING initial_data        TYPE itab_data_type
*      RETURNING
*                VALUE(updated_data) TYPE itab_data_type.
*
*    METHODS search_itab
*      IMPORTING initial_data        TYPE itab_data_type
*      RETURNING
*                VALUE(result_index) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_exercism_1_ard IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*Preenchendo uma tabela inicial

    DATA itab_data_type TYPE initial_type.
    DATA initial_data TYPE itab_data_type.

    INSERT VALUE #( group = 'A' number = 10 description = 'Group A-2' ) INTO TABLE initial_data.
    INSERT VALUE #( group = 'B' number = 5 description = 'Group B' ) INTO TABLE initial_data.
    INSERT VALUE #( group = 'A' number = 6 description = 'Group A-1' ) INTO TABLE initial_data.
    INSERT VALUE #( group = 'C' number = 22 description = 'Group C-1' ) INTO TABLE initial_data.
    INSERT VALUE #( group = 'A' number = 13 description = 'Group A-3' ) INTO TABLE initial_data.
    INSERT VALUE #( group = 'C' number = 500 description = 'Group C-2' ) INTO TABLE initial_data.

    out->write( initial_data ).

*Inserindo uma linha na tabela inicial

    DATA updated_data TYPE itab_data_type.
    updated_data = initial_data.

    APPEND VALUE #( group = 'A' number = 19 description = 'Group A-4' ) TO updated_data.
    out->write( updated_data ).

*Ordenando a tabela

    SORT updated_data BY group ASCENDING number DESCENDING.

    out->write( updated_data ).

    DATA temp_data TYPE itab_data_type.

    READ TABLE updated_data INTO itab_data_type WITH KEY number = 6.
    out->write( sy-tabix ).

  ENDMETHOD.
ENDCLASS.
