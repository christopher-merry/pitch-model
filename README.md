# pitch-model

## Features

### game_id
Unique identifier for a game

### play_id
Uniquely idenifies a given play.  Plays generally begin with a pitch and continue until play stops. 
 Plays may include batted balls and runner movement.  In certain situations, a play may be associated with a non-pitch such as a pick off attempt or runner advancement
 
### month_number
Numeric value representing the month of the game date

### year
Numeric value representing the four digit year of the game date 

### game_date 
The original date a game was scheduled to be played.  The actual game date may differ if the game was delayed.

### at_bat_number 
A sequential number associated with each "at bat" during a game

### pitch_number
A sequential number associated with each pitch of an at bat

### pitcher_id
Unique identifier associated with a pitcher

### pitcher_team_id
Unique identifier associated with the team a pitcher plays for

### batter_id
Unique identifier associated with a batter

### batter_team_id
Unique identifier associated with the team a batter plays for

### count_balls_strikes
A character string that indicates the numeric value for balls and strikes, seperated by a hyphon.  For example, a count with 2 balls and 1 strike is '2-1'

### count_outs
Numeric value indicating the number of outs at the time of the pitch

### runner_string
A character string that indicates runner positions on the bases.  The first character is first base, the second character is second base, and the third character is third base.  If the base is occupied, a 1 is assigned.  If the base is not occupied, a 0 is assigned.  For example, a runner on second and third is '011'. 

### inning
Numeric value indicating the inning

### pitcher_team_score
Numeric value indicating the score of the defensive team

### batter_team_score
Numeric value indicating the score of the offensive team

### hit
If the ball is in play, a value of 0 or 1 indicates if the scorer ruled it was a hit.  This does not mean the ball was simply put into play.

### swing
A value of 0 or 1 indicating whether or not the batter swung at the pitch

### swing_miss
A value of 0 or 1 indicating whether or not the batter swung and missed.  Bunts are not included.

### swing_contact
A value of 0 or 1 indicating whether or not the batter made contact with the pitch.

### pitch_result
A categorical value indicating what happened on the pitch.  Typical values include: Ball, Called Strike, Swinging Strike, Hit Into Play No Outs, Hit Into Play Outs

### pitch_strike
A value of 0 or 1 indicating if the pitch was a strike (called, swinging, foul)

### pitch_ball
A value of 0 or 1 indicating if the pitch was called a ball

### spin_rate
Floating point value indicating the number of revolutions per minute the pitch spins during flight.

### extension 
Floating point value indicating the distance at which the pitcher releases the ball.  The pitching plate is located 60' 6" from the apex of home plate.  Extension is measured as a y value perpindicular to a straight line between home and the pitcher's plate.

### pitch_speed 
Floating point value indicating the pitch speed in miles per hour when the ball left the pitcher's hand

### spin_angle
Floating point value that identifies the angle of the axis at which the pitch is spinning during flight

### vertical_break_induced
Floating point value that indicates the distance (in inches) the pitch moved from a line it would have traveled with only gravity affecting it

### horizontal_break   
Floating point value that indicates the distance (in inches) the pitch moved on a horizontal plane

### plate_speed
Floating point value that indicates the speed the ball is traveling when it reaches home plate (in miles per hour)

### pitch_minus_plate
Floating point value that is the difference between 'pitch speed' and 'plate speed'

### inferred_backspin_rate
Floating point value that indicates the number of revolutions the ball spins on a horizontal axis

### inferred_sidespin_rate
Floating point value that indicates the number of revolutions the ball spins on a vertical axis

### inferred_gyrospin_rate
Floating point value that indicates the number of revolutions the ball spins on a 45 degree axis

### relative_strike_zone_location
Floating point value that indicates the distance (in inches) from the center of the strike zone as the ball crosses home plate

### relative_strike_zone_location_x
Floating point value that indicates the distance (in inches) on a horizontal plane from the center of home plate

### relative_strike_zone_location_z
Floating point value that indicates the distance (in inches) on a vertical plane from the center of the strike zone

### plate_location_x
Floating point value that indicates the distance (in inches) on a horizontal plane from the center of home plate

### plate_location_z
Floating point value that indicates the distance (in inches) on a vertical plane from the ground

### backspin
Seems to be the same as inferred_backspin_rate

### sidespin
Seems to be the same as inferred_sidespin_rate

### gyrospin
Seems to be the same as inferred_gyrospin_rate

### pitch_release_position_x 
Floating point value that indicates the distance (in feet) from a perpendicular line from the apex of home plate through the center of the pitcher's plate in which the ball is released

### pitch_release_position_y
Floating point value that indicates the distance from the ground (in feet) where the ball is released

### pitch_release_position_z
Floating point value that indicates the distance from the apex of home plate (in feet) where the ball was released
