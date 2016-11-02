WITH DEAL_ID_NUM AS
(
SELECT
DED.DEAL_YR_CD,
DC.D_WK,
CAST((SUBSTR(DC.D_WK_START,1,4) || SUBSTR(DC.D_WK_START,6,2) || SUBSTR(DC.D_WK_START,9,2)) AS INT) D_WK_START_ID,
CAST((SUBSTR(DC.D_WK_END,1,4) || SUBSTR(DC.D_WK_END,6,2) || SUBSTR(DC.D_WK_END,9,2)) AS INT) D_WK_END_ID,
DED.DEAL_NUM_CD,
DED.DEAL_ID

FROM
EDWPRD..DEAL_EXTENDED_DIM DED,
EDWPRDBW..MY_DEAL_CALENDAR DC

WHERE
CAST(DED.DEAL_YR_CD AS INT) = DC.D_YR AND
(DC.D_YR BETWEEN 2012 AND 2014) AND
DED.DEAL_NUM_CD <> 'NA        ' AND
(DED.PROMO_SALE_STRT_DATE BETWEEN DC.D_WK_START AND DC.D_WK_END) AND
(DED.PROMO_SALE_END_DATE BETWEEN DC.D_WK_START AND DC.D_WK_END) AND
        (TRIM(DED.DEAL_NUM_CD) LIKE '_1__' OR
        TRIM(DED.DEAL_NUM_CD) LIKE '_3__') AND 
DED.DEAL_NUM_CD IS NOT NULL AND
DED.DEAL_NUM_CD <> '' AND
(CAST(SUBSTR(DED.DEAL_NUM_CD,3,2) AS INT) BETWEEN 1 AND 53) AND
DED.TYP_CD_NM = 'PROMOTIONAL'

GROUP BY
DED.DEAL_YR_CD,
DC.D_WK,
DC.D_WK_START,
DC.D_WK_END,
DED.DEAL_NUM_CD,
DED.DEAL_ID
)
,

PI_SKU AS
(
SELECT DISTINCT
DIN.*,
PCD.PRODUCT_ID,
PCD.PRODUCT_NUM

FROM
DEAL_ID_NUM DIN,
EDWPRD..DEAL_EXTENDED_PROD_DIM DEPD,
EDWPRD..PRODUCT_DIM PD,
EDWPRD..PRODUCT_CURRENT_DIM PCD

WHERE
DIN.DEAL_ID = DEPD.DEAL_ID AND 
DEPD.PROD_ID = PD.PROD_ID AND
PD.PROD_NBR = PCD.PRODUCT_NUM AND
PCD.PRODUCT_NUM_SOURCE_CD = 'IMS' AND
PCD.PRODUCT_NUM <> 'N/A' AND
PCD.CORPORATE_STATUS_CD<>'DEL' AND
PCD.FINELINE_CD<>'97047' AND
PCD.SBU_NM = 'Canadian Tire Retail' AND
(PCD.PRODUCT_CLASS_NUM NOT BETWEEN '090' And '098') AND 
PCD.DIVISION_CD NOT IN ('NM','N/A','00')
)
,

POS AS
(
SELECT 
DC.D_YR,
DC.D_WK,
CAST((SUBSTR(DC.D_WK_START,1,4) || SUBSTR(DC.D_WK_START,6,2) || SUBSTR(DC.D_WK_START,9,2)) AS INT) D_WK_START_ID,
CAST((SUBSTR(DC.D_WK_END,1,4) || SUBSTR(DC.D_WK_END,6,2) || SUBSTR(DC.D_WK_END,9,2)) AS INT) D_WK_END_ID,
CSIF.PRODUCT_ID,
PCD.PRODUCT_NUM,
SUM((CSIF.ITEM_TRANSACTION_QTY + CSIF.ITEM_RETURN_QUANTITY) * CSIF.ITEM_ACTUAL_SELLING_PRICE_AMT) AS NET_POS,
SUM(CSIF.ITEM_TRANSACTION_QTY + CSIF.ITEM_RETURN_QUANTITY) AS NET_QTY

FROM
EDWPRD..CTR_SALES_ITEM_FCT CSIF,
EDWPRD..PRODUCT_CURRENT_DIM PCD,
EDWPRD..DEAL_CURRENT_DIM DCD,
EDWPRDBW..MY_DEAL_CALENDAR DC

WHERE
CSIF.DAY_ID = DC.D_DAY_ID AND
CSIF.PRODUCT_ID = PCD.PRODUCT_ID AND
CSIF.DEAL_ID = DCD.DEAL_ID AND
PCD.PRODUCT_NUM_SOURCE_CD = 'IMS' AND
PCD.PRODUCT_NUM <> 'N/A' AND
PCD.FINELINE_CD<>'97047' AND
PCD.CORPORATE_STATUS_CD<>'DEL' AND
PCD.SBU_NM = 'Canadian Tire Retail' AND
(PCD.PRODUCT_CLASS_NUM NOT BETWEEN '090' And '098') AND 
PCD.DIVISION_CD NOT IN ('NM','N/A','00') AND 
(CSIF.DAY_ID BETWEEN 20111230 AND 20150101) AND
(DCD.DEAL_START_DATE BETWEEN DC.D_WK_START AND DC.D_WK_END) AND
(DCD.DEAL_END_DATE BETWEEN DC.D_WK_START AND DC.D_WK_END) AND
        (DCD.DEAL_NUM LIKE '_1__' OR
        DCD.DEAL_NUM LIKE '_3__') AND 
DCD.DEAL_NUM IS NOT NULL AND
DCD.DEAL_NUM <> '' AND
(CAST(SUBSTR(DCD.DEAL_NUM,3,2) AS INT) BETWEEN 1 AND 53) AND
DCD.DEAL_TYPE_NM = 'PROMO' 

GROUP BY
DC.D_YR,
DC.D_WK,
D_WK_START_ID,
D_WK_END_ID,
CSIF.PRODUCT_ID,
PCD.PRODUCT_NUM
)

SELECT
PS.DEAL_YR_CD,
PS.D_WK,
PS.D_WK_START_ID,
PS.D_WK_END_ID,
PS.DEAL_NUM_CD,
PS.PRODUCT_NUM,
NVL(SALES.NET_POS,0) AS POS,
NVL(SALES.NET_QTY,0) AS QTY,
(CASE WHEN PS.PRODUCT_ID = SALES.PRODUCT_ID THEN 1 ELSE 0 END) AS SKU_SOLD,
(CASE WHEN SALES.PRODUCT_ID IS NULL THEN 1 ELSE 0 END) AS SKU_NOT_SOLD

FROM
PI_SKU PS
LEFT JOIN
POS SALES
ON
PS.PRODUCT_ID = SALES.PRODUCT_ID AND
PS.DEAL_YR_CD = SALES.D_YR AND
PS.D_WK = SALES.D_WK AND
PS.D_WK_START_ID = SALES.D_WK_START_ID AND
PS.D_WK_END_ID = SALES.D_WK_END_ID

GROUP BY
PS.DEAL_YR_CD,
PS.D_WK,
PS.D_WK_START_ID,
PS.D_WK_END_ID,
PS.DEAL_NUM_CD,
PS.PRODUCT_NUM,
POS,
QTY,
SKU_SOLD,
SKU_NOT_SOLD
;
