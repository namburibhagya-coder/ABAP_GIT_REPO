class ZFUJITSU_EXTRACTION_ENRICHMENT definition
  public
  final
  create public .

public section.

  interfaces /OTX/PF11_IF_HANDLE_RESULT .
protected section.
private section.
ENDCLASS.



CLASS ZFUJITSU_EXTRACTION_ENRICHMENT IMPLEMENTATION.


  METHOD /otx/pf11_if_handle_result~format_extraction_value.
*  ************************************************************************
*                      BASELINE DEBUGGING OPTION                       *
************************************************************************
* Declarations
    DATA: lt_full_txt TYPE /otx/pf11_tt_fulltext_str.
    DATA : lv_company_code TYPE bukrs.
    DATA : ls_reg_dext_temp TYPE /otx/pf11_t_dext.
    DATA: lv_id TYPE /otx/pf11_e_ext_element_id.
    DATA ls_otx_pf01_t_1ext TYPE /otx/pf01_t_1ext.
    DATA : ls_reg_dext TYPE /otx/pf11_t_dext .
    DATA : lv_docid TYPE /opt/docid.
    DATA: ls_opt_cp_debug TYPE /opt/cp_debug.
    CLEAR: ls_opt_cp_debug.
    SELECT SINGLE * FROM /opt/cp_debug INTO ls_opt_cp_debug "#EC CI_SUBRC
                    WHERE debugarea = 'EXTRACT_VALUES_01'.
    DATA: exit_dbug.
    CLEAR: exit_dbug.
    IF NOT  ls_opt_cp_debug-value IS INITIAL.
      DO.
        CLEAR ls_opt_cp_debug.
        SELECT SINGLE * FROM /opt/cp_debug INTO ls_opt_cp_debug "#EC CI_SUBRC
                        WHERE debugarea = 'EXTRACT_VALUES_01'.
        IF NOT exit_dbug IS INITIAL OR ls_opt_cp_debug-value IS INITIAL.
          EXIT.
        ENDIF.
      ENDDO.
    ENDIF.
************************************************************************

    FIELD-SYMBOLS: <ls_path_values>    TYPE /otx/pf11_s_sce_data_result.
*                   <LS_PATH_VALUES_HIGHRISK> TYPE /OTX/PF11_S_DATA_GEN,
*                   <LS_VALUES_HIGHRISK>      TYPE /OTX/PF11_S_DATA_GEN.

    IF pi_step = '02'.

************************************************************************
*                      BASELINE DEBUGGING OPTION                       *
************************************************************************
      CLEAR: ls_opt_cp_debug.
      SELECT SINGLE * FROM /opt/cp_debug INTO ls_opt_cp_debug "#EC CI_SUBRC
                      WHERE debugarea = 'EXTRACT_VALUES_02'.
      CLEAR: exit_dbug.
      IF NOT  ls_opt_cp_debug-value IS INITIAL.
        DO.
          CLEAR ls_opt_cp_debug.
          SELECT SINGLE * FROM /opt/cp_debug INTO ls_opt_cp_debug "#EC CI_SUBRC
                          WHERE debugarea = 'EXTRACT_VALUES_02'.
          IF NOT exit_dbug IS INITIAL OR ls_opt_cp_debug-value IS INITIAL.
            EXIT.
          ENDIF.
        ENDDO.
      ENDIF.
************************************************************************
      IF pcs_extraction_result-name = 'Z_Z_HIGHRISK'.
        SELECT SINGLE docid FROM /opt/vim_1head INTO lv_docid WHERE reg_id = pi_regid.
        TRY.
            CALL METHOD /otx/ps03_cl_ies_util=>get_fulltext
              EXPORTING
                pi_regid     = pi_regid
                pi_docid     = lv_docid
*               pi_proj_id   =
              IMPORTING
                pet_fulltext = lt_full_txt.

        ENDTRY.
        IF lt_full_txt[] IS NOT INITIAL.
          DATA(lv_found) = abap_false.
          LOOP AT lt_full_txt INTO DATA(ls_full_txt).
            TRANSLATE ls_full_txt-fulltext TO UPPER CASE.
            IF ls_full_txt-fulltext CS 'GOVERNMENT'.
              lv_found = abap_true.
              EXIT.
            ENDIF.
          ENDLOOP.

          READ TABLE pit_extraction_result_path ASSIGNING <ls_path_values> WITH KEY ext_element_path = 'ExtractionResult-Z_Z_HIGHRISK'.
          IF sy-subrc = 0.
            IF pcs_extraction_result-id = <ls_path_values>-id AND pcs_extraction_result-parent_id = <ls_path_values>-parent_id AND lv_found = abap_true.
              pcs_extraction_result-value = abap_true.
              pcs_extraction_result-raw_value = abap_true.

            ENDIF .
          ENDIF.
        ENDIF.
      ENDIF.
