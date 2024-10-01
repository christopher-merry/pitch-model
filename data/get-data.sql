DROP TABLE analytics.pitch_features_2023;

CREATE TABLE analytics.pitch_features_2023 AS 
SELECT p.game_id, p.play_id, p.month_number, p.year, p.game_date, p.at_bat_number, p.pitch_number
     , p.pitcher_id, p.pitcher_team_id, p.pitch_hand
     , p.batter_id, p.batter_team_id, p.bat_side, CASE p.bat_side WHEN 'L' THEN -1 WHEN 'R' THEN 1 END AS bat_side_multiplier
     , p.count_balls_strikes, p.count_outs, p.runner_string, p.inning, p.pitcher_team_score, p.batter_team_score
     , ab.hit, p.swing, p.swing_miss, p.swing_contact, p.pitch_result, p.pitch_strike, p.pitch_ball, p.pitch_type
     , CASE WHEN p.pitch_result IN ('In Play No Out', 'In Play Out', 'In Play Runs', 'Pitchout IPNO', 'Pitchout IPO', 'Pitchout IPR') THEN 1 ELSE 0 END AS hit_in_play
     , MAX(m1.metric_value) AS spin_rate 
     , MAX(m2.metric_value) AS "extension"
     , MAX(m3.metric_value) AS pitch_speed
     , MAX(m4.metric_value) AS spin_angle 
     , MAX(m5.metric_value) AS vertical_break_induced
     , MAX(m6.metric_value) AS horizontal_break 
     , MAX(m7.metric_value) AS plate_speed
     , MAX(m3.metric_value) - MAX(m7.metric_value) AS pitch_minus_plate
     , MAX(m8.metric_value) AS inferred_backspin_rate
     , MAX(m9.metric_value) AS inferred_sidespin_rate
     , MAX(m10.metric_value) AS inferred_gyrospin_rate
     , MAX(m11.metric_value) AS relative_strike_zone_location
     , MAX(m12.metric_value) AS relative_strike_zone_location_x
     , MAX(m13.metric_value) AS relative_strike_zone_location_z
     , MAX(m12.metric_value) * CASE p.bat_side WHEN 'R' THEN 1 WHEN 'L' THEN -1 END AS normalized_strike_zone_location_x
     , MAX(m14.metric_value) AS plate_location_x
     , MAX(m15.metric_value) AS plate_location_z
     , MAX(m16.metric_value) AS backspin
     , MAX(m17.metric_value) AS sidespin
     , MAX(m18.metric_value) AS gyrospin
     , MAX(b.segment_data->'release_position'->>'x') AS pitch_release_position_x
     , MAX(b.segment_data->'release_position'->>'y') AS pitch_release_position_y
     , MAX(b.segment_data->'release_position'->>'z') AS pitch_release_position_z
