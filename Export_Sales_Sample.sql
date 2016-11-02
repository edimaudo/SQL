CREATE EXTERNAL TABLE 'C:\Wherever\TextFile.txt' USING (DELIM '|' remotesource 'jdbc') AS
SELECT * FROM EDWPRDBW..MyWorkspaceTable
