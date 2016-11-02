DROP TABLE EDWPRDBW..HMAP05_DEALTYPE_SKU_FLN_POS_VIEWS;

CREATE TABLE EDWPRDBW..HMAP05_DEALTYPE_SKU_FLN_POS_VIEWS AS
(
WITH GETPOS AS
(
SELECT
DC.D_YR,
DC.D_WK,
CSIF.DEAL_ID,
CSIF.PRODUCT_NUM,
PCD.FINELINE_CD,
SUM((CSIF.ITEM_TRANSACTION_QTY + ITEM_RETURN_QUANTITY) * CSIF.ITEM_ACTUAL_SELLING_PRICE_AMT) AS POS,
SUM(CSIF.ITEM_TRANSACTION_QTY + ITEM_RETURN_QUANTITY) AS QTY

FROM
EDWPRD..CTR_SALES_ITEM_FCT CSIF,
EDWPRD..PRODUCT_CURRENT_DIM PCD,
EDWPRDBW..GRP_PROMO_CALENDAR DC

WHERE
(DC.D_YR BETWEEN 2013 AND 2014) AND 
(DC.D_WK BETWEEN 1 AND 52) AND
DC.D_DAY_ID = CSIF.DAY_ID AND 
CSIF.PRODUCT_ID = PCD.PRODUCT_ID AND
PCD.PRODUCT_NUM_SOURCE_CD = 'IMS' AND
PCD.PRODUCT_NUM<>'N/A' AND
PCD.FINELINE_CD<>'97047' AND
PCD.CORPORATE_STATUS_CD<>'DEL' AND
PCD.SBU_NM = 'Canadian Tire Retail' AND
(PCD.PRODUCT_CLASS_NUM NOT BETWEEN '090' AND '098') AND 
PCD.DIVISION_CD NOT IN ('NM','N/A','00')

GROUP BY
DC.D_YR,
DC.D_WK,
CSIF.DEAL_ID,
CSIF.PRODUCT_NUM,
PCD.FINELINE_CD
)
,
GETDEALNUM AS
(
SELECT
GP.D_YR,
GP.D_WK,
SUM(CASE WHEN PDEAL.DEAL_ID IS NULL THEN 0 ELSE 1 END) AS DEAL_TYPE,
GP.PRODUCT_NUM,
GP.FINELINE_CD,
SUM(GP.POS) AS NPOS_T,
SUM(GP.QTY) AS NQTY_T

FROM
GETPOS GP
LEFT JOIN
EDWPRDBW..HMAP04_DEALID PDEAL
ON
GP.D_YR = PDEAL.D_YR AND
GP.DEAL_ID = PDEAL.DEAL_ID

GROUP BY
GP.D_YR,
GP.D_WK,
GP.PRODUCT_NUM,
GP.FINELINE_CD
)
,
FINAL_DEAL AS
(
SELECT
DN.D_YR,
DN.D_WK,
(CASE WHEN DN.DEAL_TYPE > 0 THEN 1 ELSE 0 END) AS FINAL_TYPE,
DN.PRODUCT_NUM,
DN.FINELINE_CD,
DN.NPOS_T,
DN.NQTY_T

FROM
GETDEALNUM DN
)

SELECT
FD.D_YR,
FD.D_WK,
FD.FINAL_TYPE AS DEAL_TYPE,
FD.PRODUCT_NUM,
FD.FINELINE_CD,
FD.NPOS_T AS POS,
FD.NQTY_T AS QTY,
NVL(PV.VIEWS,0) AS PRODVIEWS

FROM
FINAL_DEAL FD
LEFT JOIN
EDWPRDBW..HMAP01_SKU_FLN_VIEWS PV
ON
PV.D_YR = FD.D_YR AND
PV.D_WK = FD.D_WK AND
PV.PROD_NUM = FD.PRODUCT_NUM AND
PV.FINLN_CD = FD.FINELINE_CD
)
