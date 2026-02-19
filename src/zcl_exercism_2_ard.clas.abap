CLASS zcl_exercism_2_ard DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

*    METHODS if_oo_adt_classrun.
*
*      IMPORTING
*        out                    TYPE REF TO if_oo_adt_classrun_out
*        initial_numbers        TYPE initial_numbers
*      RETURNING
*        VALUE(aggregated_data) TYPE aggregated_data.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_exercism_2_ard IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

  DATA initial_numbers2 TYPE TABLE OF initial_numbers_type.

  initial_numbers2 = VALUE #( ( group = 'A' number = 10 )
                              ( group = 'B' number = 5 )
                              ( group = 'A' number = 6 )
                              ( group = 'C' number = 22 )
                              ( group = 'A' number = 13 )
                              ( group = 'C' number = 500 )
                            ).

*  aggregated_data = initial_numbers2.
*
*  SORT aggregated_data BY group.

*  out->write( initial_numbers2 ).

  SORT initial_numbers2 by group.

*  out->write( initial_numbers2 ).

  DATA aggregated_data TYPE STANDARD TABLE OF aggregated_data_type.

  out->write( aggregated_data ).
  out->write( initial_numbers2 ).

  DATA(count_groupsA) = lines( VALUE initial_numbers( FOR GROUPS IN initial_numbers2 WHERE ( group = 'A' ) ( GROUPS ) ) ).
  DATA(count_groupsB) = lines( VALUE initial_numbers( FOR GROUPS IN initial_numbers2 WHERE ( group = 'B' ) ( GROUPS ) ) ).
  DATA(count_groupsC) = lines( VALUE initial_numbers( FOR GROUPS IN initial_numbers2 WHERE ( group = 'C' ) ( GROUPS ) ) ).

  out->write( count_groupsA ).
  out->write( count_groupsB ).
  out->write( count_groupsC ).

  CLEAR aggregated_data.

  out->write( aggregated_data ).

  DATA(itab) = aggregated_data.

  INSERT VALUE #( group = 'A' count = count_groupsA ) INTO itab INDEX 1.

  out->write( itab ).

  ENDMETHOD.

ENDCLASS.
