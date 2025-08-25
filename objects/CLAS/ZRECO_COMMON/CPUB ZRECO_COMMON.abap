CLASS zreco_common DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    DATA: lt_reco_cform_sf TYPE TABLE OF zreco_cform_sf,
          ls_reco_cform_sf TYPE zreco_cform_sf.

    DATA: lt_reco_cform_bal TYPE TABLE OF zreco_cform_bal,
          ls_reco_cform_bal TYPE zreco_cform_bal.

    TYPES BEGIN OF ty_convert_curr.
    INCLUDE TYPE i_exchangeraterawdata .
*    TYPES  ukurx TYPE p LENGTH 16 DECIMALS 11.
    TYPES END OF ty_convert_curr .

    DATA: mt_h001   TYPE TABLE OF zreco_hdr,
          mt_return TYPE TABLE OF zreco_reminder.

    TYPES:
      ty_kunnr TYPE  TABLE OF zreco_range_kunnr,
      ty_blart TYPE  TABLE OF zreco_range_blart,
      ty_umskz TYPE  TABLE OF zreco_range_umskz,
      ty_belnr TYPE  TABLE OF zreco_range_belnr,
      ty_lifnr TYPE  TABLE OF zreco_range_lifnr.

    TYPES: BEGIN OF ty_receivers,
             receiver TYPE zreco_AD_SMTPADR,
             rec_type TYPE char03,
           END OF ty_receivers.

    DATA : lt_recevier TYPE TABLE OF ty_receivers.

    METHODS:
      zreco_result_new IMPORTING VALUE(i_randid)   TYPE  zreco_random OPTIONAL
                                 VALUE(i_mailid)   TYPE  zreco_mailid OPTIONAL
                                 VALUE(i_answer)   TYPE  abap_boolean OPTIONAL
                                 VALUE(i_text)     TYPE  string OPTIONAL
                                 VALUE(i_file_1)   TYPE  char256 OPTIONAL
                                 VALUE(i_file_2)   TYPE  char256 OPTIONAL
                                 VALUE(i_ip)       TYPE  string OPTIONAL
                                 VALUE(i_user)     TYPE  string OPTIONAL
                                 VALUE(i_no_data)  TYPE  zreco_no_data OPTIONAL
                                 VALUE(is_bform)   TYPE  zreco_bform_sf OPTIONAL
                                 VALUE(i_terminal) TYPE  string OPTIONAL
                       EXPORTING VALUE(e_text)     TYPE  char256
                                 VALUE(et_cform)   LIKE  lt_reco_cform_sf,

      zreco_get_balance IMPORTING VALUE(i_bukrs)  TYPE  bukrs OPTIONAL
                                  VALUE(i_kunnr)  TYPE  kunnr OPTIONAL
                                  VALUE(i_lifnr)  TYPE  lifnr OPTIONAL
                                  VALUE(i_monat)  TYPE  monat OPTIONAL
                                  VALUE(i_gjahr)  TYPE  gjahr OPTIONAL
                                  VALUE(i_all)    TYPE  zreco_all OPTIONAL
                                  VALUE(i_tran)   TYPE  zreco_tran OPTIONAL
                                  VALUE(i_kurst)  TYPE  kurst OPTIONAL
                                  VALUE(i_ftype)  TYPE  zreco_form OPTIONAL
                        EXPORTING VALUE(e_dmbtr)  TYPE  zreco_hslxx12
                                  VALUE(et_cform) LIKE  lt_reco_cform_bal,


      zreco_auth IMPORTING VALUE(i_bukrs)     TYPE  bukrs OPTIONAL
                           VALUE(i_hesap_tur) TYPE  zreco_account_type OPTIONAL
                           VALUE(i_hesap_no)  TYPE  zreco_ktonr_av OPTIONAL
                           VALUE(i_mtype)     TYPE  zreco_type OPTIONAL
                           VALUE(i_uname)     TYPE  syuname OPTIONAL
                           VALUE(i_ftype)     TYPE  zreco_form OPTIONAL
                           VALUE(i_ktokl)     TYPE  zreco_ktokl_077t OPTIONAL
                           VALUE(i_brsch)     TYPE  brsch OPTIONAL
                 EXPORTING VALUE(e_auth)      TYPE  abap_boolean ,

      zreco_lst_compare_date_2  IMPORTING VALUE(is_h001)     TYPE  zreco_hdr OPTIONAL
                                          VALUE(i_last)      TYPE  abap_boolean OPTIONAL
                                EXPORTING VALUE(e_last_info) TYPE  zreco_compare_date ,

      rp_last_day_of_months IMPORTING VALUE(day_in)            TYPE datum
                            EXPORTING VALUE(last_day_of_month) TYPE datum,
*                            EXCEPTIONS day_in_no_date,


