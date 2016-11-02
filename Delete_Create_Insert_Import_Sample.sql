DELETE

FROM
EDWPRDBW..DAILY_PROD_VIEWS_RAW
;

CREATE TABLE EDWPRDBW..SKU_LIST
(
MTH SMALLINT,
SKU VARCHAR(7)
)

INSERT INTO EDWPRDBW..SKU_LIST
SELECT * FROM EXTERNAL 
'X:\Whereever\Sku_List.csv'
USING (DELIM ',' REMOTESOURCE 'jdbc' IGNOREZERO YES QUOTEDVALUE DOUBLE
LOGDIR 'X:\WhereverLog\');

