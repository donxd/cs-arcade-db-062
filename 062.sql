/*Please add ; after each select statement*/
CREATE PROCEDURE checkExpenditure()
BEGIN
    SELECT 
    d1.id,
    CASE 
        WHEN (d1.value > d1.summ) THEN 0 ELSE (d1.summ - d1.value)
    END as loss
    FROM (
        SELECT 
        dataGroup.id,
        dataGroup.value,
        SUM(expenditure_sum) as summ
        FROM (
            SELECT 
            ae.*,
            ep.*
            FROM allowable_expenditure ae INNER JOIN 
            expenditure_plan ep ON ae.left_bound <= WEEK(ep.monday_date) AND ae.right_bound >= WEEK(ep.monday_date)
        ) dataGroup
        GROUP BY dataGroup.id
    ) d1
    ;
END