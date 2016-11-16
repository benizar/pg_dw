
/*SELECT * 
FROM stage.build_pyramid_records('censo_1991_ccaa',
				'codine',
				'ccaa',
				'codine',
				'wkb_geometry',
				'geoname',
				'Benito Zaragozí', 
				'Censo de Población y Viviendas 1991. Resultados por Comunidades Autónomas',
				'1991-11-1',
				'Instituto Nacional de Estadística', 
				'http://www.ine.es/', 
				'INE (Spain)', 
				'censo_1991_ccaa');*/


-- TODO:check number columns
-- TODO:check that population column names are following the predefined pattern (e.g. xx??, xy??)
-- TODO: replace ranges CTE by a loop

CREATE OR REPLACE FUNCTION stage.build_pyramid_records(table_name text, table_name_id text, spatial_table_name text, spatial_table_name_id text, col_geom text, col_geoname text, who_uploaded text, what_project text, when_reference text, whose_provider text, whose_url text, whose_provider_id text, what_project_id text) 
	RETURNS TABLE(
	backer text,
	project text,
	pyrdata ods.pyrint[],
	geoname text,
	boundary geometry,
	labelpoint geometry,
	refdate date,
	loadate timestamp with time zone,
	provider text,
	url text,
	pyrvariables ods.pyrvars[],
	project_id text,
	provider_id text
    )
   AS
$func$

BEGIN

RETURN QUERY

EXECUTE E'WITH rangos AS (
      