FROM   analytics.pitch_complete p 
LEFT 
JOIN   analytics.at_bat_complete ab 
ON     p.game_id = ab.game_id 
AND    p.play_id = ab.play_id 
LEFT 
JOIN   tracking.game_play_metric m1 
ON     m1.game_id = p.game_id 
AND    m1.play_id = p.play_id 
AND    m1.metric_id = 1000
LEFT 
JOIN   tracking.game_play_metric m2 
ON     m2.game_id = p.game_id 
AND    m2.play_id = p.play_id 
AND    m2.metric_id = 1001 
LEFT 
JOIN   tracking.game_play_metric m3 
ON     m3.game_id = p.game_id 
AND    m3.play_id = p.play_id 
AND    m3.metric_id = 1002 
LEFT 
JOIN   tracking.game_play_metric m4
ON     m4.game_id = p.game_id 
AND    m4.play_id = p.play_id 
AND    m4.metric_id = 1065
LEFT 
JOIN   tracking.game_play_metric m5
ON     m5.game_id = p.game_id 
AND    m5.play_id = p.play_id 
AND    m5.metric_id = 1100
LEFT 
JOIN   tracking.game_play_metric m6
ON     m6.game_id = p.game_id 
AND    m6.play_id = p.play_id 
AND    m6.metric_id = 1102
LEFT 
JOIN   tracking.game_play_metric m7
ON     m7.game_id = p.game_id 
AND    m7.play_id = p.play_id 
AND    m7.metric_id = 1109
LEFT 
JOIN   tracking.game_play_metric m8
ON     m8.game_id = p.game_id 
AND    m8.play_id = p.play_id 
AND    m8.metric_id = 1121
LEFT 
JOIN   tracking.game_play_metric m9
ON     m9.game_id = p.game_id 
AND    m9.play_id = p.play_id 
AND    m9.metric_id = 1122
LEFT
JOIN   tracking.game_play_metric m10
ON     m10.game_id = p.game_id 
AND    m10.play_id = p.play_id 
AND    m10.metric_id = 1123
LEFT
JOIN   tracking.game_play_metric m11
ON     m11.game_id = p.game_id 
AND    m11.play_id = p.play_id 
AND    m11.metric_id = 1126
LEFT
JOIN   tracking.game_play_metric m12
ON     m12.game_id = p.game_id 
AND    m12.play_id = p.play_id 
AND    m12.metric_id = 1132
LEFT
JOIN   tracking.game_play_metric m13
ON     m13.game_id = p.game_id 
AND    m13.play_id = p.play_id 
AND    m13.metric_id = 1133
LEFT
JOIN   tracking.game_play_metric m14
ON     m14.game_id = p.game_id 
AND    m14.play_id = p.play_id 
AND    m14.metric_id = 1147
LEFT
JOIN   tracking.game_play_metric m15
ON     m15.game_id = p.game_id 
AND    m15.play_id = p.play_id 
AND    m15.metric_id = 1148
LEFT
JOIN   tracking.game_play_metric m16
ON     m16.game_id = p.game_id 
AND    m16.play_id = p.play_id 
AND    m16.metric_id = 1151
LEFT
JOIN   tracking.game_play_metric m17
ON     m17.game_id = p.game_id 
AND    m17.play_id = p.play_id 
AND    m17.metric_id = 1152
LEFT
JOIN   tracking.game_play_metric m18
ON     m18.game_id = p.game_id 
AND    m18.play_id = p.play_id 
AND    m18.metric_id = 1153
LEFT 
JOIN   tracking.game_ball_segment_hawkeye_v10 b 
ON     b.game_id = p.game_id 
AND    b.play_id = p.play_id 
AND    b.segment_type = 'pitch_refined'
WHERE  p.season_number = 2023 
AND    p.game_type_code = 'R' 
AND    p.pitcher_sport_id = 1 
--AND    p.pitcher_team_id = 144 
--AND    p.game_date = '2023-06-02'
--AND    p.month_number = 6
--AND    p.batter_id = 605113
--AND    p.game_id = 717559
GROUP BY p.game_id, p.play_id, p.month_number, p.year, p.game_date, p.at_bat_number, p.pitch_number
     , p.pitcher_id, p.pitcher_team_id, p.pitch_hand
     , p.batter_id, p.batter_team_id, p.bat_side
     , p.count_balls_strikes, p.count_outs, p.runner_string, p.inning, p.pitcher_team_score, p.batter_team_score
     , ab.hit, p.swing, p.swing_miss, p.swing_contact, p.pitch_result, p.pitch_strike, p.pitch_ball, p.pitch_type
     , CASE WHEN p.pitch_result IN ('In Play No Out', 'In Play Out', 'In Play Runs', 'Pitchout IPNO', 'Pitchout IPO', 'Pitchout IPR') THEN 1 ELSE 0 END
;