ENDIF.
    ENDMETHOD.


  METHOD /otx/pf11_if_handle_result~process_extraction_result.

*  ************************************************************************
*                      BASELINE DEBUGGING OPTION                       *
************************************************************************
* Declarations
    DATA: lt_full_txt TYPE /otx/pf11_tt_fulltext_str.
    DATA : lv_company_code TYPE bukrs.
    DATA : ls_reg_dext_temp TYPE /otx/pf11_t_dext.
    DATA: lv_id TYPE /otx/pf11_e_ext_element_id.
    DATA ls_otx_pf01_t_1ext TYPE /otx/pf01_t_1ext.
    DATA : ls_reg_dext TYPE /otx/pf11_t_dext .
    DATA : lv_docid TYPE /opt/docid.
    DATA: ls_opt_cp_debug TYPE /opt/cp_debug.
    CLEAR: ls_opt_cp_debug.
    SELECT SINGLE * FROM /opt/cp_debug INTO ls_opt_cp_debug "#EC CI_SUBRC
                    WHERE debugarea = 'EXTRACT_VALUES_01'.
    DATA: exit_dbug.
    CLEAR: exit_dbug.
    IF NOT  ls_opt_cp_debug-value IS INITIAL.
      DO.
        CLEAR ls_opt_cp_debug.
        SELECT SINGLE * FROM /opt/cp_debug INTO ls_opt_cp_debug "#EC CI_SUBRC
                        WHERE debugarea = 'EXTRACT_VALUES_01'.
        IF NOT exit_dbug IS INITIAL OR ls_opt_cp_debug-value IS INITIAL.
          EXIT.
        ENDIF.
      ENDDO.
    ENDIF.
************************************************************************

    FIELD-SYMBOLS: <ls_path_values>    TYPE /otx/pf11_s_sce_data_result.
*                   <LS_PATH_VALUES_HIGHRISK> TYPE /OTX/PF11_S_DATA_GEN,
*                   <LS_VALUES_HIGHRISK>      TYPE /OTX/PF11_S_DATA_GEN.

    IF pi_step = '02'.

************************************************************************
*                      BASELINE DEBUGGING OPTION                       *
************************************************************************
      CLEAR: ls_opt_cp_debug.
      SELECT SINGLE * FROM /opt/cp_debug INTO ls_opt_cp_debug "#EC CI_SUBRC
                      WHERE debugarea = 'EXTRACT_VALUES_02'.
      CLEAR: exit_dbug.
      IF NOT  ls_opt_cp_debug-value IS INITIAL.
        DO.
          CLEAR ls_opt_cp_debug.
          SELECT SINGLE * FROM /opt/cp_debug INTO ls_opt_cp_debug "#EC CI_SUBRC
                          WHERE debugarea = 'EXTRACT_VALUES_02'.
          IF NOT exit_dbug IS INITIAL OR ls_opt_cp_debug-value IS INITIAL.
            EXIT.
          ENDIF.
        ENDDO.
      ENDIF.
************************************************************************
*      IF pit_extraction_result-name = 'Z_Z_HIGHRISK'.
      SELECT SINGLE docid FROM /opt/vim_1head INTO lv_docid WHERE reg_id = pi_regid.
      TRY.
          CALL METHOD /otx/ps03_cl_ies_util=>get_fulltext
            EXPORTING
              pi_regid     = pi_regid
              pi_docid     = lv_docid
*             pi_proj_id   =
            IMPORTING
              pet_fulltext = lt_full_txt.

      ENDTRY.
      IF lt_full_txt[] IS NOT INITIAL.
        DATA(lv_found) = abap_false.
        LOOP AT lt_full_txt INTO DATA(ls_full_txt).
          TRANSLATE ls_full_txt-fulltext TO UPPER CASE.
          IF ls_full_txt-fulltext CS 'GOVERNMENT'.
            lv_found = abap_true.
            EXIT.
          ENDIF.
        ENDLOOP.

*          READ TABLE pit_extraction_result_path ASSIGNING <ls_path_values> WITH KEY ext_element_path = 'ExtractionResult-Z_Z_HIGHRISK'.
*          IF sy-subrc = 0.
*            IF pcs_extraction_result-id = <ls_path_values>-id AND pcs_extraction_result-parent_id = <ls_path_values>-parent_id AND lv_found = abap_true.
*              pcs_extraction_result-value = abap_true.
*              pcs_extraction_result-raw_value = abap_true.
*
*            ENDIF .
*          ENDIF.
*        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
