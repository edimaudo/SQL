CREATE TABLE EDWPRDBW..GRP_PROMO_WK_MTH_NM AS
(
SELECT
D_WK,
(CASE
        WHEN D_MTH = 1 THEN 'JAN'
        WHEN D_MTH = 2 THEN 'FEB'
        WHEN D_MTH = 3 THEN 'MAR'
        WHEN D_MTH = 4 THEN 'APR'
        WHEN D_MTH = 5 THEN 'MAY'
        WHEN D_MTH = 6 THEN 'JUN'
        WHEN D_MTH = 7 THEN 'JUL'
        WHEN D_MTH = 8 THEN 'AUG'
        WHEN D_MTH = 9 THEN 'SEP'
        WHEN D_MTH = 10 THEN 'OCT'
        WHEN D_MTH = 11 THEN 'NOV'
        WHEN D_MTH = 12 THEN 'DEC'
END) AS MTH_NM

FROM
GRP_PROMO_CALENDAR

WHERE
D_WK BETWEEN 1 AND 52

GROUP BY
D_WK,
MTH_NM
)