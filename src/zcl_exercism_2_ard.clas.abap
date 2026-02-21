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

  SORT initial_numbers2 by group.

  DATA aggregated_data TYPE STANDARD TABLE OF aggregated_data_type.

  DATA(count_groupsA) = lines( VALUE initial_numbers( FOR GROUP IN initial_numbers2 WHERE ( group = 'A' ) ( GROUP ) ) ).
  DATA(count_groupsB) = lines( VALUE initial_numbers( FOR GROUP IN initial_numbers2 WHERE ( group = 'B' ) ( GROUP ) ) ).
  DATA(count_groupsC) = lines( VALUE initial_numbers( FOR GROUP IN initial_numbers2 WHERE ( group = 'C' ) ( GROUP ) ) ).

  CLEAR aggregated_data.

  DATA(itab) = aggregated_data.

  INSERT VALUE #( group = 'A' count = count_groupsA ) INTO itab INDEX 1.
  INSERT VALUE #( group = 'B' count = count_groupsB ) INTO itab INDEX 2.
  INSERT VALUE #( group = 'C' count = count_groupsC ) INTO itab INDEX 3.

*Contagem dos valores

  DATA wa TYPE initial_numbers_type.

  DATA(sum_valA) = REDUCE i( INIT len = 0
                            FOR <line> IN initial_numbers2
                            WHERE ( group = 'A' )
                            NEXT len = len + <line>-number
                          ).

    DATA(sum_valB) = REDUCE i( INIT len = 0
                            FOR <line> IN initial_numbers2
                            WHERE ( group = 'B' )
                            NEXT len = len + <line>-number
                          ).

  DATA(sum_valC) = REDUCE i( INIT len = 0
                            FOR <line> IN initial_numbers2
                            WHERE ( group = 'C' )
                            NEXT len = len + <line>-number
                          ).
  out->write( itab ).

*Soma dos valores

  DATA(itabA) = VALUE #( itab[ group = 'A' ] OPTIONAL ).
  DATA(itabB) = VALUE #( itab[ group = 'B' ] OPTIONAL ).
  DATA(itabC) = VALUE #( itab[ group = 'C' ] OPTIONAL ).

  MODIFY TABLE itab FROM VALUE #( BASE itabA sum = sum_valA ).
  MODIFY TABLE itab FROM VALUE #( BASE itabB sum = sum_valB ).
  MODIFY TABLE itab FROM VALUE #( BASE itabC sum = sum_valC ).

  out->write( itab ).

*Valor minimo


 DATA(min_valA) = REDUCE i( INIT min = 0
                            FOR line IN initial_numbers2
                            NEXT min = COND #( WHEN line-number < min
                                               THEN line-number
                                               ELSE min )
                          ).
  DATA initial_numbers3 TYPE TABLE OF initial_numbers_type.

*  READ TABLE initial_numbers2 INTO initial_numbers3 WHERE group = 'A'.

  ENDMETHOD.

ENDCLASS.
