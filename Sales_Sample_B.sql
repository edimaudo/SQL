WITH 
TXNCNT AS
(
SELECT 
CD.C445_YR_NUM AS YR_NUM,
PCD.DIVISION_NM,
(CASE 
WHEN SCD.PROVINCE_NM = 'BRITISH COLUMBIA' OR SCD.PROVINCE_NM = 'NORTHWEST TERRITORIES' OR SCD.PROVINCE_NM = 'YUKON TERRITORY' THEN 'BC & TERRITORIES' 
WHEN SCD.PROVINCE_NM = 'NEW BRUNSWICK' OR SCD.PROVINCE_NM = 'PEI' THEN 'NEW BRUNSWICK & PEI' 
ELSE SCD.PROVINCE_NM 
END) AS PROVINCE,
COUNT (DISTINCT CSIF.POS_TRANSACTION_ID) AS BSKTCNT

FROM
EDWPRD..CTR_SALES_ITEM_FCT CSIF,
EDWPRD..PRODUCT_CURRENT_DIM PCD,
EDWPRD..STORE_CURRENT_DIM SCD,
EDWPRD..CALENDAR_DIM CD

WHERE
CSIF.DAY_ID = CD.DAY_ID AND
CSIF.PRODUCT_ID = PCD.PRODUCT_ID AND
PCD.PRODUCT_NUM_SOURCE_CD = 'IMS' AND
PCD.PRODUCT_NUM<>'N/A' AND
PCD.FINELINE_CD<>'97047' AND
PCD.CORPORATE_STATUS_CD<>'DEL' AND
PCD.SBU_NM = 'Canadian Tire Retail' AND
(PCD.PRODUCT_CLASS_NUM NOT BETWEEN '090' AND '098') AND 
PCD.DIVISION_CD Not In ('NM','N/A','00') AND 
CSIF.STORE_ID = SCD.ORGANIZATION_UNIT_ID AND
(
(CD.C445_YR_NUM = 2015 AND (CD.C445_WK_NUM BETWEEN 9 AND 13))
OR
(CD.C445_YR_NUM IN(2014) AND (CD.C445_WK_NUM BETWEEN 10 AND 14))
)
AND
((CSIF.ITEM_TRANSACTION_QTY + CSIF.ITEM_RETURN_QUANTITY) * CSIF.ITEM_ACTUAL_SELLING_PRICE_AMT) > 0

GROUP BY
YR_NUM,
PCD.DIVISION_NM,
PROVINCE
)
,

NETPOS AS
(
SELECT
CD.C445_YR_NUM AS YR_NUM,
PCD.DIVISION_NM,
(CASE 
WHEN SCD.PROVINCE_NM = 'BRITISH COLUMBIA' OR SCD.PROVINCE_NM = 'NORTHWEST TERRITORIES' OR SCD.PROVINCE_NM = 'YUKON TERRITORY' THEN 'BC & TERRITORIES' 
WHEN SCD.PROVINCE_NM = 'NEW BRUNSWICK' OR SCD.PROVINCE_NM = 'PEI' THEN 'NEW BRUNSWICK & PEI' 
ELSE SCD.PROVINCE_NM 
END) AS PROVINCE,
COUNT (DISTINCT CSIF.POS_TRANSACTION_ID) AS BSKTCNT,
Sum((CSIF.ITEM_TRANSACTION_QTY + CSIF.ITEM_RETURN_QUANTITY) * CSIF.ITEM_ACTUAL_SELLING_PRICE_AMT) AS F_POS

FROM
EDWPRD..CTR_SALES_ITEM_FCT CSIF,
EDWPRD..PRODUCT_CURRENT_DIM PCD,
EDWPRD..STORE_CURRENT_DIM SCD,
EDWPRD..CALENDAR_DIM CD

WHERE
CD.DAY_ID = CSIF.DAY_ID AND 
(
(CD.C445_YR_NUM = 2015 AND (CD.C445_WK_NUM BETWEEN 9 AND 13))
OR
(CD.C445_YR_NUM IN(2014) AND (CD.C445_WK_NUM BETWEEN 10 AND 14))
)
AND
PCD.PRODUCT_ID = CSIF.PRODUCT_ID AND
PCD.PRODUCT_NUM_SOURCE_CD = 'IMS' AND
PCD.PRODUCT_NUM<>'N/A' AND
PCD.FINELINE_CD<>'97047' AND
PCD.CORPORATE_STATUS_CD<>'DEL' AND
PCD.SBU_NM = 'Canadian Tire Retail' AND
(PCD.PRODUCT_CLASS_NUM NOT BETWEEN '090' And '098') And 
PCD.DIVISION_CD Not In ('NM','N/A','00') AND 
CSIF.STORE_ID = SCD.ORGANIZATION_UNIT_ID

GROUP BY
YR_NUM,
PCD.DIVISION_NM,
PROVINCE
)

SELECT
CUSTCNT.YR_NUM,
CUSTCNT.DIVISION_NM,
CUSTCNT.PROVINCE,
CUSTCNT.BSKTCNT,
POS.F_POS

FROM
TXNCNT CUSTCNT,
NETPOS POS

WHERE
CUSTCNT.YR_NUM = POS.YR_NUM AND
CUSTCNT.DIVISION_NM = POS.DIVISION_NM AND
CUSTCNT.PROVINCE = POS.PROVINCE
;
