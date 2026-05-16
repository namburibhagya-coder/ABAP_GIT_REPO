FUNCTION ZVIM_FUJITSU_VAL_DETERM .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(PIS_1REG) TYPE  /OTX/PF01_T_1REG
*"     REFERENCE(PIT_EXTDATA) TYPE  /OTX/PF00_TT_EXT OPTIONAL
*"     REFERENCE(PIT_EXTDATA_CLOUD) TYPE  /OTX/PF11_TT_EXT_DATA_RES_ITM
*"       OPTIONAL
*"     REFERENCE(PIT_EXTDATA_CLOUD_PATH) TYPE
*"        /OTX/PF11_TT_SCE_DATA_RESULT OPTIONAL
*"  EXPORTING
*"     REFERENCE(PE_VALIDATE) TYPE  XFELD
*"     REFERENCE(PE_VALIDATORS) TYPE  TSWHACTOR
*"     REFERENCE(PET_VALIDATORS_ENH) TYPE  /OTX/PF01_TT_VALIDATORS_ENH
*"----------------------------------------------------------------------
  DATA: lt_extdata     TYPE /OTX/PF11_TT_EXT_DATA_RES_ITM,
        ls_extdata     TYPE /OTX/PF11_S_EXT_DATA_RESLT_ITM.
*        ls_extdata2    TYPE /OTX/PF11_S_EXT_DATA_RESLT_ITM.
**        ls_train       TYPE  z01ca_otx_bc_trt,
**        lv_ebeln       TYPE ebeln,
**        lv_lifnr       TYPE lifnr,
**        lv_xblnr       TYPE xblnr_long,
**        lv_lifnr_i     TYPE i,
**        lv_train       TYPE int4,
**        ls_actor       TYPE swhactor,
**        lv_lines       TYPE flag,
**        lv_tab         TYPE i,
**        lv_qant        TYPE flag,
**        lv_unitpr      TYPE flag,
**        lv_amount      TYPE flag,
**        lv_count_ekpo  TYPE i,
**        lv_count_lines TYPE i.
*
  MOVE-CORRESPONDING pit_extdata_cloud TO lt_extdata.
*
*  READ TABLE pit_extdata_cloud INTO ls_extdata WITH KEY
*          extfield = 'Vendor'.
*  IF sy-subrc = 0.
*    lv_lifnr = ls_extdata-extvalue.
*  ENDIF.
*  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
*    EXPORTING
*      input  = lv_lifnr
*    IMPORTING
*      output = lv_lifnr.
*
*  READ TABLE pit_extdata INTO ls_extdata WITH KEY
*          extfield = 'OrderNumber'.
*  IF sy-subrc = 0.
*    CONDENSE ls_extdata-extvalue NO-GAPS.
*    lv_ebeln = ls_extdata-extvalue.
*  ENDIF.
*  CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'
*    EXPORTING
*      input  = lv_ebeln
*    IMPORTING
*      output = lv_ebeln.
*
** Referenznummer muss da sein
*  READ TABLE pit_extdata INTO ls_extdata WITH KEY
*        extfield = 'ReferenceNumber'.
*  IF sy-subrc = 0.
*    lv_xblnr = ls_extdata-extvalue.
*  ENDIF.
*
** Eine Position mit Menge + Preis oder Gesamtpreis
*
*  LOOP AT pit_extdata INTO ls_extdata
*    WHERE extindex NE ''.
*
*    READ TABLE pit_extdata INTO ls_extdata2 WITH KEY extindex = ls_extdata-extindex
*                                                     extfield = 'ItemQuantity'.
*
*    IF sy-subrc EQ 0 AND ls_extdata2-extvalue NE ''.
*      lv_qant = 'X'.
*    ENDIF.
*
*
*    READ TABLE pit_extdata INTO ls_extdata2 WITH KEY extindex = ls_extdata-extindex
*                                                     extfield = 'ItemUnitPrice'.
*
*    IF sy-subrc EQ 0 AND ls_extdata2-extvalue NE ''.
*      lv_unitpr = 'X'.
*    ENDIF.
*
*    READ TABLE pit_extdata INTO ls_extdata2 WITH KEY extindex = ls_extdata-extindex
*                                                    extfield = 'ItemNetPrice'.
*
*    IF sy-subrc EQ 0 AND ls_extdata2-extvalue NE ''.
*      lv_amount = 'X'.
*    ENDIF.
*
*
*    IF lv_qant EQ 'X' AND ( lv_unitpr EQ 'X' OR lv_amount EQ 'X' ).
*      lv_lines = 'X'.
*      EXIT.
*    ENDIF.
*
*    CLEAR: ls_extdata, ls_extdata2, lv_qant, lv_unitpr, lv_amount.
*  ENDLOOP.
*
*
*  IF  lv_lifnr IS INITIAL OR
*      lv_ebeln IS INITIAL OR
*      lv_xblnr IS INITIAL OR
*      lv_lines IS INITIAL.
*
*    pe_validate = 'X'.
*
*  ENDIF.
*
*  IF pe_validate IS NOT INITIAL AND lv_lifnr IS NOT INITIAL.
*
*    SELECT SINGLE COUNT(*) FROM z01ca_otx_bc_whi
*      WHERE lifnr EQ  lv_lifnr.
*
*    IF sy-subrc EQ 0.
*      pe_validate = ''.
*    ENDIF.
*
*  ENDIF.
*
*  IF lv_lifnr IS NOT INITIAL AND lv_ebeln IS NOT INITIAL.
*    SELECT SINGLE train FROM z01ca_otx_bc_trt INTO lv_train
*      WHERE lifnr = lv_lifnr.
*    IF sy-subrc = 0.
*      lv_train = lv_train - 1.
*      IF lv_train <= 0.
*        DELETE FROM  z01ca_otx_bc_trt WHERE lifnr = lv_lifnr.
*      ELSE.
*
*        ls_train-lifnr = lv_lifnr.
*        ls_train-train = lv_train.
*        MODIFY z01ca_otx_bc_trt FROM ls_train.
*      ENDIF.
*      pe_validate = 'X'.
*    ENDIF.
*  ELSE.
*    pe_validate = 'X'.
*  ENDIF.
*
*
** Validation Reason
*
*
*DATA: lt_var TYPE TABLE OF Z01CA_OTX_BC_VAR,
*      ls_var TYPE Z01CA_OTX_BC_VAR.
*
*ls_var-REGID = PIS_1REG-REGID.
*
*IF lv_lifnr IS INITIAL.
*  ls_var-r_liefnr = 1.
*ENDIF.
*
*IF lv_ebeln IS INITIAL.
*  ls_var-r_ebeln = 1.
*ENDIF.
*
*IF lv_xblnr IS INITIAL.
*  ls_var-r_xblnr = 1.
*ENDIF.
*
*IF lv_lines IS INITIAL.
*  ls_var-r_lines = 1.
*ENDIF.
*
*IF lv_train IS NOT INITIAL.
*  ls_var-R_MARKED = 1.
*ENDIF.
*
*MODIFY Z01CA_OTX_BC_VAR FROM ls_var.
*
ENDFUNCTION.
