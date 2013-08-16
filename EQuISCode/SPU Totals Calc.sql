USE [SEA_PU]
GO

/****** Object:  StoredProcedure [dbo].[SPU_Totals_Calc]    Script Date: 03/04/2013 10:52:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





ALTER PROCEDURE [dbo].[SPU_Totals_Calc]
	(
		@facility_id int
		,@ND_mult float 
		,@SDG varchar (2000) 
		,@TEF varchar (200)
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @SDG_T table (SDG varchar (200))
		Insert into @SDG_T
		Select cast(s.value as varchar(20)) sdg from fn_split(@SDG) as s
		
	Declare @Result table (al_code varchar (200), loc varchar(200), s_date varchar (200), sampID varchar (200)
	,test_ID int ,facility_id int, samptype varchar (20), matrix varchar (20),unit varchar (20),  reportable varchar(20)
	,TEQ varchar(200),  cnt varchar (2000),SDG varchar (200), detect_flag varchar (20), mRL varchar(200),quals varchar(20))

	INSERT into @result
	SELECT  alp.action_level_code
		,s.sys_loc_code
		,s.sample_date
		,sys_sample_code
		,t.test_id
		,s.facility_id
		, s.sample_type_code
		,s.matrix_code
		,r.result_unit 
		, r.reportable_result
		,sum (case when r.detect_flag = 'Y' then cast(result_text as float) * cast(alp.action_level  as float) 
			else (cast (@ND_mult as float) * cast(coalesce(r.reporting_detection_limit,r.result_text) as float)) * cast(alp.action_level as float) end) as 'TEQ'
		,COUNT(r.cas_rn) as 'Conjourner Count'
		,t.lab_sdg
		,max(case when detect_flag = 'Y' then 'Y' else 'N' end)
		,max(r.reporting_detection_limit)
		,max(case when r.interpreted_qualifiers='R' then 'R' else (case when r.interpreted_qualifiers='J' then 'J' end)end) as 'quals'
	FROM dt_sample s
		inner join dt_test t on  s.facility_id = t.facility_id and s.sample_id = t.sample_id
		inner join dt_result r on  t.facility_id = r.facility_id and t.test_id = r.test_id
		inner join dt_action_level_parameter alp on r.cas_rn = alp.param_code 
		inner join @SDG_T ST on t.lab_sdg = ST.sdg

	WHERE
		alp.action_level_code = @TEF 
		and r.reportable_result = 'Y' 
		and sample_source = 'field'
		and s.facility_id = @facility_id

	GROUP BY alp.action_level_code, s.sys_loc_code,   s.sample_date, s.sys_sample_code, t.test_id, s.facility_id, s.sample_type_code
	,s.matrix_code, r.result_unit , t.lab_sdg
	, reportable_result 
	
	--create as CalcEDD
select 
	 r.sampid as 'sys_sample_code'
	,s.sample_type_code, s.matrix_code
	,cast(s.sample_date as date) as 'sample_date'
	,cast(s.sample_date as time) as 'sample_time'
	,s.sys_loc_code
	,t.lab_name_code
	,'Calculated' as 'lab_anl_method_name'
	,cast(getdate() as date) as 'analysis_date'
	,cast(datepart(hour,getdate()) as varchar)+ ':' + CAST(datepart(minute, getdate())as varchar) as	'analysis_time'
	,t.test_type
	,@TEF + '_' + cast(cast(getdate() as date) as varchar) as 'test_batch_id'
	,t.lab_sample_id
	,t.basis
	,Replace(@TEF,'TEF','TEQ') as 'cas_rn'
	,Replace(@TEF,'TEF','TEQ')as 'chemical_name'
	,case when r.detect_flag='N' then r.mRL else r.TEQ end as 'result_value'
	,r.unit as 'result_unit'
	,r.detect_flag as 'detect_flag'
	,case when r.detect_flag = 'N' then r.mRL else Null end as 'detection_limit_used'
	,case when r.detect_flag='N' then 'U' else r.quals end as 'qualifiers'
	,'Conjouner Cnt = '+ r.[cnt] +';(SDG:' + r.SDG + ') Calculated on ' + cast(cast(getdate() as date) as varchar) as 'comment'
	,s.parent_sample_code as 'parent_sample_code'
	,t.fraction as 'fraction'
	,s.sample_source as 'sample_source'
	,r.SDG as 'sdg'

	

from @result r
	inner join dt_sample s on r.sampid = s.sys_sample_code and r.facility_id = s.facility_id
	inner join dt_test t on s.facility_id = t.facility_id and s.sample_id = t.sample_id and r.test_id = t.test_id


END




GO

