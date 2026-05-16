class ZVIM_CL_FUJIT_EXT definition
  public
  final
  create public .

public section.

  interfaces /OTX/PF11_IF_HANDLE_RESULT .
protected section.
private section.
ENDCLASS.



CLASS ZVIM_CL_FUJIT_EXT IMPLEMENTATION.


  method /OTX/PF11_IF_HANDLE_RESULT~PROCESS_EXTRACTION_RESULT.
*    TRY.

CALL METHOD /otx/pf02_cl_utilities=>get_fulltext
*  EXPORTING
*    pi_regid      =
*    pi_project_id =
*    pi_plkey      =
*  IMPORTING
*    pet_fulltext  =
    .
* CATCH /otx/cx_pf02_exception .
*ENDTRY.


  endmethod.
ENDCLASS.
