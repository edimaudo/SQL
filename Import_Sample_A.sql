INSERT INTO EDWPRDBW..CONSUMERROLE_PRODUCTPROFILE 
SELECT * FROM EXTERNAL 
'C:\Weherever\ProductProfile.csv' 
USING (DELIM ',' REMOTESOURCE 'jdbc' QUOTEDVALUE DOUBLE);