SELECT *,
int4range(0,1,\'[)\') AS rxy_0_1,
int4range(1,2,\'[)\') AS rxy_1_2,
int4range(2,3,\'[)\') AS rxy_2_3,
int4range(3,4,\'[)\') AS rxy_3_4,
int4range(4,5,\'[)\') AS rxy_4_5,
int4range(5,6,\'[)\') AS rxy_5_6,
int4range(6,7,\'[)\') AS rxy_6_7,
int4range(7,8,\'[)\') AS rxy_7_8,
int4range(8,9,\'[)\') AS rxy_8_9,
int4range(9,10,\'[)\') AS rxy_9_10,
int4range(10,11,\'[)\') AS rxy_10_11,
int4range(11,12,\'[)\') AS rxy_11_12,
int4range(12,13,\'[)\') AS rxy_12_13,
int4range(13,14,\'[)\') AS rxy_13_14,
int4range(14,15,\'[)\') AS rxy_14_15,
int4range(15,16,\'[)\') AS rxy_15_16,
int4range(16,17,\'[)\') AS rxy_16_17,
int4range(17,18,\'[)\') AS rxy_17_18,
int4range(18,19,\'[)\') AS rxy_18_19,
int4range(19,20,\'[)\') AS rxy_19_20,
int4range(20,21,\'[)\') AS rxy_20_21,
int4range(21,22,\'[)\') AS rxy_21_22,
int4range(22,23,\'[)\') AS rxy_22_23,
int4range(23,24,\'[)\') AS rxy_23_24,
int4range(24,25,\'[)\') AS rxy_24_25,
int4range(25,26,\'[)\') AS rxy_25_26,
int4range(26,27,\'[)\') AS rxy_26_27,
int4range(27,28,\'[)\') AS rxy_27_28,
int4range(28,29,\'[)\') AS rxy_28_29,
int4range(29,30,\'[)\') AS rxy_29_30,
int4range(30,31,\'[)\') AS rxy_30_31,
int4range(31,32,\'[)\') AS rxy_31_32,
int4range(32,33,\'[)\') AS rxy_32_33,
int4range(33,34,\'[)\') AS rxy_33_34,
int4range(34,35,\'[)\') AS rxy_34_35,
int4range(35,36,\'[)\') AS rxy_35_36,
int4range(36,37,\'[)\') AS rxy_36_37,
int4range(37,38,\'[)\') AS rxy_37_38,
int4range(38,39,\'[)\') AS rxy_38_39,
int4range(39,40,\'[)\') AS rxy_39_40,
int4range(40,41,\'[)\') AS rxy_40_41,
int4range(41,42,\'[)\') AS rxy_41_42,
int4range(42,43,\'[)\') AS rxy_42_43,
int4range(43,44,\'[)\') AS rxy_43_44,
int4range(44,45,\'[)\') AS rxy_44_45,
int4range(45,46,\'[)\') AS rxy_45_46,
int4range(46,47,\'[)\') AS rxy_46_47,
int4range(47,48,\'[)\') AS rxy_47_48,
int4range(48,49,\'[)\') AS rxy_48_49,
int4range(49,50,\'[)\') AS rxy_49_50,
int4range(50,51,\'[)\') AS rxy_50_51,
int4range(51,52,\'[)\') AS rxy_51_52,
int4range(52,53,\'[)\') AS rxy_52_53,
int4range(53,54,\'[)\') AS rxy_53_54,
int4range(54,55,\'[)\') AS rxy_54_55,
int4range(55,56,\'[)\') AS rxy_55_56,
int4range(56,57,\'[)\') AS rxy_56_57,
int4range(57,58,\'[)\') AS rxy_57_58,
int4range(58,59,\'[)\') AS rxy_58_59,
int4range(59,60,\'[)\') AS rxy_59_60,
int4range(60,61,\'[)\') AS rxy_60_61,
int4range(61,62,\'[)\') AS rxy_61_62,
int4range(62,63,\'[)\') AS rxy_62_63,
int4range(63,64,\'[)\') AS rxy_63_64,
int4range(64,65,\'[)\') AS rxy_64_65,
int4range(65,66,\'[)\') AS rxy_65_66,
int4range(66,67,\'[)\') AS rxy_66_67,
int4range(67,68,\'[)\') AS rxy_67_68,
int4range(68,69,\'[)\') AS rxy_68_69,
int4range(69,70,\'[)\') AS rxy_69_70,
int4range(70,71,\'[)\') AS rxy_70_71,
int4range(71,72,\'[)\') AS rxy_71_72,
int4range(72,73,\'[)\') AS rxy_72_73,
int4range(73,74,\'[)\') AS rxy_73_74,
int4range(74,75,\'[)\') AS rxy_74_75,
int4range(75,76,\'[)\') AS rxy_75_76,
int4range(76,77,\'[)\') AS rxy_76_77,
int4range(77,78,\'[)\') AS rxy_77_78,
int4range(78,79,\'[)\') AS rxy_78_79,
int4range(79,80,\'[)\') AS rxy_79_80,
int4range(80,81,\'[)\') AS rxy_80_81,
int4range(81,82,\'[)\') AS rxy_81_82,
int4range(82,83,\'[)\') AS rxy_82_83,
int4range(83,84,\'[)\') AS rxy_83_84,
int4range(84,85,\'[)\') AS rxy_84_85,
int4range(85,86,\'[)\') AS rxy_85_86,
int4range(86,87,\'[)\') AS rxy_86_87,
int4range(87,88,\'[)\') AS rxy_87_88,
int4range(88,89,\'[)\') AS rxy_88_89,
int4range(89,90,\'[)\') AS rxy_89_90,
int4range(90,91,\'[)\') AS rxy_90_91,
int4range(91,92,\'[)\') AS rxy_91_92,
int4range(92,93,\'[)\') AS rxy_92_93,
int4range(93,94,\'[)\') AS rxy_93_94,
int4range(94,95,\'[)\') AS rxy_94_95,
int4range(95,96,\'[)\') AS rxy_95_96,
int4range(96,97,\'[)\') AS rxy_96_97,
int4range(97,98,\'[)\') AS rxy_97_98,
int4range(98,99,\'[)\') AS rxy_98_99,
int4range(99,100,\'[)\') AS rxy_99_100,
int4range(100,null,\'[)\') AS rxy_100m
FROM stage_spatial.'||spatial_table_name||' shp
INNER JOIN stage.'||table_name||' AS csv ON shp.'||spatial_table_name_id||'=csv.'||table_name_id||'
     
     ), melt AS (
   
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_0_1 as xy, xx_0_1 as xx, rxy_0_1 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_1_2 as xy, xx_1_2 as xx, rxy_1_2 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_2_3 as xy, xx_2_3 as xx, rxy_2_3 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_3_4 as xy, xx_3_4 as xx, rxy_3_4 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_4_5 as xy, xx_4_5 as xx, rxy_4_5 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_5_6 as xy, xx_5_6 as xx, rxy_5_6 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_6_7 as xy, xx_6_7 as xx, rxy_6_7 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_7_8 as xy, xx_7_8 as xx, rxy_7_8 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_8_9 as xy, xx_8_9 as xx, rxy_8_9 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_9_10 as xy, xx_9_10 as xx, rxy_9_10 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_10_11 as xy, xx_10_11 as xx, rxy_10_11 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_11_12 as xy, xx_11_12 as xx, rxy_11_12 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_12_13 as xy, xx_12_13 as xx, rxy_12_13 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_13_14 as xy, xx_13_14 as xx, rxy_13_14 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_14_15 as xy, xx_14_15 as xx, rxy_14_15 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_15_16 as xy, xx_15_16 as xx, rxy_15_16 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_16_17 as xy, xx_16_17 as xx, rxy_16_17 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_17_18 as xy, xx_17_18 as xx, rxy_17_18 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_18_19 as xy, xx_18_19 as xx, rxy_18_19 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_19_20 as xy, xx_19_20 as xx, rxy_19_20 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_20_21 as xy, xx_20_21 as xx, rxy_20_21 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_21_22 as xy, xx_21_22 as xx, rxy_21_22 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_22_23 as xy, xx_22_23 as xx, rxy_22_23 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_23_24 as xy, xx_23_24 as xx, rxy_23_24 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_24_25 as xy, xx_24_25 as xx, rxy_24_25 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_25_26 as xy, xx_25_26 as xx, rxy_25_26 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_26_27 as xy, xx_26_27 as xx, rxy_26_27 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_27_28 as xy, xx_27_28 as xx, rxy_27_28 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_28_29 as xy, xx_28_29 as xx, rxy_28_29 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_29_30 as xy, xx_29_30 as xx, rxy_29_30 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_30_31 as xy, xx_30_31 as xx, rxy_30_31 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_31_32 as xy, xx_31_32 as xx, rxy_31_32 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_32_33 as xy, xx_32_33 as xx, rxy_32_33 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_33_34 as xy, xx_33_34 as xx, rxy_33_34 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_34_35 as xy, xx_34_35 as xx, rxy_34_35 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_35_36 as xy, xx_35_36 as xx, rxy_35_36 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_36_37 as xy, xx_36_37 as xx, rxy_36_37 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_37_38 as xy, xx_37_38 as xx, rxy_37_38 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_38_39 as xy, xx_38_39 as xx, rxy_38_39 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_39_40 as xy, xx_39_40 as xx, rxy_39_40 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_40_41 as xy, xx_40_41 as xx, rxy_40_41 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_41_42 as xy, xx_41_42 as xx, rxy_41_42 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_42_43 as xy, xx_42_43 as xx, rxy_42_43 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_43_44 as xy, xx_43_44 as xx, rxy_43_44 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_44_45 as xy, xx_44_45 as xx, rxy_44_45 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_45_46 as xy, xx_45_46 as xx, rxy_45_46 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_46_47 as xy, xx_46_47 as xx, rxy_46_47 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_47_48 as xy, xx_47_48 as xx, rxy_47_48 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_48_49 as xy, xx_48_49 as xx, rxy_48_49 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_49_50 as xy, xx_49_50 as xx, rxy_49_50 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_50_51 as xy, xx_50_51 as xx, rxy_50_51 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_51_52 as xy, xx_51_52 as xx, rxy_51_52 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_52_53 as xy, xx_52_53 as xx, rxy_52_53 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_53_54 as xy, xx_53_54 as xx, rxy_53_54 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_54_55 as xy, xx_54_55 as xx, rxy_54_55 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_55_56 as xy, xx_55_56 as xx, rxy_55_56 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_56_57 as xy, xx_56_57 as xx, rxy_56_57 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_57_58 as xy, xx_57_58 as xx, rxy_57_58 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_58_59 as xy, xx_58_59 as xx, rxy_58_59 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_59_60 as xy, xx_59_60 as xx, rxy_59_60 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_60_61 as xy, xx_60_61 as xx, rxy_60_61 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_61_62 as xy, xx_61_62 as xx, rxy_61_62 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_62_63 as xy, xx_62_63 as xx, rxy_62_63 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_63_64 as xy, xx_63_64 as xx, rxy_63_64 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_64_65 as xy, xx_64_65 as xx, rxy_64_65 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_65_66 as xy, xx_65_66 as xx, rxy_65_66 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_66_67 as xy, xx_66_67 as xx, rxy_66_67 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_67_68 as xy, xx_67_68 as xx, rxy_67_68 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_68_69 as xy, xx_68_69 as xx, rxy_68_69 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_69_70 as xy, xx_69_70 as xx, rxy_69_70 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_70_71 as xy, xx_70_71 as xx, rxy_70_71 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_71_72 as xy, xx_71_72 as xx, rxy_71_72 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_72_73 as xy, xx_72_73 as xx, rxy_72_73 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_73_74 as xy, xx_73_74 as xx, rxy_73_74 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_74_75 as xy, xx_74_75 as xx, rxy_74_75 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_75_76 as xy, xx_75_76 as xx, rxy_75_76 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_76_77 as xy, xx_76_77 as xx, rxy_76_77 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_77_78 as xy, xx_77_78 as xx, rxy_77_78 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_78_79 as xy, xx_78_79 as xx, rxy_78_79 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_79_80 as xy, xx_79_80 as xx, rxy_79_80 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_80_81 as xy, xx_80_81 as xx, rxy_80_81 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_81_82 as xy, xx_81_82 as xx, rxy_81_82 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_82_83 as xy, xx_82_83 as xx, rxy_82_83 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_83_84 as xy, xx_83_84 as xx, rxy_83_84 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_84_85 as xy, xx_84_85 as xx, rxy_84_85 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_85_86 as xy, xx_85_86 as xx, rxy_85_86 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_86_87 as xy, xx_86_87 as xx, rxy_86_87 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_87_88 as xy, xx_87_88 as xx, rxy_87_88 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_88_89 as xy, xx_88_89 as xx, rxy_88_89 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_89_90 as xy, xx_89_90 as xx, rxy_89_90 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_90_91 as xy, xx_90_91 as xx, rxy_90_91 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_91_92 as xy, xx_91_92 as xx, rxy_91_92 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_92_93 as xy, xx_92_93 as xx, rxy_92_93 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_93_94 as xy, xx_93_94 as xx, rxy_93_94 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_94_95 as xy, xx_94_95 as xx, rxy_94_95 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_95_96 as xy, xx_95_96 as xx, rxy_95_96 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_96_97 as xy, xx_96_97 as xx, rxy_96_97 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_97_98 as xy, xx_97_98 as xx, rxy_97_98 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_98_99 as xy, xx_98_99 as xx, rxy_98_99 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_99_100 as xy, xx_99_100 as xx, rxy_99_100 as age FROM rangos UNION 
SELECT '|| col_geoname ||' AS geoname,  '|| col_geom ||' AS boundary, xy_100_ as xy, xx_100_ as xx, rxy_100m as age FROM rangos
       
     ), agg AS (
      
SELECT geoname, boundary, array_agg(xy ORDER BY age) AS xy, array_agg(xx ORDER BY age) AS xx, array_agg(age ORDER BY age) AS age
FROM melt
GROUP BY geoname, boundary
       
     ), metadata AS (
       
SELECT
' ||quote_literal(who_uploaded) ||'::text AS backer,
' ||quote_literal(what_project) ||'::text AS project,
geoname::text,
boundary,
' ||quote_literal(when_reference) || '::date  AS refdate,
now() AS loadate,
' ||quote_literal(whose_provider) || '::text AS provider,
' ||quote_literal(whose_url) || '::text AS url,
' ||quote_literal(what_project_id) || '::text AS project_id,
' ||quote_literal(whose_provider_id) || '::text AS provider_id,
xy AS data_xy,
xx AS data_xx,
age AS data_age
FROM agg
     
     ), final AS (
      
SELECT 
  backer,
  project,
  ARRAY[(data_age,data_xy,data_xx)::ods.pyrint] AS pyrdata,
  geoname,
  boundary,
  ST_PointOnSurface(boundary) AS labelpoint,
  refdate,
  loadate,
  provider,
  url,
  ARRAY['||quote_literal('Population')||'::ods.pyrvars] AS pyrvariables, --TODO: Define as function parameter
  project_id,
  provider_id
  
  FROM metadata
      
     )
SELECT * FROM final; ';


END
$func$
LANGUAGE plpgsql;

