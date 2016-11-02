CREATE TABLE EDWPRDBW..LMS_RPT AS
(
WITH GET_AGE_PC AS
(
SELECT 
'LOYALTY' AS GRP,
LMSDATA.LOYALTY_NUMBER_EVAR56, 
CUSTADD.POSTAL_CD,
(CASE WHEN SUBSTR(CUSTADD.POSTAL_CD,2,1) = '0' THEN CUSTADD.POSTAL_CD ELSE SUBSTR(CUSTADD.POSTAL_CD,1,3) END) AS FSA,
(CASE WHEN (DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR',CAST(MAX(CUST.BIRTH_DATE) AS DATE))) Between 20 And 29 THEN 1 ELSE 0 END) AS AgeGrp_20_29,
(CASE WHEN (DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR',CAST(MAX(CUST.BIRTH_DATE) AS DATE))) Between 30 And 49 THEN 1 ELSE 0 END) AS AgeGrp_30_49,
(CASE WHEN (DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR',CAST(MAX(CUST.BIRTH_DATE) AS DATE))) Between 50 And 65 THEN 1 ELSE 0 END) AS AgeGrp_50_65,
(CASE WHEN (DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR',CAST(MAX(CUST.BIRTH_DATE) AS DATE))) > 65 THEN 1 ELSE 0 END) AS AgeGrp_65p,
CUST.GENDER_CD,
(CASE WHEN CUST.GENDER_CD = 'M' THEN 1 ELSE 0 END) AS MALE,
(CASE WHEN CUST.GENDER_CD = 'F' THEN 1 ELSE 0 END) AS FEMALE,

CASE 
        WHEN (DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR',CAST(MAX(CUST.BIRTH_DATE) AS DATE))) Between 20 And 29 THEN 'A'
        
        WHEN (DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR',CAST(MAX(CUST.BIRTH_DATE) AS DATE))) Between 30 And 49 THEN 'B'
        
        WHEN (DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR',CAST(MAX(CUST.BIRTH_DATE) AS DATE))) Between 50 And 65 THEN 'C'
        
        WHEN (DATE_PART('YEAR',CURRENT_DATE) - DATE_PART('YEAR',CAST(MAX(CUST.BIRTH_DATE) AS DATE))) > 65 THEN 'D' 
        
        ELSE 'X' 
END AS AGE_GRP_IND


FROM 
EDWPRDBW..LMS LMSDATA,
EDWPRD..LOYALTY_ CUSTADD,
EDWPRD..LOYALTY_ CUST

WHERE 
LMSDATA.LOYALTY_NUMBER_EVAR56 = CUST.SOURCE_LOYALTY_CUSTOMER_ID AND 
CUST.LOYALTY_CUSTOMER_ID = CUSTADD.LOYALTY_CUSTOMER_ID

GROUP BY
GRP,
LMSDATA.LOYALTY_NUMBER_EVAR56, 
CUSTADD.POSTAL_CD,
FSA,
CUST.GENDER_CD,
MALE,
FEMALE
)
,

GET_STORE_DETAIL AS
(
SELECT
TA.FSA,
SD.STORE_NBR,
SD.STORE_NAM,
SD.STORE_CITY,
SD.STORE_SIZE_CD,
SD.STORE_PROV,
SD.STORE_GEO_GROUP

FROM
EDWPRDBW..TRADE_AREAS TA,
EDWPRDBW..STORE_DIM SD

WHERE
TA.STORE_NUM = SD.STORE_NBR
)

SELECT
GAP.GRP,
GAP.LOYALTY_NUMBER_EVAR56,
GSD.STORE_PROV,
(CASE WHEN GSD.STORE_NBR IS NOT NULL THEN '"' || GSD.STORE_NBR || '"' ELSE '0000' END) AS STR_NUM,
GSD.STORE_NAM,
GSD.STORE_CITY,
GSD.STORE_SIZE_CD,
GSD.STORE_GEO_GROUP,
GAP.POSTAL_CD,
GAP.FSA,
GAP.GENDER_CD,
GAP.MALE,
GAP.FEMALE,
GAP.AGE_GRP_IND,
GAP.AgeGrp_20_29,
GAP.AgeGrp_30_49,
GAP.AgeGrp_50_65,
GAP.AgeGrp_65p,
LM.Campaign_Views,
LM.Campaign_Views_Participation,
LM.Cart_Additions,
LM.Cart_Additions_Participation,
LM.Cart_Removals,
LM.Cart_Removals_Participation,
LM.Carts_Open,
LM.Carts_Participation,
LM.Cart_Views,
LM.Cart_Views_Participation,
LM.Checkouts_O_R,
LM.Checkouts_Participation,
LM.Orders,
LM.Orders_Participation,
LM.Page_Views,
LM.Product_Views,
LM.Product_Views_Participation,
LM.Revenue_Participation,
LM.Revenue,
LM.Time_Spent_on_Page,
LM.Unique_Visitors,
LM.Units_Participation,
LM.Units,
LM.Visits,
LM.All_Visits,
LM.Activate_Loyalty_Offer_event73,
LM.Custom_73_Participation,
LM.Add_to_My_List_event31,
LM.Custom_31_Participation,
LM.Checkout_Start_event13,
LM.Custom_13_Participation,
LM.Clicked_event17,
LM.LM.CST_Faild_Search_event72,
LM.CT_Money_Redeemed_event3,
LM.eFlyer_sign_up_sources_Instance_Instance_of_evar34,
LM.eFlyer_Signup_event9,
LM.Failed_Search_event8,
LM.Get_Store_Directions_event57,
LM.iFlyer_Page_View_event58,
LM.Left_Nav_Refinement_event22,
LM.Limited_PDP_View_event74,
LM.Login_to_MyCT_event28,
LM.Loyalty_Offer_Redemption_Units_event76,
LM.Loyalty_Registration_New_event5,
LM.Make_This_My_Store_event55,
LM.Opened_event11,
LM.Page_View_event18,
LM.Print_My_List_event32,
LM.Product_Views_for_Merchandising_event12,
LM.Read_a_Review_event33,
LM.Sale_Alert_event30,
LM.Write_a_Review_event29

FROM
GET_AGE_PC GAP
INNER JOIN
EDWPRDBW..LMS LM
ON
GAP.LOYALTY_NUMBER_EVAR56 = LM.LOYALTY_NUMBER_EVAR56

LEFT JOIN
GET_STORE_DETAIL GSD
ON
GAP.FSA = GSD.FSA
)