*      get_notation IMPORTING VALUE(foreign_currency) TYPE zreco_waers
*                             VALUE(local_currency)   TYPE zreco_waers
*                             VALUE(date)             TYPE datum
*                   EXPORTING VALUE(notation)         TYPE zreco_notation.



      zreco_data_json IMPORTING VALUE(iv_json) TYPE string OPTIONAL
                      EXPORTING VALUE(ev_data) TYPE any,

      zreco_excluded_values IMPORTING VALUE(i_bukrs)  TYPE bukrs OPTIONAL
                            EXPORTING VALUE(it_kunnr) TYPE ty_kunnr
                                      VALUE(it_lifnr) TYPE ty_lifnr
                                      VALUE(it_blart) TYPE ty_blart
                                      VALUE(it_umskz) TYPE ty_umskz
                                      VALUE(it_belnr) TYPE ty_belnr,

      tax_info IMPORTING VALUE(i_bukrs)      TYPE bukrs
                         VALUE(i_lifnr)      TYPE lifnr OPTIONAL
                         VALUE(i_kunnr)      TYPE kunnr OPTIONAL
                         VALUE(i_number)     TYPE abap_boolean
                         VALUE(i_office)     TYPE abap_boolean
               EXPORTING VALUE(e_tax_office) TYPE any
                         VALUE(e_tax_number) TYPE any
                         VALUE(e_ktokl)      TYPE any,

**day_in_week IMPORTING VALUE(i_datum) TYPE datum
**            exporting VALUE(e_wotnr) type


      zreco_pdf_preview IMPORTING VALUE(i_mail_send)      TYPE abap_boolean OPTIONAL
                                  VALUE(i_batch)          TYPE sy-batch OPTIONAL
                                  VALUE(i_sort_indicator) TYPE int4 OPTIONAL
                                  VALUE(i_down)           TYPE string OPTIONAL
                                  VALUE(i_fn_number)      TYPE string OPTIONAL
                                  VALUE(i_fn_account)     TYPE string OPTIONAL
                                  VALUE(i_fn_name)        TYPE string OPTIONAL
                                  VALUE(it_h001)          LIKE mt_h001 OPTIONAL
                                  VALUE(et_return)        LIKE mt_return OPTIONAL,

      zreco_contact_m IMPORTING VALUE(is_adrs)     TYPE zreco_adrs OPTIONAL
                                VALUE(i_hesap_tur) TYPE zreco_account_type OPTIONAL
                                VALUE(i_hesap_no)  TYPE zreco_ktonr_av OPTIONAL
                                VALUE(i_ktokl)     TYPE zreco_ktokl_077t OPTIONAL
                                VALUE(i_mtype)     TYPE zreco_type OPTIONAL
                                VALUE(i_ftype)     TYPE zreco_form OPTIONAL
                                VALUE(i_uname)     TYPE syuname OPTIONAL
                      EXPORTING VALUE(e_name)      TYPE text100
                                VALUE(e_telefon)   TYPE text100
                                VALUE(e_email)     TYPE char256,

      zreco_from_mail_adrs IMPORTING VALUE(i_bukrs) TYPE bukrs OPTIONAL
                                     VALUE(i_gsber) TYPE gsber OPTIONAL
                                     VALUE(i_kunnr) TYPE kunnr OPTIONAL
                                     VALUE(i_lifnr) TYPE lifnr OPTIONAL
                                     VALUE(i_mtype) TYPE zreco_type OPTIONAL
                                     VALUE(i_uname) TYPE syuname OPTIONAL
                           EXPORTING VALUE(e_mail)  TYPE zreco_ad_smtpadr,

      zreco_download_int_file IMPORTING VALUE(i_filter) TYPE string OPTIONAL
                                        VALUE(it_files) TYPE zreco_tt_down_files OPTIONAL,

      zreco_to_mail_adrs IMPORTING VALUE(i_bukrs)      TYPE bukrs OPTIONAL
                                   VALUE(i_ucomm)      TYPE string OPTIONAL
                                   VALUE(i_kunnr)      TYPE kunnr OPTIONAL
                                   VALUE(i_lifnr)      TYPE lifnr OPTIONAL
                                   VALUE(i_abtnr)      TYPE zreco_abtnr OPTIONAL
                                   VALUE(i_pafkt)      TYPE zreco_PAFKT OPTIONAL
                                   VALUE(i_remark)     TYPE zreco_AD_REMARK2 OPTIONAL
                                   VALUE(i_all)        TYPE abap_boolean OPTIONAL
                                   VALUE(i_stcd1)      TYPE string OPTIONAL
                                   VALUE(i_no_general) TYPE abap_boolean OPTIONAL
                                   VALUE(i_mtype)      TYPE zRECO_TYPE OPTIONAL
                         EXPORTING VALUE(e_mail)       TYPE zreco_ad_smtpadr
                                   VALUE(t_receivers)  LIKE lt_recevier.

