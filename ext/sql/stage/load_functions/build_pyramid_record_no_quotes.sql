-- TODO:add variables for geometry and geoname columns
-- TODO:check number columns
-- TODO:check that population column names are following the predefined pattern (e.g. xx??, xy??)
-- TODO: replace ranges CTE by a loop
CREATE OR REPLACE FUNCTION stage.build_pyramid_record(table_name text, who_uploaded_p text, what_project_p text,when_reference_p text, whose_provider_p text, whose_url_p text, what_project_short_p text, whose_provider_short_p text) 
	RETURNS TABLE(
	who_uploaded text,
	what_project text,
	what_data ods.pyrint[],
	where_geoname text,
	where_boundary geometry,
	when_reference date,
	when_accessed timestamp with time zone,
	whose_provider text,
	whose_url text,
	what_variables ods.pyrvars[],
	what_project_short text,
	whose_provider_short text,
	where_centroid geometry
    )
   AS
$func$
BEGIN


RETURN QUERY

WITH rangos AS (
      
SELECT *,
int4range(0,1,'[)') AS rxy_0_1,
int4range(1,2,'[)') AS rxy_1_2,
int4range(2,3,'[)') AS rxy_2_3,
int4range(3,4,'[)') AS rxy_3_4,
int4range(4,5,'[)') AS rxy_4_5,
int4range(5,6,'[)') AS rxy_5_6,
int4range(6,7,'[)') AS rxy_6_7,
int4range(7,8,'[)') AS rxy_7_8,
int4range(8,9,'[)') AS rxy_8_9,
int4range(9,10,'[)') AS rxy_9_10,
int4range(10,11,'[)') AS rxy_10_11,
int4range(11,12,'[)') AS rxy_11_12,
int4range(12,13,'[)') AS rxy_12_13,
int4range(13,14,'[)') AS rxy_13_14,
int4range(14,15,'[)') AS rxy_14_15,
int4range(15,16,'[)') AS rxy_15_16,
int4range(16,17,'[)') AS rxy_16_17,
int4range(17,18,'[)') AS rxy_17_18,
int4range(18,19,'[)') AS rxy_18_19,
int4range(19,20,'[)') AS rxy_19_20,
int4range(20,21,'[)') AS rxy_20_21,
int4range(21,22,'[)') AS rxy_21_22,
int4range(22,23,'[)') AS rxy_22_23,
int4range(23,24,'[)') AS rxy_23_24,
int4range(24,25,'[)') AS rxy_24_25,
int4range(25,26,'[)') AS rxy_25_26,
int4range(26,27,'[)') AS rxy_26_27,
int4range(27,28,'[)') AS rxy_27_28,
int4range(28,29,'[)') AS rxy_28_29,
int4range(29,30,'[)') AS rxy_29_30,
int4range(30,31,'[)') AS rxy_30_31,
int4range(31,32,'[)') AS rxy_31_32,
int4range(32,33,'[)') AS rxy_32_33,
int4range(33,34,'[)') AS rxy_33_34,
int4range(34,35,'[)') AS rxy_34_35,
int4range(35,36,'[)') AS rxy_35_36,
int4range(36,37,'[)') AS rxy_36_37,
int4range(37,38,'[)') AS rxy_37_38,
int4range(38,39,'[)') AS rxy_38_39,
int4range(39,40,'[)') AS rxy_39_40,
int4range(40,41,'[)') AS rxy_40_41,
int4range(41,42,'[)') AS rxy_41_42,
int4range(42,43,'[)') AS rxy_42_43,
int4range(43,44,'[)') AS rxy_43_44,
int4range(44,45,'[)') AS rxy_44_45,
int4range(45,46,'[)') AS rxy_45_46,
int4range(46,47,'[)') AS rxy_46_47,
int4range(47,48,'[)') AS rxy_47_48,
int4range(48,49,'[)') AS rxy_48_49,
int4range(49,50,'[)') AS rxy_49_50,
int4range(50,51,'[)') AS rxy_50_51,
int4range(51,52,'[)') AS rxy_51_52,
int4range(52,53,'[)') AS rxy_52_53,
int4range(53,54,'[)') AS rxy_53_54,
int4range(54,55,'[)') AS rxy_54_55,
int4range(55,56,'[)') AS rxy_55_56,
int4range(56,57,'[)') AS rxy_56_57,
int4range(57,58,'[)') AS rxy_57_58,
int4range(58,59,'[)') AS rxy_58_59,
int4range(59,60,'[)') AS rxy_59_60,
int4range(60,61,'[)') AS rxy_60_61,
int4range(61,62,'[)') AS rxy_61_62,
int4range(62,63,'[)') AS rxy_62_63,
int4range(63,64,'[)') AS rxy_63_64,
int4range(64,65,'[)') AS rxy_64_65,
int4range(65,66,'[)') AS rxy_65_66,
int4range(66,67,'[)') AS rxy_66_67,
int4range(67,68,'[)') AS rxy_67_68,
int4range(68,69,'[)') AS rxy_68_69,
int4range(69,70,'[)') AS rxy_69_70,
int4range(70,71,'[)') AS rxy_70_71,
int4range(71,72,'[)') AS rxy_71_72,
int4range(72,73,'[)') AS rxy_72_73,
int4range(73,74,'[)') AS rxy_73_74,
int4range(74,75,'[)') AS rxy_74_75,
int4range(75,76,'[)') AS rxy_75_76,
int4range(76,77,'[)') AS rxy_76_77,
int4range(77,78,'[)') AS rxy_77_78,
int4range(78,79,'[)') AS rxy_78_79,
int4range(79,80,'[)') AS rxy_79_80,
int4range(80,81,'[)') AS rxy_80_81,
int4range(81,82,'[)') AS rxy_81_82,
int4range(82,83,'[)') AS rxy_82_83,
int4range(83,84,'[)') AS rxy_83_84,
int4range(84,85,'[)') AS rxy_84_85,
int4range(85,86,'[)') AS rxy_85_86,
int4range(86,87,'[)') AS rxy_86_87,
int4range(87,88,'[)') AS rxy_87_88,
int4range(88,89,'[)') AS rxy_88_89,
int4range(89,90,'[)') AS rxy_89_90,
int4range(90,91,'[)') AS rxy_90_91,
int4range(91,92,'[)') AS rxy_91_92,
int4range(92,93,'[)') AS rxy_92_93,
int4range(93,94,'[)') AS rxy_93_94,
int4range(94,95,'[)') AS rxy_94_95,
int4range(95,96,'[)') AS rxy_95_96,
int4range(96,97,'[)') AS rxy_96_97,
int4range(97,98,'[)') AS rxy_97_98,
int4range(98,99,'[)') AS rxy_98_99,
int4range(99,100,'[)') AS rxy_99_100,
int4range(100,null,'[)') AS rxy_100m
FROM table_name::
     
     ), melt AS (
   
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy0 as xy, xx0 as xx, rxy_0_1 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy1 as xy, xx1 as xx, rxy_1_2 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy2 as xy, xx2 as xx, rxy_2_3 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy3 as xy, xx3 as xx, rxy_3_4 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy4 as xy, xx4 as xx, rxy_4_5 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy5 as xy, xx5 as xx, rxy_5_6 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy6 as xy, xx6 as xx, rxy_6_7 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy7 as xy, xx7 as xx, rxy_7_8 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy8 as xy, xx8 as xx, rxy_8_9 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy9 as xy, xx9 as xx, rxy_9_10 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy10 as xy, xx10 as xx, rxy_10_11 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy11 as xy, xx11 as xx, rxy_11_12 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy12 as xy, xx12 as xx, rxy_12_13 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy13 as xy, xx13 as xx, rxy_13_14 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy14 as xy, xx14 as xx, rxy_14_15 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy15 as xy, xx15 as xx, rxy_15_16 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy16 as xy, xx16 as xx, rxy_16_17 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy17 as xy, xx17 as xx, rxy_17_18 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy18 as xy, xx18 as xx, rxy_18_19 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy19 as xy, xx19 as xx, rxy_19_20 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy20 as xy, xx20 as xx, rxy_20_21 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy21 as xy, xx21 as xx, rxy_21_22 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy22 as xy, xx22 as xx, rxy_22_23 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy23 as xy, xx23 as xx, rxy_23_24 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy24 as xy, xx24 as xx, rxy_24_25 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy25 as xy, xx25 as xx, rxy_25_26 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy26 as xy, xx26 as xx, rxy_26_27 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy27 as xy, xx27 as xx, rxy_27_28 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy28 as xy, xx28 as xx, rxy_28_29 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy29 as xy, xx29 as xx, rxy_29_30 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy30 as xy, xx30 as xx, rxy_30_31 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy31 as xy, xx31 as xx, rxy_31_32 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy32 as xy, xx32 as xx, rxy_32_33 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy33 as xy, xx33 as xx, rxy_33_34 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy34 as xy, xx34 as xx, rxy_34_35 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy35 as xy, xx35 as xx, rxy_35_36 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy36 as xy, xx36 as xx, rxy_36_37 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy37 as xy, xx37 as xx, rxy_37_38 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy38 as xy, xx38 as xx, rxy_38_39 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy39 as xy, xx39 as xx, rxy_39_40 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy40 as xy, xx40 as xx, rxy_40_41 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy41 as xy, xx41 as xx, rxy_41_42 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy42 as xy, xx42 as xx, rxy_42_43 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy43 as xy, xx43 as xx, rxy_43_44 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy44 as xy, xx44 as xx, rxy_44_45 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy45 as xy, xx45 as xx, rxy_45_46 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy46 as xy, xx46 as xx, rxy_46_47 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy47 as xy, xx47 as xx, rxy_47_48 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy48 as xy, xx48 as xx, rxy_48_49 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy49 as xy, xx49 as xx, rxy_49_50 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy50 as xy, xx50 as xx, rxy_50_51 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy51 as xy, xx51 as xx, rxy_51_52 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy52 as xy, xx52 as xx, rxy_52_53 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy53 as xy, xx53 as xx, rxy_53_54 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy54 as xy, xx54 as xx, rxy_54_55 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy55 as xy, xx55 as xx, rxy_55_56 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy56 as xy, xx56 as xx, rxy_56_57 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy57 as xy, xx57 as xx, rxy_57_58 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy58 as xy, xx58 as xx, rxy_58_59 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy59 as xy, xx59 as xx, rxy_59_60 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy60 as xy, xx60 as xx, rxy_60_61 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy61 as xy, xx61 as xx, rxy_61_62 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy62 as xy, xx62 as xx, rxy_62_63 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy63 as xy, xx63 as xx, rxy_63_64 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy64 as xy, xx64 as xx, rxy_64_65 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy65 as xy, xx65 as xx, rxy_65_66 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy66 as xy, xx66 as xx, rxy_66_67 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy67 as xy, xx67 as xx, rxy_67_68 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy68 as xy, xx68 as xx, rxy_68_69 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy69 as xy, xx69 as xx, rxy_69_70 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy70 as xy, xx70 as xx, rxy_70_71 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy71 as xy, xx71 as xx, rxy_71_72 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy72 as xy, xx72 as xx, rxy_72_73 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy73 as xy, xx73 as xx, rxy_73_74 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy74 as xy, xx74 as xx, rxy_74_75 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy75 as xy, xx75 as xx, rxy_75_76 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy76 as xy, xx76 as xx, rxy_76_77 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy77 as xy, xx77 as xx, rxy_77_78 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy78 as xy, xx78 as xx, rxy_78_79 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy79 as xy, xx79 as xx, rxy_79_80 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy80 as xy, xx80 as xx, rxy_80_81 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy81 as xy, xx81 as xx, rxy_81_82 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy82 as xy, xx82 as xx, rxy_82_83 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy83 as xy, xx83 as xx, rxy_83_84 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy84 as xy, xx84 as xx, rxy_84_85 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy85 as xy, xx85 as xx, rxy_85_86 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy86 as xy, xx86 as xx, rxy_86_87 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy87 as xy, xx87 as xx, rxy_87_88 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy88 as xy, xx88 as xx, rxy_88_89 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy89 as xy, xx89 as xx, rxy_89_90 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy90 as xy, xx90 as xx, rxy_90_91 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy91 as xy, xx91 as xx, rxy_91_92 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy92 as xy, xx92 as xx, rxy_92_93 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy93 as xy, xx93 as xx, rxy_93_94 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy94 as xy, xx94 as xx, rxy_94_95 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy95 as xy, xx95 as xx, rxy_95_96 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy96 as xy, xx96 as xx, rxy_96_97 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy97 as xy, xx97 as xx, rxy_97_98 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy98 as xy, xx98 as xx, rxy_98_99 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy99 as xy, xx99 as xx, rxy_99_100 as age FROM rangos UNION 
SELECT where_geon AS where_geoname, wkb_geometry AS where_boundary, xy100 as xy, xx100 as xx, rxy_100m as age FROM rangos
       
     ), agg AS (
      
SELECT where_geoname, where_boundary, array_agg(xy ORDER BY age) AS xy, array_agg(xx ORDER BY age) AS xx, array_agg(age ORDER BY age) AS age
FROM melt
GROUP BY where_geoname, where_boundary
       
     ), metadata AS (
       
SELECT
who_uploaded_p AS who_uploaded,
what_project_p AS what_project,
where_geoname,
where_boundary,
ST_centroid(where_boundary) AS where_centroid,

when_reference_p ::date  AS when_reference,
now() AS when_accessed,

whose_provider_p AS whose_provider,
whose_url_p AS whose_url,

what_project_short_p AS what_project_short,
whose_provider_short_p AS whose_provider_short,

xy AS data_xy,
xx AS data_xx,
age AS data_age

FROM agg
     
     ), final AS (
      
SELECT 
  who_uploaded,
  what_project,
  ARRAY[(data_age,data_xy,data_xx)::ods.pyrint] AS what_data,
  where_geoname,
  where_boundary,
  when_reference,
  when_accessed,
  whose_provider,
  whose_url,
  ARRAY['Population'::ods.pyrvars] AS what_variables, --TODO: Define as function parameter
  what_project_short,
  whose_provider_short,
  where_centroid
  
  FROM meta
      
     )

SELECT * FROM final;


END
$func$
LANGUAGE plpgsql;
