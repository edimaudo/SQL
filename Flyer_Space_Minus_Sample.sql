DROP TABLE EDWPRDBW..FLYER_SPACE_STAGING;
--------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE EDWPRDBW..FLYER_SPACE_STAGING
(
YR SMALLINT,
WK SMALLINT,
DEAL VARCHAR(4),
DIV VARCHAR(40),
LOB VARCHAR(40),
CAT VARCHAR(40),
FLY_SPC NUMERIC(9,5)
)
;
-------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE EDWPRDBW..FLYER_SPACE_DEST_DEALS
(
YR SMALLINT,
WK SMALLINT,
DEAL VARCHAR(4)
)
;
--------------------------------------------------------------------------------------------------------------------------------
DELETE
FROM
EDWPRDBW..FLYER_SPACE_STAGING;
--------------------------------------------------------------------------------------------------------------------------------
DELETE
FROM
EDWPRDBW..FLYER_SPACE_DEST_DEALS;
--------------------------------------------------------------------------------------------------------------------------------
INSERT INTO EDWPRDBW..FLYER_SPACE_STAGING
SELECT * FROM EXTERNAL 
'C:\Wherever\FlyerSpace.csv'
USING (DELIM ',' REMOTESOURCE 'jdbc' IGNOREZERO YES QUOTEDVALUE DOUBLE SKIPROWS 1
)
;
--------------------------------------------------------------------------------------------------------------------------------
INSERT INTO EDWPRDBW..FLYER_SPACE_DEST_DEALS
SELECT * FROM EXTERNAL 
'C:\Wherever\FlyerSpace_DestDeal.csv'
USING (DELIM ',' REMOTESOURCE 'jdbc' IGNOREZERO YES QUOTEDVALUE DOUBLE SKIPROWS 1
)
;
--------------------------------------------------------------------------------------------------------------------------------
DROP TABLE EDWPRDBW..FLYER_SPACE_FINAL;
--------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE EDWPRDBW..FLYER_SPACE_FINAL AS
(
WITH GRP_FLYSPC
AS
(
SELECT
YR,
WK,
DEAL

FROM
EDWPRDBW..FLYER_SPACE_STAGING

GROUP BY
YR,
WK,
DEAL
)
,
REMOVE_DESTDEALS
AS
(
SELECT * FROM GRP_FLYSPC
MINUS
SELECT * FROM EDWPRDBW..FLYER_SPACE_DEST_DEALS
)

SELECT
FSS.YR,
FSS.WK,
FSS.DIV,
FSS.LOB,
FSS.CAT,
SUM(FSS.FLY_SPC) AS FLY_SPACE

FROM
EDWPRDBW..FLYER_SPACE_STAGING FSS,
REMOVE_DESTDEALS ND

WHERE
FSS.YR = ND.YR AND
FSS.WK = ND.WK AND
FSS.DEAL = ND.DEAL

GROUP BY
FSS.YR,
FSS.WK,
FSS.DIV,
FSS.LOB,
FSS.CAT
)
--------------------------------------------------------------------------------------------------------------------------------
--Data validation sql below.

WITH SUMLABEL AS
(
SELECT
YR,
WK,
(CASE WHEN DIV <> 'NON_LOB_SPACE' THEN 'ALL' ELSE DIV END) AS SUMRY,
FLY_SPACE

FROM
EDWPRDBW..FLYER_SPACE_FINAL
)

SELECT
YR,
WK,
SUMRY,
SUM(FLY_SPACE) AS FLY_SPC

FROM
SUMLABEL

GROUP BY
YR,
WK,
SUMRY

ORDER BY
YR,
WK,
SUMRY
;