SELECT pf.*
     , CASE
           -- Strike zones 1 - 9
           WHEN pf.normalized_strike_zone_location_x >= -100 AND pf.normalized_strike_zone_location_x < -33.3333 
            AND pf.relative_strike_zone_location_z >= -100 AND pf.relative_strike_zone_location_z < -33.3333 
           THEN 1
            WHEN pf.normalized_strike_zone_location_x BETWEEN -33.3333 AND 33.3333 
            AND pf.relative_strike_zone_location_z >= -100 AND pf.relative_strike_zone_location_z < -33.3333 
           THEN 2
           WHEN pf.normalized_strike_zone_location_x <= 100 AND pf.normalized_strike_zone_location_x > 33.3333 
            AND pf.relative_strike_zone_location_z >= -100 AND pf.relative_strike_zone_location_z < -33.3333 
           THEN 3
           WHEN pf.normalized_strike_zone_location_x >= -100 AND pf.normalized_strike_zone_location_x < -33.3333 
            AND pf.relative_strike_zone_location_z BETWEEN -33.3333 AND 33.3333 
           THEN 4
           WHEN pf.normalized_strike_zone_location_x BETWEEN -33.3333 AND 33.3333 
            AND pf.relative_strike_zone_location_z BETWEEN -33.3333 AND 33.3333 
           THEN 5
           WHEN pf.normalized_strike_zone_location_x <= 100 AND pf.normalized_strike_zone_location_x > 33.3333 
            AND pf.relative_strike_zone_location_z BETWEEN -33.3333 AND 33.3333 
           THEN 6
           WHEN pf.normalized_strike_zone_location_x >= -100 AND pf.normalized_strike_zone_location_x < -33.3333 
            AND pf.relative_strike_zone_location_z <= 100 AND pf.relative_strike_zone_location_z > 33.3333 
           THEN 7
           WHEN pf.normalized_strike_zone_location_x BETWEEN -33.3333 AND 33.3333 
            AND pf.relative_strike_zone_location_z <= 100 AND pf.relative_strike_zone_location_z > 33.3333 
           THEN 8
           WHEN pf.normalized_strike_zone_location_x <= 100 AND pf.normalized_strike_zone_location_x > 33.3333 
            AND pf.relative_strike_zone_location_z <= 100 AND pf.relative_strike_zone_location_z > 33.3333 
           THEN 9
          -- Ball zones 10 - 25
           WHEN pf.normalized_strike_zone_location_x < -100 
            AND pf.relative_strike_zone_location_z < -100  
           THEN 10
           WHEN pf.normalized_strike_zone_location_x < -100 
            AND pf.relative_strike_zone_location_z >= -100 AND pf.relative_strike_zone_location_z < -33.333
           THEN 11
           WHEN pf.normalized_strike_zone_location_x < -100 
            AND pf.relative_strike_zone_location_z BETWEEN -33.333 AND 33.333
           THEN 12
           WHEN pf.normalized_strike_zone_location_x < -100 
            AND pf.relative_strike_zone_location_z <= 100 AND pf.relative_strike_zone_location_z > 33.333
           THEN 13
           WHEN pf.normalized_strike_zone_location_x < -100 
            AND pf.relative_strike_zone_location_z > 100  
           THEN 14
           WHEN pf.normalized_strike_zone_location_x >= -100 AND pf.normalized_strike_zone_location_x < -33.3333 
            AND pf.relative_strike_zone_location_z > 100  
           THEN 15
           WHEN pf.normalized_strike_zone_location_x BETWEEN -33.3333 AND 33.3333 
            AND pf.relative_strike_zone_location_z > 100  
           THEN 16
           WHEN pf.normalized_strike_zone_location_x <= 100 AND pf.normalized_strike_zone_location_x > 33.3333 
            AND pf.relative_strike_zone_location_z > 100  
           THEN 17
           WHEN pf.normalized_strike_zone_location_x > 100 
            AND pf.relative_strike_zone_location_z > 100  
           THEN 18
           WHEN pf.normalized_strike_zone_location_x > 100 
            AND pf.relative_strike_zone_location_z <= 100 AND pf.relative_strike_zone_location_z > 33.333
           THEN 19
           WHEN pf.normalized_strike_zone_location_x > 100 
            AND pf.relative_strike_zone_location_z BETWEEN -33.333 AND 33.333
           THEN 20
           WHEN pf.normalized_strike_zone_location_x > 100 
            AND pf.relative_strike_zone_location_z >= -100 AND pf.relative_strike_zone_location_z < -33.333
           THEN 21
           WHEN pf.normalized_strike_zone_location_x > 100 
            AND pf.relative_strike_zone_location_z < -100  
           THEN 22
           WHEN pf.normalized_strike_zone_location_x <= 100 AND pf.normalized_strike_zone_location_x > 33.3333 
            AND pf.relative_strike_zone_location_z < -100  
           THEN 23
           WHEN pf.normalized_strike_zone_location_x BETWEEN -33.3333 AND 33.3333 
            AND pf.relative_strike_zone_location_z < -100  
           THEN 24
           WHEN pf.normalized_strike_zone_location_x <= 100 AND pf.normalized_strike_zone_location_x > 33.3333 
            AND pf.relative_strike_zone_location_z < -100  
           THEN 25
        END AS pitch_location_zone 
      , pt.pitch_type_desc
FROM analytics.pitch_features_2023 pf
JOIN lookup.pitch_type pt 
ON pf.pitch_type = pt.pitch_type_code;
