class ZVIM_FUJITSU_TEST1 definition
  public
  final
  create public .

public section.

  interfaces /OTX/PF11_IF_FIELD_ATTR .
protected section.
private section.
ENDCLASS.



CLASS ZVIM_FUJITSU_TEST1 IMPLEMENTATION.


  method /OTX/PF11_IF_FIELD_ATTR~SET_REGEX_PARAMETER.
    pe_regex = '^[X0]$'.
  endmethod.
ENDCLASS.
