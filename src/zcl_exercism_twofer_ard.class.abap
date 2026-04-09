CLASS zcl_two_fer DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.
CLASS zcl_two_fer IMPLEMENTATION.
  METHOD two_fer.
  
  DATA gretting TYPE string.
  IF input EQ 'Alice'.
    gretting = |One for { input }, one for me.|.
  ELSEIF input EQ 'Bob'.
    gretting = |One for { input }, one for me.|.
  ELSE.
    gretting = 'One for you, one for me.'.
  ENDIF.
result = gretting.
  
  ENDMETHOD.
ENDCLASS.
