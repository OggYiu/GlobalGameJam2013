package clipper.entities.fighting;

class State {
	// ;Amount of life to start with
	var life : Float = 1000;
	var attack : Float = 100;
	var defence : Float = 100;
	// Percentage to increase defense everytime player is knocked down
	var fallDefenceUp : Float = 50;

}

class Constant {
	// Time which player lies down for, before getting up
	var liedownTime : Float = 60;
	// Number of points for juggling
	var airJuggle : Float = 15;

	// Default hit spark number for HitDefs
	// sparkno = 2

	// Default guard spark number
	// guard.sparkno = 40

	// Height of player (for opponent to jump over)
	var height : Float = 60;

	// Walk forward velocity
	var walkFwdVel : Float = 2.4;

	// Walk back velocity
	var walkBackVel : Float = 2.2;

	// Neutral jumping velocity
	var jumpNeuVel : Float = 8.4; 

	// Back jumping velocity
	var jumpBackVel : Float = 2.55; 

	// Forward jumping velocity
	var jumpFwdVel : Float = 2.5;

	// [Movement]

	// Number of air jumps allowed (opt)
	var airjumpNum : Int = 1;

	// Minimum distance from ground before you can air jump (opt)
	var airjumpHeight : Int = 35;

	var lightHitSndFile : String = "";
	var heavyHitSndFile : String = "";
}

;---------------------------------------------------------------------------
; Variable usage:
; This is a record of the variables that KFM uses. Keeping a record of your
; variable usage helps you avoid careless mistakes later.
; var(1)  - Used in kfm.cmd for combo condition (updated every tick)
; var(2)  - Used in Kung Fu Throw (state 800) to remember if fwd was being
;           held (remembered from state 800 through state 810).


;---------------------------------------------------------------------------
; Lose by Time Over
; CNS difficulty: basic
[Statedef 170]
type = S
ctrl = 0
anim = 170
velset = 0,0

[State 170, 1]
type = NotHitBy
trigger1 = 1
value = SCA
time = 1

;---------------------------------------------------------------------------
; Win state decider
; CNS difficulty: basic
[Statedef 180]
type = S

[State 180, 1]
type = ChangeState
trigger1 = Time = 0
value = 181

;---------------------------------------------------------------------------
; Win pose 1 - Bow
; CNS difficulty: basic
[Statedef 181]
type = S
ctrl = 0
anim = 181
velset = 0,0

[State 181, 1]
type = NotHitBy
trigger1 = 1
value = SCA
time = 1

;---------------------------------------------------------------------------
; Introduction
; CNS difficulty: basic
[Statedef 191]
type = S
ctrl = 0
anim = 190
velset = 0,0

[State 191, 1] ;Freeze animation until PreIntro is over
type = ChangeAnim
trigger1 = RoundState = 0
value = 190

[State 191, 2] ;Assert this until you want "round 1, fight" to begin
type = AssertSpecial
trigger1 = 1
flag = Intro

[State 191, 3] ;Change to stand state when done
type = ChangeState
trigger1 = AnimTime = 0
value = 0

; You can delete the following two controllers if you're building your own
; character using KFM. These are the wood pieces that KFM kicks.
[State 191, Wood 1]
type = Explod
trigger1 = RoundState != 0
persistent = 0
anim = 191
postype = p1
pos = 260, -90
velocity = -4.2, -7
accel = 0, .32
removetime = 48

[State 191, Wood 2]
type = Explod
trigger1 = AnimElemTime(7) = 1
anim = 192
postype = p1
pos = 60, -70
velocity = 2, -4
accel = 0, .32
removetime = 35

; You can delete the following two controllers if you're building your own
; character using KFM. These play back the sounds of the wood block being
; broken.
[State 191, Snd 1]
type = PlaySnd
trigger1 = AnimElem = 7
value = F5,2
volume = -40

[State 191, Snd 2]
type = PlaySnd
trigger1 = AnimElemTime(7) = 3
value = F5,3
volume = -80

;---------------------------------------------------------------------------
; Taunt
; CNS difficulty: easy
[Statedef 195]
type = S
ctrl = 0
anim = 195
velset = 0,0
movetype = I
physics = S
sprpriority = 2

[State 195, 1]
type = CtrlSet
trigger1 = Time = 40
value = 1

[State 195, 2]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1


;---------------------------------------------------------------------------
; Stand Light Punch
; CNS difficulty: easy
[Statedef 200]
type    = S                      ;State-type: S-stand, C-crouch, A-air, L-liedown
movetype= A                      ;Move-type: A-attack, I-idle, H-gethit
physics = S                      ;Physics: S-stand, C-crouch, A-air
juggle  = 1                      ;Number of air juggle points move takes
;Commonly-used controllers:
velset = 0,0                     ;Set velocity (x,y) (Def: no change)
ctrl = 0                         ;Set ctrl (Def: no change)
anim = 200                       ;Change animation (Def: no change)
poweradd = 10                    ;Power to add (Def: 0)
sprpriority = 2                  ;Set p1's sprite layering priority to 2 (in front)

[State 200, 1]
type = HitDef
trigger1 = AnimElem = 3
attr = S, NA                     ;Attribute: Standing, Normal Attack
damage = 23, 0                   ;Damage that move inflicts, guard damage
animtype = Light                 ;Animation type: Light, Medium, Heavy, Back (def: Light)
guardflag = MA                   ;Flags on how move is to be guarded against
hitflag = MAF                    ;Flags of conditions that move can hit
priority = 3, Hit                ;Attack priority: 0 (least) to 7 (most), 4 default
;Hit/Miss/Dodge type (Def: Hit)
pausetime = 8, 8                 ;Time attacker pauses, time opponent shakes
sparkno = 0                      ;Spark anim no (Def: set above)
sparkxy = -10, -76               ;X-offset for the "hit spark" rel. to p2,
;Y-offset for the spark rel. to p1
hitsound = 5, 0                  ;Sound to play on hit
guardsound = 6, 0                ;Sound to play on guard
ground.type = High               ;Type: High, Low, Trip (def: Normal)
ground.slidetime = 5             ;Time that the opponent slides back
ground.hittime  = 11             ;Time opponent is in hit state
ground.velocity = -4             ;Velocity at which opponent is pushed
airguard.velocity = -1.9,-.8     ;Guard velocity in air (def: (air.xvel*1.5, air.yvel/2))
air.type = High                  ;Type: High, Low, Trip (def: same as ground.type)
air.velocity = -1.4,-3           ;X-velocity at which opponent is pushed,
;Y-velocity at which opponent is pushed
air.hittime = 15                 ;Time before opponent regains control in air

[State 200, 2]
type = PlaySnd
trigger1 = Time = 1
value = 0, 0

[State 200, 3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Standing strong punch
; CNS difficulty: easy
; Note the width controller. It makes KFM's push box larger, so he doesn't
; stand so close to the opponent. Hit Ctrl-C and look at the red bar at his
; feet.
; The sprpriority for this state is at -1, instead of the usual 2 for
; attacks. This makes KFM appear behind the opponent initially.
; The SprPriority controller in [State 210, 4] brings KFM to the front when
; his arm has swung over.
; To stop KFM from pausing in his swing frame, there is a ChangeAnim in
; [State 210, 3] that detects if the hit has come in contact with the
; opponent during that frame, and switches to the next animation element
; (notice the elem=6 parameter). If you don't see what I mean, try commenting
; out that controller, then hit someone with this attack.
[Statedef 210]
type    = S
movetype= A
physics = S
juggle  = 4
poweradd= 30
ctrl = 0
velset = 0,0
anim = 210
sprpriority = -1

[State 210, Width]
type = Width
trigger1 = (AnimElemTime (2) >= 0) && (AnimElemTime (7) < 0)
value = 15,0

[State 210, 1]
type = PlaySnd
trigger1 = Time = 2
value = 0, 4

[State 210, 2]
type = HitDef
trigger1 = AnimElem = 3
attr = S, NA
animtype  = Medium
damage    = 57
guardflag = MA
pausetime = 12,12
sparkno = 1
sparkxy = -10,-70
hitsound   = 5,2
guardsound = 6,0
ground.type = High
ground.slidetime = 12
ground.hittime  = 16
ground.velocity = -5.5
air.velocity = -2.5,-4
forcenofall = 1

[State 210, 3]
type = ChangeAnim
trigger1 = AnimElemTime(5) > 0 && AnimElemTime(6) <= 0
trigger1 = movecontact
ignorehitpause = 1
persistent = 0
value = 210
elem = 6

[State 210, 4]
type = SprPriority
trigger1 = AnimElem = 5
value = 2

[State 210, 5]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Standing light kick
; CNS difficulty: easy
[Statedef 230]
type    = S
movetype= A
physics = S
juggle  = 4
poweradd= 11
ctrl = 0
velset = 0,0
anim = 230
sprpriority = 2

[State 230, 1]
type = PlaySnd
trigger1 = Time = 2
value = 0, 1

[State 230, 2]
type = HitDef
trigger1 = Time = 0
attr = S, NA
animtype  = Medium
damage    = 26
guardflag = MA
pausetime = 12,12
sparkno = 0
sparkxy = -10,-37
hitsound   = 5,1
guardsound = 6,0
ground.type = Low
ground.slidetime = 10
ground.hittime  = 14
ground.velocity = -5
air.velocity = -2.5,-3.5

[State 230, 3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Standing strong kick
; CNS difficulty: easy
[Statedef 240]
type    = S
movetype= A
physics = S
juggle  = 5
poweradd= 30
ctrl = 0
velset = 0,0
anim = 240
sprpriority = 2

[State 240, 1]
type = PlaySnd
trigger1 = Time = 2
value = 0, 1

[State 240, 2]
type = HitDef
trigger1 = Time = 0
attr = S, NA
animtype  = Medium
damage    = 63
guardflag = MA
pausetime = 12,12
sparkno = 1
sparkxy = -10,-60
hitsound   = 5,2
guardsound = 6,0
ground.type = Low
ground.slidetime = 12
ground.hittime  = 17
ground.velocity = -6
air.velocity = -2.2,-3.2

[State 240, 3]
type = PosAdd
trigger1 = AnimElem = 7
x = 12

[State 240, 4]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;Crouching light punch
; CNS difficulty: easy
; Description: Simple crouching attack. The HitDef's guardflag parameter
;     is set to "L", meaning that the move can only be guarded low
;     (crouching), and not by standing or jumping opponents.
;     Like for all light attacks, it's a good idea to keep the slidetime
;     and hittime parameters at a smaller number, so the opponent isn't
;     stunned for too long. For all crouching attacks you have to
;     remember to set the attr parameter to indicate that it is crouching
;     attack. In this case, "C, NA" stands for "crouching, normal attack".
;     The HitDef's priority is set at 3, instead of the default of 4,
;     so this attack has a lower priority than most others, meaning
;     KFM will get hit instead of trading hits with his opponent if
;     their attack collision boxes (Clsn1) intersect each other's Clsn2
;     boxes at the same time.
[Statedef 400]
type    = C
movetype= A
physics = C
juggle  = 5
poweradd= 8
ctrl = 0
anim = 400
sprpriority = 2

[State 400, 1]
type = PlaySnd
trigger1 = Time = 1
value = 0, 0

[State 400, 2]
type = HitDef
trigger1 = Time = 0
attr = C, NA
damage    = 23
priority  = 3
animtype  = Light
hitflag = MAF
guardflag = L
pausetime = 10,11
sparkno = 0
sparkxy = -10,-42
hitsound   = 5,0
guardsound = 6,0
ground.type = Low
ground.slidetime = 4
ground.hittime  = 9
ground.velocity = -4
air.velocity = -1.5,-3

[State 400, 3]
type = CtrlSet
trigger1 = Time = 6
value = 1

[State 400, 4]
type = ChangeState
trigger1 = AnimTime = 0
value = 11

;---------------------------------------------------------------------------
;Crouching strong punch
; CNS difficulty: easy
; Description: This is a 2-hit move. It is done by having two HitDefs
;     triggered, one for each frame of animation that hits.
;     Notice how the first hit cannot be guarded by an opponent in the
;     air, because of the "M" in the guardflag, meaning it can only
;     be guarded "middle". The second hit has an "MA" guardflag, so
;     it can be guarded both on the ground and in the air.
[Statedef 410]
type    = C
movetype= A
physics = C
juggle  = 6
poweradd= 25
ctrl = 0
anim = 410
sprpriority = 2

[State 410, 1]
type = PlaySnd
trigger1 = Time = 1
value = 0, 0

;This is the first hit, triggered on the 3rd element of animation.
[State 410, 2]
type = HitDef
trigger1 = AnimElem = 3
attr = C, NA
damage    = 37
animtype  = Medium
hitflag = MAF
guardflag = M
pausetime = 12,12
sparkno = 1
sparkxy = -10,-55
hitsound   = 5,2
guardsound = 6,0
ground.type = Low
ground.slidetime = 12
ground.hittime  = 17
ground.velocity = -4
air.velocity = -3,-4

;This is the second hit, triggered on the 4th element of animation.
[State 410, 3]
type = HitDef
trigger1 = AnimElem = 4
attr = C, NA
damage    = 36
animtype  = Medium
hitflag = MAF
guardflag = MA
pausetime = 12,12
sparkxy = -10,-83
hitsound   = 5,2
guardsound = 6,0
ground.type = High
ground.slidetime = 12
ground.hittime  = 17
ground.velocity = -7
air.velocity = -3,-4

[State 410, 4]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

;---------------------------------------------------------------------------
;Crouching light kick
; CNS difficulty: easy
[Statedef 430]
type    = C
movetype= A
physics = C
juggle  = 5
poweradd= 11
ctrl = 0
anim = 430
sprpriority = 2

[State 430, 1]
type = PlaySnd
trigger1 = Time = 1
value = 0, 0

[State 430, 2]
type = HitDef
trigger1 = Time = 0
attr = C, NA
damage    = 28
animtype  = Light
hitflag = MAFD
guardflag = L
pausetime = 12,12
sparkno = 0
sparkxy = -10,-8
hitsound   = 5,1
guardsound = 6,0
ground.type = Low
ground.slidetime = 6
ground.hittime  = 10
ground.velocity = -5
air.velocity = -2,-3
down.velocity = -5,0
down.hittime = 22

[State 430, 3]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

;---------------------------------------------------------------------------
;Crouch Strong Kick
; CNS difficulty: easy
; Description: This move uses "Trip" for the "ground.type" parameter in
;     its HitDef. It's a special type that puts the opponent in a tripped
;     animation as he falls. Also, the hitflag parameter in the HitDef
;     is set to "MAFD". The "D" indicates that a downed opponent can be
;     hit by the attack.
[Statedef 440]
type    = C
movetype= A
physics = C
juggle  = 7
poweradd= 35
ctrl = 0
anim = 440
sprpriority = 2

[State 440, 2]
type = PlaySnd
trigger1 = Time = 2
value = 0, 2

[State 440, 3]
type = HitDef
trigger1 = Time = 0
attr = C, NA
damage    = 72
hitflag = MAFD
guardflag = L
pausetime = 12,12
sparkno = 1
sparkxy = -5,-10
hitsound   = 5,2
guardsound = 6,0
ground.type = Trip
ground.slidetime = 10
ground.hittime  = 17
ground.velocity = -1.5,-2
air.velocity = -1.2,-3
guard.velocity = -5
fall = 1

[State 440, 4]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

;---------------------------------------------------------------------------
;Jump Light Punch
; CNS difficulty: easy
[Statedef 600]
type    = A
movetype= A
physics = A
juggle  = 2
poweradd= 5
ctrl = 0
anim = 600
sprpriority = 2

[State 600, 1]
type = PlaySnd
trigger1 = Time = 1
value = 0, 0

[State 600, 2]
type = HitDef
trigger1 = Time = 0
attr = A, NA
damage    = 20
guardflag = HA
priority = 3
pausetime = 7,8
sparkno = 0
sparkxy = -10,-58
hitsound   = 5,0
guardsound = 6,0
ground.type = High
ground.slidetime = 5
ground.hittime  = 8
ground.velocity = -4
air.velocity = -1.3,-3
air.hittime = 14

[State 600, 3]
type = CtrlSet
trigger1 = Time = 17
value = 1

;---------------------------------------------------------------------------
;Jump Strong Punch
; CNS difficulty: easy
[Statedef 610]
type    = A
movetype= A
physics = A
juggle  = 4
poweradd= 30
ctrl = 0
anim = 610
sprpriority = 2

[State 610, 2]
type = PlaySnd
trigger1 = Time = 2
value = 0, 1

[State 610, 3]
type = HitDef
trigger1 = Time = 0
attr = A, NA
damage = 72
guardflag = HA
priority = 4
pausetime = 12,12
sparkno = 1
sparkxy = -10,-55
hitsound   = 5,3
guardsound = 6,0
animtype = Med
ground.type = High
ground.slidetime = 12
ground.hittime  = 14
ground.velocity = -6
air.velocity = -3,-4

;---------------------------------------------------------------------------
;Jump Light Kick
; CNS difficulty: easy
[Statedef 630]
type    = A
movetype= A
physics = A
juggle  = 3
poweradd= 10
ctrl = 0
anim = 630
sprpriority = 2

[State 630, 1]
type = PlaySnd
trigger1 = Time = 1
value = 0, 0

[State 630, 2]
type = HitDef
trigger1 = Time = 0
attr = A, NA
damage = 26
guardflag = HA
priority = 3
pausetime = 8,8
sparkno = 1
sparkxy = -5,-35
hitsound   = 5,0
guardsound = 6,0
ground.type = High
ground.slidetime = 6
ground.hittime  = 10
ground.velocity = -4
air.velocity = -2,-3
air.hittime = 14

;---------------------------------------------------------------------------
;Jump Strong Kick
; CNS difficulty: easy
[Statedef 640]
type    = A
movetype= A
physics = A
juggle  = 4
poweradd= 30
ctrl = 0
anim = 640
sprpriority = 2

[State 640, 2]
type = PlaySnd
trigger1 = Time = 2
value = 0, 1

[State 640, 3]
type = HitDef
trigger1 = Time = 0
attr = A, NA
damage    = 70
guardflag = HA
priority = 4
pausetime = 12,12
sparkno = 1
sparkxy = -10,-40
hitsound   = 5,3
guardsound = 6,0
animtype = Med
ground.type = High
ground.slidetime = 12
ground.hittime  = 15
ground.velocity = -7
air.velocity = -3,-4

;---------------------------------------------------------------------------
;Kung Fu Throw - Attempt
; CNS difficulty: medium-advanced
; Description: Throws are not difficult to make, although then can be
;     tedious at times. Throw attempt states have a HitDef of a
;     special format. The key parameters in a throw are p1stateno
;     and p2stateno. If the HitDef successfully connects, then
;     the attacker will change to the state number specified by
;     p1stateno, and the opponent will be change to the state
;     number assigned to p2stateno. The special thing about p2stateno
;     is that the opponent will be temporarily brought into the
;     attacker's state file. In this case, no matter who the
;     opponent is, he will be taken to state 820 of this file (kfm.cns)
;     and remain here until the end of the throw (look at his debug
;     information when he is being thrown; the text changes to yellow
;     to mean that he is in another player's state file).
[Statedef 800]
type    = S
movetype= A
physics = S
juggle  = 0
velset = 0,0
ctrl = 0
anim = 800
sprpriority = 2

; Notes: The '-' symbol in the hitflag field means that it only affects
;   players who are not in a hit state. This prevents KFM from combo-ing
;   into the throw. The priority should be set to a low number, such as
;   1 or 2, so that the throw does not take precedence over normal attacks.
;   The type of priority must always be set to "Miss" or "Dodge" for throws,
;   otherwise strange behavior can result.
[State 800, 1]
type = HitDef
Trigger1 = Time = 0
attr = S, NT          ;Attributes: Standing, Normal Throw
hitflag = M-          ;Affect only ground people who are not being hit
priority = 1, Miss    ;Throw has low priority, must be miss or dodge type.
sparkno = -1          ;No spark
p1sprpriority = 1     ;Draw p1's sprite in front of p2
                      ;p2's sprite priority is set to 0 by default
p1facing = 1
p2facing = 1          ;Force p2 to face KFM
p1stateno = 810       ;On success, KFM changes to state 810
p2stateno = 820       ;If hit, p2 changes to state 820 in KFM's cns
guard.dist = 0        ;This prevents p2 from going into a guard state if close
fall = 1              ;Force p2 into falling down

[State 800, 2]
type = ChangeState
Trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;Kung Fu Throw - Throwing the opponent
; Description: In this state, KFM throws the opponent by binding him to
;     various offsets based on his current frame of animation. For
;     example, [State 810, Bind 1] binds the opponent to an offset of
;     28 pixels in front of KFM. That puts him around where KFM's hand
;     is at. Is is important to keep the opponent bound using a
;     TargetBind controller at all times, until you let him go. This
;     is especially important if your player has a Clsn2 box that
;     allows him to get hit while throwing someone. Each time a player
;     gets hit, all his bound targets will be set to a fall state. If
;     the opponent is not bound, then he may get stuck in his thrown
;     state when his attacker is knocked out of the throw halfway.
; Notes: There is a TargetLifeAdd controller to decrease the opponent's
;     life, and a TargetState controller to change his state to a
;     falling state when KFM lets go of him.
[Statedef 810]
type    = S
movetype= A
physics = N
anim = 810
poweradd = 0

; Here a variable, var(2), is used to remember whether or not the
; player was holding forward at the start of the state. This variable
; is checked later on to turn KFM around if necessary.
[State 810, Holding fwd?]
type = VarSet
trigger1 = Time = 0
var(2) = command = "holdfwd"

[State 810, Grab Sound]
type = PlaySnd
trigger1 = AnimElem = 2
value = 1, 1

[State 810, Throw Sound]
type = PlaySnd
trigger1 = AnimElem = 7
value = 800, 0

[State 810, Bind 1]
type = TargetBind
trigger1 = AnimElemTime(2) < 0
pos = 28, 0

[State 810, Width 2-11]
type = Width
trigger1 = AnimElemTime(2) >= 0 && AnimElemTime(12) < 0
edge = 60,0

[State 810, Bind 2-4]
type = TargetBind
trigger1 = AnimElemTime(2) >= 0 && AnimElemTime(5) < 0
pos = 58, 0

[State 810, Bind 5]
type = TargetBind
trigger1 = AnimElemTime(5) >= 0 && AnimElemTime(6) < 0
pos = 47, 0

[State 810, holdfwd - Turn 6] ;If was holding fwd before, turn now
type = Turn
trigger1 = var(2)
trigger1 = AnimElem = 6

[State 810, holdfwd - Pos 6] ;If was holding fwd before, move a little
type = PosAdd
trigger1 = var(2)
trigger1 = AnimElem = 6
x = -37

[State 810, holdfwd - Turn Target 6] ;If was holding fwd before, turn target too
type = TargetFacing
trigger1 = var(2)
trigger1 = AnimElem = 6
value = -1

[State 810, Bind 6]
type = TargetBind
trigger1 = AnimElemTime(6) >= 0 && AnimElemTime(7) < 0
pos = 41, -60

[State 810, Bind 7]
type = TargetBind
trigger1 = AnimElemTime(7) >= 0 && AnimElemTime(8) < 0
pos = 25, -75

[State 810, Bind 8]
type = TargetBind
trigger1 = AnimElemTime(8) >= 0 && AnimElemTime(9) < 0
pos = 15, -90

[State 810, Bind 9]
type = TargetBind
trigger1 = AnimElemTime(9) >= 0 && AnimElemTime(10) < 0
pos = -5, -96

[State 810, Bind 10]
type = TargetBind
trigger1 = AnimElemTime(10) >= 0 && AnimElemTime(11) < 0
pos = -14, -90

[State 810, Bind 11]
type = TargetBind
trigger1 = AnimElem = 11
pos = -50, -50

[State 810, Hurt 11]
type = TargetLifeAdd
trigger1 = AnimElem = 11
value = -78

[State 810, Throw 11]
type = TargetState
trigger1 = AnimElem = 11
value = 821

[State 810, Turn 12]
type = Turn
trigger1 = AnimElem = 12

[State 810, Pos 15]
type = PosAdd
trigger1 = AnimElem = 15
x = -10

[State 810, State End]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
;Thrown by Kung Fu Throw
; (a custom gethit state)
; Description: This is the state that the opponent changes to after being
;     hit by KFM's throw HitDef. The important thing here is to use a
;     ChangeAnim2 controller. The difference between ChangeAnim2 and
;     ChangeAnim is that ChangeAnim2 changes the player's animation to
;     an action in the AIR file of the attacker (in this case, kfm.air),
;     whereas ChangeAnim always changes the player to an action in his
;     own AIR file. Look at Action 820 in kfm.air for some extra
;     comments.
[Statedef 820]
type    = A
movetype= H
physics = N
velset = 0,0

[State 820, 1]
type = ChangeAnim2
Trigger1 = Time = 0
value = 820

;In case attacker loses binding on player for any reason, this controller
;guarantees that the player will never get stuck in this thrown state.
[State 820, 2]
type = SelfState
trigger1 = !gethitvar(isbound)
value = 5050

;---------------------------------------------------------------------------
;Thrown by Kung Fu Throw - thrown into the air
; (a custom gethit state)
; Description: This state has the opponent flying through the air and
;     falling down onto the ground. The SelfState controller sets the
;     opponent back using to his own state file when he his the ground.
;     Controllers 821,2 and 821,3 allow the opponent to recover by
;     hitting his recovery command when he is falling.
[Statedef 821]
type    = A
movetype= H
physics = N
velset = 2.8,-7
poweradd = 40

[State 821, 1] ;Gravity
type = VelAdd
Trigger1 = 1
y = .4

[State 821, 2] ; Recover near ground (use ChangeState)
type = ChangeState
triggerall = Vel Y > 0
triggerall = Pos Y >= -20
triggerall = alive
triggerall = CanRecover
trigger1 = Command = "recovery"
value = 5200 ;HITFALL_RECOVER

[State 821, 3] ; Recover in mid air (use SelfState)
type = SelfState
triggerall = Vel Y > 0
triggerall = alive
triggerall = CanRecover
trigger1 = Command = "recovery"
value = 5210 ;HITFALL_AIRRECOVER

[State 821, 4] ;Hit ground
type = SelfState
trigger1 = Vel Y > 0
trigger1 = Pos Y >= 0
value = 5100 ;Hit ground


;---------------------------------------------------------------------------
; Kung Fu Palm
; CNS difficulty: medium
; Description: This is like a standard attack, but with some differences.
;   There are two HitDefs in this attack. One is triggered when the
;   opponent is near (using a p2bodydist trigger), and the other
;   when the opponent is farther away. The main differences between
;   the near and far versions of the HitDefs is that the near version
;   has a "fall" parameter set to 1, causing the opponent to be knocked
;   down. Other minor differences are the damage, and the velocity to
;   give the opponent.
;   The line "attr = S, SA" line means this is a Standing, Special Attack.
;   It is important you have the attr parameter set correctly for all
;   you HitDefs.
[Statedef 1000]
type    = S
movetype= A
physics = S
juggle  = 4
poweradd= 55
velset = 0,0
anim = 1000
ctrl = 0
sprpriority = 2

[State 1000, 1]
type = PlaySnd
trigger1 = Time = 8
value = 0, 3

[State 1000, 2]
type = PosAdd
trigger1 = AnimElem = 2
x = 20

[State 1000, 3]
type = PosAdd
trigger1 = AnimElem = 3
trigger2 = AnimElem = 13
x = 10

[State 1000, 4]
type = PosAdd
trigger1 = AnimElem = 5
x = 5

[State 1000, 5] ;Opponent near
type = HitDef
trigger1 = AnimElem = 5
trigger1 = p2bodydist X < 40
attr = S, SA
animtype  = Hard
damage    = 90, 4
priority  = 5
guardflag = MA
pausetime = 15,15
sparkxy = -10,-60
hitsound   = 5,4
guardsound = 6,0
ground.type = Low
ground.slidetime = 12
ground.hittime  = 17
ground.velocity = -4,-3.5
air.velocity = -4,-3
fall = 1

[State 1000, 6] ;Opponent not near
type = HitDef
trigger1 = AnimElem = 5
trigger1 = p2bodydist X >= 40
attr = S, SA
animtype  = Hard
damage    = 85, 4
priority  = 4
guardflag = MA
pausetime = 15,15
sparkxy = -10,-60
hitsound   = 5,4
guardsound = 6,0
ground.type = Low
ground.slidetime = 12
ground.hittime  = 17
ground.velocity = -7
air.velocity = -4,-2.5

[State 1000, 6]
type = PosAdd
trigger1 = AnimElem = 9
x = -5

[State 1000, 7]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Strong Kung Fu Palm
; CNS difficulty: medium
[Statedef 1010]
type    = S
movetype= A
physics = S
juggle  = 4
poweradd= 60
velset = 0,0
anim = 1010
ctrl = 0
sprpriority = 2

[State 1010, 1]
type = PlaySnd
trigger1 = Time = 9
value = 0, 3

[State 1010, 2]
type = PosAdd
trigger1 = AnimElem = 2
x = 20

[State 1010, 3]
type = PosAdd
trigger1 = AnimElem = 3
trigger2 = AnimElem = 13
x = 10

[State 1010, 4]
type = PosAdd
trigger1 = AnimElem = 5
x = 5

[State 1010, 5]
type = VelSet
trigger1 = AnimElem = 5
x = 4

[State 1010, 6] ;Opponent near
type = HitDef
trigger1 = AnimElem = 5
trigger1 = p2bodydist X < 40
attr = S, SA
animtype  = Hard
damage    = 90, 4
priority  = 5
guardflag = MA
pausetime = 15,15
sparkxy = -10,-60
hitsound   = 5,4
guardsound = 6,0
ground.type = Low
ground.slidetime = 12
ground.hittime  = 17
ground.velocity = -4,-3.5
air.velocity = -4,-3
fall = 1

[State 1010, 7] ;Opponent not near
type = HitDef
trigger1 = AnimElem = 5
trigger1 = p2bodydist X >= 40
attr = S, SA
animtype  = Hard
damage    = 85, 4
priority  = 4
guardflag = MA
pausetime = 15,15
sparkxy = -10,-60
hitsound   = 5,4
guardsound = 6,0
ground.type = Low
ground.slidetime = 12
ground.hittime  = 17
ground.velocity = -7
air.velocity = -4,-2.5

[State 1010, 8]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Fast Kung Fu Palm
; CNS difficulty: advanced
; Description: This is a complicated attack move. If you're a beginner,
;     you should skip looking at this for now and check it later when
;     you are more comfortable with the cns.
;     This move puts the other player in a custom get-hit state.
;     The line "p2stateno = 1025" in the HitDef does this. KFM has some
;     palette effects as well as after-image effects.
[Statedef 1020]
type    = S
movetype= A
physics = N
juggle  = 6
poweradd= -330
velset = 0,0
anim = 1020
ctrl = 0
sprpriority = 2

[State 1020, Friction]
type = VelMul
trigger1 = 1
x = .85 * ifelse (AnimElemTime(6) < 0, 1, .8)

[State 1020, Afterimage]
type = AfterImage
trigger1 = Time = 0
length = 13
PalBright   =  30, 30,  0
PalContrast =  70, 70, 20
PalAdd      = -10,-10,-10
PalMul      = .85,.85,.50
TimeGap  = 1
FrameGap = 2
Trans = Add
time = 2

[State 1020, Afterimage]
type = AfterImageTime
trigger1 = AnimElemTime(8) < 0
time = 2

[State 1020, Blink Yellow]
type = PalFX
trigger1 = Time = 0
time = 20
add = 32,16,0
sinadd = 64,32,5,3

[State 1020, 1]
type = PlaySnd
trigger1 = Time = 2
value = 0, 3

[State 1020, 2]
type = PosAdd
trigger1 = AnimElem = 2
x = 20

[State 1020, 3]
type = PosAdd
trigger1 = AnimElem = 3
trigger2 = AnimElem = 12
x = 10

[State 1020, 4]
type = PosAdd
trigger1 = AnimElem = 4
x = 5

[State 1020, 5]
type = VelSet
trigger1 = AnimElem = 4
x = 13

[State 1020, 6]
type = HitDef
trigger1 = AnimElem = 4
attr = S, SA
animtype  = Hard
damage    = 95, 5
getpower  = 0
priority  = 4
guardflag = MA
pausetime = 8,7
sparkxy = -10,-60
hitsound   = 5,4
guardsound = 6,0
ground.type = Low
ground.slidetime = 20
ground.hittime  = 22
ground.velocity = -8,-7
guard.velocity = -7
air.velocity = -8,-7
airguard.velocity = -5, -4
fall = 1
p2stateno = 1025    ;Make p2 go to state 1025 on hit
p2facing = 1        ;Force to face p1

[State 1020, 7]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;------------------
; Hit by Fast Kung Fu Palm - shaking from the hit
; (a custom gethit state)
; See State 1020 for details
[Statedef 1025]
type    = A
movetype= H
physics = N
velset = 0,0

[State 1025, Anim] ;Custom animation
type = ChangeAnim2
trigger1 = 1
value = 1025

[State 1025, State]
type = ChangeState
trigger1 = HitShakeOver = 1
value = 1026

;------------------
; Hit by Fast Kung Fu Palm - flying through the air
; (a custom gethit state)
[Statedef 1026]
type    = A
movetype= H
physics = N

[State 1026, Velocity]
type = HitVelSet
trigger1 = Time = 0
x = 1
y = 1

[State 1026, Gravity]
type = VelAdd
trigger1 = 1
y = .45

[State 1026, No scroll]
type = ScreenBound
triggerall = Pos y < -15
trigger1 = BackEdgeBodyDist < 65
trigger2 = FrontEdgeBodyDist < 65
value = 1
movecamera = 0,1

[State 1026, Hit wall]
type = ChangeState
triggerall = Pos y < -15
trigger1 = BackEdgeBodyDist <= 20
trigger2 = FrontEdgeBodyDist <= 20
value = 1027

[State 1026, Hit ground]
type = SelfState
trigger1 = (Vel y > 0) && (Pos y >= 0)
value = 5100

;------------------
; Hit by Fast Kung Fu Palm - hit wall
; (a custom gethit state)
[Statedef 1027]
type    = A
movetype= H
physics = N

[State 1027, Turn]
type = Turn
trigger1 = (Time = 0) && (FrontEdgeBodyDist <= 30)

[State 1027, Pos]
type = PosAdd
trigger1 = Time = 0
x = 15 - BackEdgeBodyDist

[State 1027, Stop moving]
type = PosFreeze
trigger1 = 1
x = 1
y = 1

[State 1027, No scroll]
type = ScreenBound
trigger1 = 1
value = 1
movecamera = 0,1

[State 1027, Spark]
type = Explod
trigger1 = Time = 0
anim = F72
pos = 0, floor (screenpos y) - 50
postype = back
sprpriority = 3

[State 1027, Anim]
type = ChangeAnim2
trigger1 = Time = 0
value = 1027

[State 1027, Sound]
type = PlaySnd
trigger1 = Time = 0
value = F7,0

[State 1027, State]
type = ChangeState
trigger1 = AnimTime = 0
value = 1028

;------------------
; Hit by Fast Kung Fu Palm - bounce off wall
; (a custom gethit state)
[Statedef 1028]
type    = A
movetype= H
physics = N

[State 1028, 1]
type = NotHitBy
trigger1 = 1
value = , NA, NP

[State 1028, Vel Y]
type = VelSet
trigger1 = Time = 0
y = -6

[State 1028, Vel X]
type = VelSet
trigger1 = Time = 0
x = 1.6

[State 1028, Turn]
type = Turn
trigger1 = (Time = 0) && (BackEdgeDist < 30)

[State 1028, Gravity]
type = VelAdd
trigger1 = 1
y = .35

[State 1028, Anim 5050] ;Self falling animation
type = ChangeAnim
trigger1 = Time = 0
trigger1 = !SelfAnimExist(5052)
value = 5050

[State 1028, Anim 5052] ;Self falling animation (diagup type)
type = ChangeAnim
trigger1 = Time = 0
trigger1 = SelfAnimExist(5052)
value = 5052

[State 1028, Anim 5060] ;Coming down - normal
type = ChangeAnim
trigger1 = Vel Y > -2
trigger1 = Anim = 5050
trigger1 = SelfAnimExist(5060)
persistent = 0
value = 5060

[State 1028, Anim 5062] ;Coming down - diagup type
type = ChangeAnim
trigger1 = Vel Y > -2
trigger1 = Anim = 5052
trigger1 = SelfAnimExist(5062)
persistent = 0
value = 5062

[State 1028, Hit ground]
type = SelfState
trigger1 = (Vel y > 0) && (Pos y >= 0)
value = 5100

;---------------------------------------------------------------------------
; Kung Fu Knee
; CNS difficulty: medium
; Description: Like the Kung Fu Palm, this is a special attack. This attack
;     begins on the ground, launches KFM into the air, then ends when KFM
;     lands on the ground. To achieve this, we use three states. The first
;     has KFM starting on the ground (note that type = S in the Statedef).
;     The ChangeState controller brings KFM into the second state (state
;     1051) when his ground animation ends. The second state controls KFM's
;     movement into the air and back towards the ground. The last state
;     (state 1052) stops KFM from moving when he touches the ground, and
;     brings him back to his stand state (state 0) when the animation is
;     over. More details are given in comments before each of the following
;     states.
[Statedef 1050]
type    = S
movetype= A
physics = S
juggle  = 4
poweradd= 55
velset = 0,0
anim = 1050
ctrl = 0
sprpriority = 2

[State 1050, 1]
type = PlaySnd
trigger1 = Time = 1
value = 0, 2

[State 1050, 2]
type = null;PosAdd
trigger1 = AnimElem = 2
x = 15

[State 1050, 3]
type = PosAdd
trigger1 = AnimElem = 4
x = 20

[State 1050, 4]
type = HitDef
trigger1 = Time = 0
attr = A, SA
animtype  = Medium
damage    = 80, 4
priority  = 5
guardflag = MA
pausetime = 12,12
sparkxy = -10,-70
hitsound   = 5,3
guardsound = 6,0
ground.type = Low
ground.slidetime = 20
ground.hittime  = 22
ground.velocity = -3.5,-7
guard.velocity = -7
air.velocity = -3.5,-7
fall = 1

[State 1050, 5]
type = ChangeState
trigger1 = AnimTime = 0
value = 1051

;------------------
; Light Kung Fu Knee - jump
; Description: This state uses a velset parameter in the Statedef to make
;     KFM move upwards. A value of 2,-6 means 2 pixels/tick forwards, and
;     6 pixels/tick upwards. Since this is an aerial state, the type is set
;     to A in the Statedef.
;     Notice that physics = N (N for None) here. This means we are not using
;     the built-in aerial physics model (physics = A), so we have complete
;     control over what KFM does in this state. Since we do not have
;     physics = A to take care of gravity for us, we need to put in our own
;     controller for that. Controller 1051,1 does the work of pulling KFM
;     down towards the ground. Controller 1051,2 checks if KFM has reached
;     the ground, and changes to state 1052 if so.
;     In this state's Statedef, we will use the hitdefpersist parameter to
;     retain the HitDef information from the last state. If we did not have
;     hitdefpersist, the HitDef will be turned off between state changes.
[Statedef 1051]
type    = A
movetype= A
physics = N
velset = 2,-6
anim = 1051
hitdefpersist = 1 ;Keep the HitDef from previous state active

[State 1051, 1] ;Gravity
type = VelAdd
trigger1 = 1
y = .45

[State 1051, 2]
type = ChangeState
trigger1 = Command = "a" || Command = "b"
trigger1 = Vel y < -1
value = 1055

[State 1051, 3] ;Change state when KFM is close to ground
type = ChangeState
trigger1 = Vel Y > 0 && Pos Y >= -10
value = 1052

;------------------
; Light Kung Fu Knee - land
; Description: This is KFM's landing state. There is a velset in the
;     Statedef to stop KFM from moving. Since KFM's y-position can be any
;     number greater than -10 upon entering this state (see the ChangeState
;     controller in State 1051), we need to reset it to 0, the ground
;     level. That is what controller 1052,1 is for.
[Statedef 1052]
type    = S
movetype= I
physics = S
anim = 1052
sprpriority = 1
velset = 0,0

[State 1052, 1] ;Reset y-position to ground level
type = PosSet
trigger1 = Time = 0
y = 0

[State 1052, 2] ;Play a sound for landing
type = PlaySnd
trigger1 = Time = 0
value = 40, 0

[State 1052, 3] ;Give KFM back control early
type = CtrlSet
trigger1 = AnimElem = 3, -1
value = 1

[State 1052, 4] ;Move KFM back a little
type = PosAdd
trigger1 = AnimElem = 4
x = -15

[State 1052, 5]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;------------------
; Kung Fu Knee - kick
[Statedef 1055]
type    = A
movetype= A
physics = N
anim = 1055

[State 1055, 1]
type = PlaySnd
trigger1 = Time = 0
value = 100,0
channel = 0

[State 1055, 2]
type = PlaySnd
trigger1 = Time = 0
value = 0, 1

[State 1055, 3]
type = PosAdd
trigger1 = Time = 0
x = 10
y = -10

[State 1055, 4] ;Gravity
type = VelAdd
trigger1 = 1
y = .45

[State 1055, 5]
type = HitDef
trigger1 = Time = 0
attr = A, SA
animtype  = Med
damage    = 35 + (prevstateno = 1061)*5, 2
priority  = 4
guardflag = MA
pausetime = 12,12
sparkxy = 0,-90
hitsound   = 5,2
guardsound = 6,0
ground.type = High
ground.slidetime = 15
ground.hittime  = 18
ground.velocity = -6
guard.velocity = -8
guard.ctrltime = 12
air.velocity = -4,-5
airguard.velocity = -4,-4.5
air.fall = 1

[State 1055, 6] ;Change state when KFM is close to ground
type = ChangeState
trigger1 = Vel Y > 0 && Pos Y >= -5
value = 1056

;------------------
; Kung Fu Knee - land from kick
[Statedef 1056]
type    = S
movetype= I
physics = S
anim = 1056
sprpriority = 1
velset = 0,0

[State 1056, 1] ;Reset y-position to ground level
type = PosSet
trigger1 = Time = 0
y = 0

[State 1056, 2] ;Play a sound for landing
type = PlaySnd
trigger1 = Time = 0
value = 40, 0

[State 1056, 3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Strong Kung Fu Knee
[Statedef 1060]
type    = S
movetype= A
physics = S
juggle  = 4
poweradd= 60
velset = 0,0
anim = 1060
ctrl = 0
sprpriority = 2

[State 1060, 1]
type = PlaySnd
trigger1 = Time = 1
value = 0, 2

[State 1060, 2]
type = PosAdd
trigger1 = AnimElem = 2
x = 6

[State 1060, 3]
type = PosAdd
trigger1 = AnimElem = 4
x = 21

[State 1060, 4]
type = HitDef
trigger1 = Time = 0
attr = A, SA
animtype  = Medium
damage    = 90, 4
priority  = 5
guardflag = MA
pausetime = 12,12
sparkxy = -10,-70
hitsound   = 5,3
guardsound = 6,0
ground.type = Low
ground.slidetime = 20
ground.hittime  = 22
ground.velocity = -3.5,-7.5
guard.velocity = -7
air.velocity = -3.5,-7.5
fall = 1

[State 1060, 5]
type = ChangeState
trigger1 = AnimTime = 0
value = 1061

;------------------
; Strong Kung Fu Knee - jump
[Statedef 1061]
type    = A
movetype= A
physics = N
velset = 2.5,-7.5
anim = 1061
hitdefpersist = 1 ;Keep the HitDef from previous state active

[State 1061, 1]
type = VelAdd
trigger1 = 1
y = .45

[State 1061, 2]
type = ChangeState
trigger1 = Command = "a" || Command = "b"
trigger1 = Vel y < -1
value = 1055

[State 1061, 3]
type = ChangeState
trigger1 = Vel Y > 0 && Pos Y >= -10
value = 1052

;---------------------------------------------------------------------------
; Fast Kung Fu Knee
; Description: This version of the Kung Fu Knee hits up to 3 times (including
;     the kick).
[Statedef 1070]
type    = S
movetype= A
physics = S
juggle  = 6
poweradd= -330
velset = 0,0
anim = 1070
ctrl = 0
sprpriority = 2

[State 1070, Afterimage]
type = AfterImage
trigger1 = Time = 0
length = 13
PalBright   =  30, 30,  0
PalContrast =  70, 70, 20
PalAdd      = -10,-10,-10
PalMul      = .85,.85,.50
TimeGap  = 1
FrameGap = 2
Trans = Add
time = 2

[State 1070, Afterimage]
type = AfterImageTime
trigger1 = 1
time = 2

[State 1070, Blink Yellow]
type = PalFX
trigger1 = Time = 0
time = 20
add = 32,16,0
sinadd = 64,32,5,3

[State 1070, 1]
type = PlaySnd
trigger1 = Time = 1
value = 0, 2

[State 1070, 2]
type = PosAdd
trigger1 = AnimElem = 2
x = 6

[State 1070, 3]
type = PosAdd
trigger1 = AnimElem = 4
x = 21

[State 1070, 4]
type = HitDef
trigger1 = Time = 0
attr = S, SA
animtype  = Medium
getpower  = 0
damage    = 35, 3
priority  = 5
hitflag   = MA
guardflag = MA
pausetime = 8,7
sparkxy = -10,-70
hitsound   = 5,2
guardsound = 6,0
ground.type = Low
ground.slidetime = 18
ground.hittime  = 20
ground.velocity = -2,-6
guard.velocity = -7
air.velocity = -2,-6
fall = 1
fall.animtype = Med
fall.recovertime = 30

[State 1070, 5]
type = ChangeState
trigger1 = AnimTime = 0
value = 1071

;------------------
; Fast Kung Fu Knee - jump
[Statedef 1071]
type    = A
movetype= A
physics = N
velset = 2.5,-9
anim = 1071

[State 1071, Blink Yellow]
type = PalFX
trigger1 = Time = 0
time = 18
add = 32,16,0
sinadd = 64,32,5,3

[State 1071, Afterimage]
type = AfterImageTime
trigger1 = Vel Y < 0
time = 2

[State 1071, 1]
type = VelAdd
trigger1 = 1
y = .5

[State 1071, 2]
type = VelAdd
trigger1 = Vel Y >= -1
y = .2

[State 1071, 3]
type = HitDef
trigger1 = Time = 0
attr = A, SA
animtype  = Medium
getpower  = 0
damage    = 68, 4
priority  = 5
guardflag = MA
pausetime = 12,12
sparkxy = -10,-70
hitsound   = 5,3
guardsound = 6,0
ground.type = Low
ground.slidetime = 18
ground.hittime  = 20
ground.velocity = -3,-9.5
guard.velocity = -7
air.velocity = -3,-9.5
fall = 1
fall.recovertime = 30

[State 1071, 4]
type = ChangeState
trigger1 = Command = "a" || Command = "b"
trigger1 = Vel y < -1
trigger1 = Time > 0
value = 1075

[State 1071, 5]
type = ChangeState
trigger1 = Vel Y > 0 && Pos Y >= -10
value = 1052

;------------------
; Fast Kung Fu Knee - kick
[Statedef 1075]
type    = A
movetype= A
physics = N
anim = 1055

[State 1075, Afterimage]
type = AfterImageTime
trigger1 = 1
time = 2

[State 1075, Blink Yellow]
type = PalFX
trigger1 = Time = 0
time = 20
add = 32,16,0
sinadd = 64,32,5,3

[State 1075, 1]
type = PlaySnd
trigger1 = Time = 0
value = 100,0
channel = 0

[State 1075, 2]
type = PlaySnd
trigger1 = Time = 0
value = 0, 1

[State 1075, 3]
type = PosAdd
trigger1 = Time = 0
x = 10
y = -10

[State 1075, 4] ;Gravity
type = VelAdd
trigger1 = 1
y = .45

[State 1075, 5]
type = VelAdd
trigger1 = Vel Y >= -1
y = .2

[State 1075, 6]
type = HitDef
trigger1 = Time = 0
attr = A, SA
animtype  = Med
damage    = 42, 2
getpower  = 0
priority  = 4
guardflag = MA
pausetime = 12,12
sparkxy = 0,-90
hitsound   = 5,2
guardsound = 6,0
ground.type = High
ground.slidetime = 15
ground.hittime  = 20
ground.velocity = -6
guard.velocity = -6
air.velocity = -4,-6
airguard.velocity = -4,-4.5
air.fall = 1

[State 1075, 7] ;Change state when KFM is close to ground
type = ChangeState
trigger1 = Vel Y > 0 && Pos Y >= -5
value = 1056


;---------------------------------------------------------------------------
; Light Kung Fu Upper
; CNS difficulty: easy
; Description: This is a simple special attack that can hit twice. Notice
;     the use of the Width controller to keep opponents from getting too
;     close to KFM during his uppercut (press Ctrl-C, and look at the
;     yellow bar at KFM's feet during the move).
;     The second HitDef has some interesting parameters. fall.recovertime
;     is used to prevent the opponent (p2) from recovering immediately
;     after being hit (eg. press x+y with KFM to recover). This gives the
;     attacking KFM a chance to follow up with an extra attack, such as
;     a Kung Fu Knee. The yaccel parameter, set at 0.4, makes p2 fall at a
;     greater value of acceleration than the default, which is 0.35.
[Statedef 1100]
type    = S
movetype= A
physics = S
juggle  = 4
poweradd= 55
velset = 0,0
anim = 1100
ctrl = 0
sprpriority = 2

[State 1100, Width]
type = Width
trigger1 = AnimElemTime(4) >= 0 && AnimElemTime(13) < 0
value = 5,0

[State 1100, 1]
type = PlaySnd
trigger1 = AnimElem = 4
value = 0, 2

[State 1100, 2]
type = HitDef
trigger1 = Time = 0
attr = S, SA
animtype  = Med
damage    = 52, 4
priority  = 5
guardflag = MA
pausetime = 4,8
sparkxy = 0,-48
hitsound   = 5,2
guardsound = 6,0
ground.type = Low
ground.slidetime = 15
ground.hittime  = 20
ground.velocity = -3
guard.velocity = -6
air.velocity = -2,-2
airguard.velocity = -4,-4.5
p2facing = 1
forcestand = 1         ;Force p2 into a standing state if hit

[State 1100, 3]
type = HitDef
trigger1 = AnimElem = 7
attr = S, SA
animtype  = Up
damage    = 55, 4
priority  = 5
guardflag = MA
pausetime = 12,12
sparkxy = 0,-110
hitsound   = 5,2
guardsound = 6,0
ground.type = Low
ground.slidetime = 15
ground.hittime  = 20
ground.velocity = -1,-9.5
guard.velocity = -6
air.velocity = -1,-7.5
airguard.velocity = -4,-4.5
p2facing = 1
fall = 1                   ;Make p2 fall down
fall.recovertime = 40      ;40 ticks before p2 can recover from fall
yaccel = .4                ;p2 will accelerate down at .4 pixels/sec^2 when falling

[State 1100, 5]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Strong Kung Fu Upper
[Statedef 1110]
type    = S
movetype= A
physics = S
juggle  = 4
poweradd= 60
velset = 0,0
anim = 1110
ctrl = 0
sprpriority = 2

[State 1110, Width]
type = Width
trigger1 = AnimElemTime(4) >= 0 && AnimElemTime(14) < 0
value = 5,0

[State 1110, 1]
type = PlaySnd
trigger1 = AnimElem = 4
value = 0, 2

[State 1110, 2]
type = HitDef
trigger1 = Time = 0
attr = S, SA
animtype  = Med
damage    = 57, 4
priority  = 5
guardflag = MA
pausetime = 4,8
sparkxy = 0,-48
hitsound   = 5,2
guardsound = 6,0
ground.type = Low
ground.slidetime = 15
ground.hittime  = 20
ground.velocity = -3
guard.velocity = -6
air.velocity = -2,-2
airguard.velocity = -4,-4.5
p2facing = 1
forcestand = 1

[State 1110, 3]
type = HitDef
trigger1 = AnimElem = 7
attr = S, SA
animtype  = Up
damage    = 60, 4
priority  = 5
guardflag = MA
pausetime = 12,12
sparkxy = 0,-110
hitsound   = 5,2
guardsound = 6,0
ground.type = Low
ground.slidetime = 15
ground.hittime  = 20
ground.velocity = -1,-10.5
guard.velocity = -6
air.velocity = -1,-8.5
airguard.velocity = -4,-4.5
p2facing = 1
fall = 1
fall.recovertime = 50
yaccel = .4

[State 1110, 5]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Fast Kung Fu Upper
[Statedef 1120]
type    = S
movetype= A
physics = S
juggle  = 6
poweradd= -330
velset = 0,0
anim = 1120
ctrl = 0
sprpriority = 2

[State 1120, Width]
type = Width
trigger1 = AnimElemTime(4) >= 0 && AnimElemTime(14) < 0
value = 5,0

[State 1120, Afterimage]
type = AfterImage
trigger1 = Time = 0
length = 13
PalBright   =  30, 30,  0
PalContrast =  70, 70, 20
PalAdd      = -10,-10,-10
PalMul      = .85,.85,.50
TimeGap  = 1
FrameGap = 2
Trans = Add
time = 2

[State 1120, Afterimage]
type = AfterImageTime
trigger1 = AnimTime < -2
time = 2

[State 1120, Blink Yellow]
type = PalFX
trigger1 = Time = 0
time = 20
add = 32,16,0
sinadd = 64,32,5,3

[State 1120, 1]
type = PlaySnd
trigger1 = AnimElem = 4
value = 0, 2

[State 1120, 2]
type = HitDef
trigger1 = Time = 0
trigger2 = AnimElem = 4
attr = S, SA
animtype  = Med
damage    = 30, 4
getpower  = 0
priority  = 5
guardflag = MA
pausetime = 6,10
sparkxy = 0, ifelse(Time = 0, -48, -55)
hitsound   = 5,2
guardsound = 6,0
ground.type = Low
ground.slidetime = 18
ground.hittime  = 23
ground.velocity = -3
guard.velocity = -6
air.velocity = -2,-2
airguard.velocity = -4,-4.5
p2facing = 1
forcestand = 1

[State 1120, 3]
type = HitDef
trigger1 = AnimElem = 7
attr = S, SA
animtype  = Up
damage    = 68, 4
getpower  = 0
priority  = 5
guardflag = MA
pausetime = 12,12
sparkxy = 0,-110
hitsound   = 5,2
guardsound = 6,0
ground.type = Low
ground.slidetime = 18
ground.hittime  = 23
ground.velocity = -1.2,-11
guard.velocity = -6
air.velocity = -1.2,-9
airguard.velocity = -4,-4.5
p2facing = 1
fall = 1
fall.recovertime = 60
yaccel = .4

[State 1120, 5]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Light Kung Fu Blow
; CNS difficulty: easy
; Notes: This uses the EnvShake controller to shake the screen. It makes the
;        move look stronger.
[Statedef 1200]
type    = S
movetype= A
physics = S
juggle  = 4
poweradd= 50
velset = 0,0
anim = 1200
ctrl = 0
sprpriority = 2

[State 1200, 1]
type = PlaySnd
trigger1 = AnimElem = 4
value = 0, 3

[State 1200, Width 1]
type = Width
trigger1 = AnimElemTime(5) >= 0 && AnimElemTime(6) < 0
value = 10,0

[State 1200, Width 2]
type = Width
trigger1 = AnimElemTime(6) >= 0 && AnimElemTime(9) < 0
value = 20,0

[State 1200, Shake Screen]
type = EnvShake
trigger1 = AnimElem = 6
time = 4     ;Time to shake screen
ampl = 2     ;Amount to shake
freq = 180   ;A frequency of 180 shakes the screen rapidly

[State 1200, 2]
type = HitDef
trigger1 = Time = 0
attr = S, SA
animtype  = Hard
damage    = 100, 6
priority  = 5
guardflag = MA
pausetime = 12,12
sparkxy = 0,-65
hitsound   = 5,3
guardsound = 6,0
ground.type = Low
ground.slidetime = 16
ground.hittime  = 20
ground.velocity = -10
ground.cornerpush.veloff = -12 ;To push far away when p2 is in corner
guard.velocity = -7
air.velocity = -3.5,-4.5
airguard.velocity = -3.5,-4.5

[State 1200, 3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Strong Kung Fu Blow
; CNS difficulty: easy
[Statedef 1210]
type    = S
movetype= A
physics = S
juggle  = 4
poweradd= 60
velset = 0,0
anim = 1210
ctrl = 0
sprpriority = 2

[State 1210, 1]
type = PlaySnd
trigger1 = AnimElem = 4
value = 0, 3

[State 1210, Width 1]
type = Width
trigger1 = AnimElemTime(5) >= 0 && AnimElemTime(6) < 0
value = 10,0

[State 1210, Width 2]
type = Width
trigger1 = AnimElemTime(6) >= 0 && AnimElemTime(9) < 0
value = 20,0

[State 1210, Shake Screen]
type = EnvShake
trigger1 = AnimElem = 6
time = 8
ampl = 2
freq = 170   ;A frequency of less than 180 causes a dampening effect

[State 1210, 2]
type = HitDef
trigger1 = Time = 0
attr = S, SA
animtype  = Hard
damage    = 125, 9
priority  = 5
guardflag = MA
pausetime = 12,12
sparkxy = 0,-65
hitsound   = 5,3
guardsound = 6,0
ground.type = Low
ground.slidetime = 18
ground.hittime  = 22
ground.velocity = -10
ground.cornerpush.veloff = -15 ;To push far away when p2 is in corner
guard.velocity = -8
air.velocity = -4,-4.5
airguard.velocity = -4,-4.5

[State 1210, 3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Fast Kung Fu Blow
; CNS difficulty: easy
[Statedef 1220]
type    = S
movetype= A
physics = S
juggle  = 6
poweradd= -330
velset = 0,0
anim = 1220
ctrl = 0
sprpriority = 2

[State 1220, Afterimage]
type = AfterImage
trigger1 = Time = 0
length = 13
PalBright   =  30, 30,  0
PalContrast =  70, 70, 20
PalAdd      = -10,-10,-10
PalMul      = .85,.85,.50
TimeGap  = 1
FrameGap = 2
Trans = Add
time = 2

[State 1220, Afterimage]
type = AfterImageTime
trigger1 = AnimTime < -2
time = 2

[State 1220, Blink Yellow]
type = PalFX
trigger1 = Time = 0
time = 20
add = 32,16,0
sinadd = 64,32,5,3

[State 1220, 1]
type = PlaySnd
trigger1 = AnimElem = 4
value = 0, 3

[State 1220, Width 1]
type = Width
trigger1 = AnimElemTime(5) >= 0 && AnimElemTime(6) < 0
value = 10,0

[State 1220, Width 2]
type = Width
trigger1 = AnimElemTime(6) >= 0 && AnimElemTime(9) < 0
value = 20,0

[State 1220, Shake Screen]
type = EnvShake
trigger1 = AnimElem = 6
time = 8
ampl = 3
freq = 170

[State 1220, 2]
type = HitDef
trigger1 = Time = 0
attr = S, SA
animtype  = Hard
damage    = 125, 9
getpower  = 0
priority  = 5
guardflag = MA
pausetime = 15,15
sparkxy = 0,-65
hitsound   = 5,4
guardsound = 6,0
ground.type = Low
ground.slidetime = 20
ground.hittime  = 32
ground.velocity = -15
ground.cornerpush.veloff = -20 ;To push far away when p2 is in corner
guard.velocity = -9
air.velocity = -5,-5
airguard.velocity = -5,-5
air.fall = 1
fall.animtype = Hard           ;Show "hard" animtype when hit for a fall
yaccel = .4                    ;Fall faster

[State 1220, 3]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1


;---------------------------------------------------------------------------
; Kung Fu Blocking High
; CNS difficulty: medium
; Notes: This move uses a ReversalDef controller to counter attacks. Any
;        attacks not caught by the ReversalDef are handled by the HitOverride.
;        The movetype is Idle because this is not an attack.
[Statedef 1300]
type    = S
movetype= I
physics = S
velset = 0,0
anim = 1300
ctrl = 0
sprpriority = 1

[State 1300, Width]
type = Width
trigger1 = AnimElemTime(3) < 0
value = 15,0

[State 1300, 1]
type = PlaySnd
trigger1 = Time = 0
value = 0, 1

[State 1300, 2]
type = ReversalDef
trigger1 = Time = 0
reversal.attr = SA, AA
pausetime = 0,0
sparkno = 40
sparkxy = 40,0
hitsound = 6,0
p1stateno = 1310
p1sprpriority = 2 ;Set P1's sprite in front of P2's
p2sprpriority = 1

[State 1300, 3] ;Stop ReversalDef
type = ReversalDef
trigger1 = Time = 4
trigger1 = Time = command = "holdfwd"
trigger2 = Time = 8
reversal.attr =

[State 1300, 4]
type = HitOverride
trigger1 = Time = 0
attr = SA, AP
stateno = 1310
time = 8

[State 1300, 5]
type = HitOverride
trigger1 = Time = 4
trigger1 = Time = command = "holdfwd"
attr =
time = 0

[State 1300, 6]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Kung Fu Blocking High (blocked)
; Notes: This state uses a Pause controller to freeze the action dramatically.
[Statedef 1310]
type    = S
movetype= I
physics = S
velset = 0,0
anim = 1310
ctrl = 0
sprpriority = 2

[State 1310, 1]
type = Pause
trigger1 = Time = 0
time = 20
endcmdbuftime = 20 ;Buffer commands input during the pause
pausebg = 0        ;Don't pause backgrounds

[State 1310, 2]    ;Go to guarding
type = ChangeState
trigger1 = Time = 1
trigger1 = command = "holdback"
value = 130
ctrl = 1

[State 1310, 3]
type = NotHitBy
trigger1 = Time = 0
value = SCA
time = 1

[State 1310, 4]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Kung Fu Blocking Low
[Statedef 1320]
type    = C
movetype= I
physics = C
velset = 0,0
anim = 1320
ctrl = 0
sprpriority = 1

[State 1320, Width]
type = Width
trigger1 = AnimElemTime(3) < 0
value = 10,0

[State 1320, 1]
type = PlaySnd
trigger1 = Time = 0
value = 0, 1

[State 1320, 2]
type = ReversalDef
trigger1 = Time = 0
reversal.attr = C, AA
pausetime = 0,0
sparkno = 40
sparkxy = 40,0
hitsound = 6,0
p1stateno = 1330
p1sprpriority = 2
p2sprpriority = 1

[State 1320, 3] ;Stop
type = ReversalDef
trigger1 = Time = 5
reversal.attr =

[State 1320, 4]
type = HitOverride
trigger1 = Time < 5
attr = C, AP
stateno = 1330

[State 1320, 5]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

;---------------------------------------------------------------------------
; Kung Fu Blocking Low (blocked)
[Statedef 1330]
type    = C
movetype= I
physics = C
velset = 0,0
anim = 1330
ctrl = 0
sprpriority = 2

[State 1330, 1]
type = Pause
trigger1 = Time = 0
time = 20
endcmdbuftime = 20 ;Buffer commands input during the pause
pausebg = 0        ;Don't pause backgrounds

[State 1330, 2]
type = ChangeState
trigger1 = Time = 1
trigger1 = command = "holdback"
value = 131
ctrl = 1

[State 1330, 3]
type = NotHitBy
trigger1 = Time = 0
value = SCA
time = 1

[State 1330, 4]
type = ChangeState
trigger1 = AnimTime = 0
value = 11
ctrl = 1

;---------------------------------------------------------------------------
; Kung Fu Blocking Air
[Statedef 1340]
type    = A
movetype= I
physics = N
anim = 1340
ctrl = 0
sprpriority = 1

[State 1340, Width]
type = Width
trigger1 = AnimElemTime(3) < 0
value = 10,0

[State 1340, 1]
type = PlaySnd
trigger1 = Time = 0
value = 0, 1

[State 1340, 2]
type = ReversalDef
trigger1 = Time = 0
reversal.attr = A, AA
pausetime = 0,0
sparkno = 40
sparkxy = 40,0
hitsound = 6,0
p1stateno = 1350
p1sprpriority = 2
p2sprpriority = 1

[State 1340, 3] ;Stop
type = ReversalDef
trigger1 = Time = 5
reversal.attr =

[State 1340, 4]
type = HitOverride
trigger1 = Time < 5
attr = SA, AP
stateno = 1350

[State 1340, 5]
type = CtrlSet
trigger1 = AnimElem = 4
value = 1

[State 1340, 6] ;Gravity
type = VelAdd
trigger1 = 1
y = Const(movement.yaccel)

[State 1340, 6] ;Land from jump
type = ChangeState
trigger1 = (Pos Y >= 0) && (Vel Y > 0)
value = 1351

;---------------------------------------------------------------------------
; Kung Fu Blocking Air (blocked)
[Statedef 1350]
type    = A
movetype= I
physics = N
anim = 1350
ctrl = 0
sprpriority = 2

[State 1350, 1]
type = Pause
trigger1 = Time = 0
time = 20
endcmdbuftime = 20 ;Buffer commands input during the pause
pausebg = 0        ;Don't pause backgrounds

[State 1350, 2]
type = ChangeState
trigger1 = Time = 1
trigger1 = command = "holdback"
value = 132
ctrl = 1

[State 1350, 3]
type = NotHitBy
trigger1 = Time = 0
value = SCA
time = 1

[State 1350, 4] ;Stop KFM in the air
type = PosFreeze
trigger1 = AnimElemTime(3) < 0

[State 1350, 5]
type = CtrlSet
trigger1 = AnimElem = 3
value = 1

[State 1350, 6] ;Gravity
type = VelAdd
trigger1 = AnimElemTime(3) > 0
y = Const(movement.yaccel)

[State 1350, 7] ;Land from jump
type = ChangeState
trigger1 = (Pos Y >= 0) && (Vel Y > 0)
value = 1351

;---------------------------------------------------------------------------
; Kung Fu Blocking Air (land)
[Statedef 1351]
type    = S
physics = S
ctrl = 0
anim = 47

[State 1351, 1]
type = VelSet
trigger1 = Time = 0
y = 0

[State 1351, 2]
type = PosSet
trigger1 = Time = 0
y = 0

[State 1351, 3]
type = CtrlSet
trigger1 = Time = 3
value = 1

[State 1351, 4]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

[State 1351, 5] ;Go to high block
type = ChangeState
trigger1 = command = "blocking"
trigger1 = command != "holddown"
value = 1300

[State 1351, 6] ;Go to low block
type = ChangeState
trigger1 = command = "blocking"
value = 1320

;---------------------------------------------------------------------------
; Light Kung Fu Zankou
; CNS difficulty: easy
[Statedef 1400]
type    = S
movetype= A
physics = N
juggle  = 4
poweradd= 50
velset = 0,0
anim = 1400
ctrl = 0
sprpriority = 2

[State 1400, 1]
type = PlaySnd
trigger1 = AnimElem = 3
value = 0, 3

[State 1400, Friction]
type = VelMul
trigger1 = 1
x = 0.5

[State 1400, 2]
type = HitDef
trigger1 = Time = 0
attr = S, SA
animtype  = Hard
damage    = 100, 6
priority  = 4
guardflag = MA
pausetime = 12,12
sparkxy = 0,-65
hitsound   = 5,3
guardsound = 6,0
ground.type = Low
ground.slidetime = 12
ground.hittime  = 17
ground.velocity = -9
ground.cornerpush.veloff = -15 ;To push far away when p2 is in corner
guard.velocity = -9
air.velocity = -2,-5
airguard.velocity = -3.5,-4.5
air.fall = 1

[State 1400, 3]
type = PosAdd
trigger1 = AnimElem = 2
trigger2 = AnimElem = 3
trigger3 = AnimElem = 4
x = 10

[State 1400, 4]
type = VelSet
trigger1 = AnimElem = 4
x = 2

[State 1400, 5]
type = PosAdd
trigger1 = AnimElem = 8
x = 10

[State 1400, 6]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Strong Kung Fu Zankou
; CNS difficulty: easy
[Statedef 1410]
type    = S
movetype= A
physics = N
juggle  = 4
poweradd= 50
velset = 0,0
anim = 1410
ctrl = 0
sprpriority = 2

[State 1410, 1]
type = PlaySnd
trigger1 = AnimElem = 3
value = 0, 3

[State 1410, Friction]
type = VelMul
trigger1 = 1
x = 0.65

[State 1410, 2]
type = HitDef
trigger1 = Time = 0
attr = S, SA
animtype  = Hard
damage    = 100, 6
priority  = 4
guardflag = MA
pausetime = 12,12
sparkxy = 0,-65
hitsound   = 5,3
guardsound = 6,0
ground.type = Low
ground.slidetime = 12
ground.hittime  = 17
ground.velocity = -9
ground.cornerpush.veloff = -15 ;To push far away when p2 is in corner
guard.velocity = -9
air.velocity = -2,-5
airguard.velocity = -3.5,-4.5
air.fall = 1

[State 1410, 3]
type = PosAdd
trigger1 = AnimElem = 2
trigger2 = AnimElem = 3
trigger3 = AnimElem = 4
x = 10

[State 1410, 4]
type = VelSet
trigger1 = AnimElem = 3
x = 8

[State 1410, 5]
type = PosAdd
trigger1 = AnimElem = 9
x = 10

[State 1410, 6]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Far Kung Fu Zankou
; CNS difficulty: easy
[Statedef 1420]
type    = S
movetype= A
physics = N
juggle  = 6
poweradd= -330
velset = 0,0
anim = 1420
ctrl = 0
sprpriority = 2

[State 1420, Afterimage]
type = AfterImage
trigger1 = Time = 0
length = 13
PalBright   =  30, 30,  0
PalContrast =  70, 70, 20
PalAdd      = -10,-10,-10
PalMul      = .85,.85,.50
TimeGap  = 1
FrameGap = 2
Trans = Add
time = 2

[State 1420, Afterimage]
type = AfterImageTime
trigger1 = AnimElemTime(8) < 0
time = 2

[State 1420, Blink Yellow]
type = PalFX
trigger1 = Time = 0
time = 20
add = 32,16,0
sinadd = 64,32,5,3

[State 1420, 1]
type = PlaySnd
trigger1 = AnimElem = 3
value = 0, 3

[State 1420, Friction]
type = VelMul
trigger1 = 1
x = 0.7

[State 1420, 2]
type = HitDef
trigger1 = AnimElemTime(4) = -2
attr = S, SA
animtype  = Hard
damage    = 25, 2
getpower  = 0
priority  = 4
guardflag = MA
pausetime = 9,9
sparkxy = -15,-45
hitsound   = 5,2
guardsound = 6,0
ground.type = Low
ground.slidetime = 22
ground.hittime  = 24
ground.velocity = -7
ground.cornerpush.veloff = -8 ;To push far away when p2 is in corner
guard.velocity = -9
air.velocity = -5,-4
airguard.velocity = -3.5,-4.5

[State 1420, 2]
type = HitDef
trigger1 = AnimElem = 4
attr = S, SA
animtype  = Hard
damage    = 100, 8
getpower  = 0
priority  = 5
guardflag = MA
pausetime = 12,12
sparkxy = 0,-65
hitsound   = 5,3
guardsound = 6,0
ground.type = Low
ground.slidetime = 22
ground.hittime  = 24
ground.velocity = -5,-4
ground.cornerpush.veloff = -15 ;To push far away when p2 is in corner
guard.velocity = -9
air.velocity = -5,-4
airguard.velocity = -3.5,-4.5
fall = 1

[State 1420, 3]
type = PosAdd
trigger1 = AnimElem = 2
trigger2 = AnimElem = 3
trigger3 = AnimElem = 4
x = 10

[State 1420, 4]
type = VelSet
trigger1 = AnimElemTime(3) = [1,2]
x = 20

[State 1420, 5]
type = PosAdd
trigger1 = AnimElem = 10
x = 10

[State 1420, 6]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Triple Kung Fu Palm (hyper)
; CNS difficulty: medium
; Notes: Notice that the HitDefs in supers have "getpower = 0". This makes
;        sure KFM doesn't recharge his super guage as he hits.
;        Also, the attributes for the HitDefs is "HA" for "hyper attack",
;        ie. "attr = S, HA".
;        Notice how the first HitDef is reused twice by allowing it to
;        trigger on two animation elements.
[Statedef 3000]
type    = S
movetype= A
physics = S
juggle  = 4
velset = 0,0
anim = 3000
ctrl = 0
sprpriority = 2

[State 3000, Width]
type = Width
trigger1 = AnimElem = 2, >= 0
value = 15,0

[State 3000, Super A]
type = SuperPause
trigger1 = AnimElem = 2, 1
pos = 25, -57
anim = 100
sound = 20, 0
poweradd = -1000

[State 3000, Super B]
type = AfterImage
trigger1 = AnimElem = 2, 1
time = 2

[State 3000, Super C]
type = AfterImageTime
trigger1 = AnimElemTime(2) >= 1 && Time < 60
time = 2

[State 3000, Super D]
type = NotHitBy
trigger1 = AnimElem = 2
value = , NA, SA, AT
time = 11

[State 3000, Super E]
type = NotHitBy
trigger1 = AnimElemTime(2) >= 0 && AnimElemTime(14) < 0
value2 = C, NA
time = 1

[State 3000, 1]
type = PlaySnd
trigger1 = AnimElem = 4
trigger2 = AnimElem = 12
trigger3 = AnimElem = 20
value = 0, 3

[State 3000, 2]
type = PosAdd
trigger1 = AnimElem = 2
x = 20

[State 3000, 3]
type = PosAdd
trigger1 = AnimElem = 3
trigger2 = AnimElem = 11
trigger3 = AnimElem = 13
trigger4 = AnimElem = 19
trigger5 = AnimElem = 21
trigger4 = AnimElem = 31
x = 10

[State 3000, 4]
type = VelSet
trigger1 = AnimElem = 5
trigger2 = AnimElem = 13
trigger3 = AnimElem = 21
x = 6

[State 3000, 4]
type = PosAdd
trigger1 = AnimElem = 5
x = 5

[State 3000, 5]
type = HitDef
trigger1 = AnimElem = 5
trigger2 = AnimElem = 13
attr = S, HA
animtype  = Hard
damage    = 72,4
getpower  = 0
priority  = 6
guardflag = MA
pausetime = 15,15
sparkxy = -10,-60
hitsound   = 5,4
guardsound = 6,0
ground.type = Low
ground.slidetime = 30
ground.hittime  = 32
ground.velocity = -6
air.velocity = -3,-2.8
air.fall = 1
fall.animtype = Hard
fall.recover = 0

[State 3000, 6]
type = HitDef
trigger1 = AnimElem = 21
attr = S, HA
animtype  = Hard
damage    = 75,4
getpower  = 0
priority  = 5
guardflag = MA
pausetime = 15,15
sparkxy = -10,-60
hitsound   = 5,4
guardsound = 6,0
ground.type = Low
ground.slidetime = 30
ground.hittime  = 32
ground.velocity = -5, -4
guard.velocity = -12
air.velocity = -5,-4
airguard.velocity = -3,-3
fall.animtype = Hard
fall = 1
fall.recover = 0

[State 3000, 7]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;---------------------------------------------------------------------------
; Smash Kung Fu Upper (hyper)
; CNS difficulty: medium
; Description: This is very similar to KFM's Strong and Light Kung Fu Uppers.
;     There is just one HitDef, for a screen-shaking hit. The envshake
;     parameters are used to make this effect. You can find out more about
;     each parameter in the CNS documentation.
;     The fall.recover parameter is set at 0, meaning that p2 cannot recover
;     from the fall by entering his recovery command (for KFM, that is x+y).
;     This gives the attacking KFM a chance to follow up with another attack,
;     such as the Fast Kung Fu Palm.
;     Note that there is a ChangeState controller used to make KFM change to
;     a success state if he hits. The success state has KFM hold his arm
;     up longer for a dramatic effect.
[Statedef 3050]
type    = S
movetype= A
physics = S
juggle  = 4
velset = 0,0
anim = 3050
ctrl = 0
sprpriority = 2

[State 3050, Width]
type = Width
trigger1 = AnimElemTime(4) >= 0 && AnimElemTime(16) < 0
value = 5,0

[State 3050, Super A]
type = SuperPause
trigger1 = AnimElem = 2
pos = -5, -55
anim = 100
sound = 20, 0
poweradd = -1000

[State 3050, Super B]
type = AfterImage
trigger1 = AnimElem = 2
time = 2

[State 3050, Super C]
type = AfterImageTime
trigger1 = AnimElemTime(2) >= 0
time = 2

[State 3050, Super D]
type = NotHitBy
trigger1 = AnimElem = 2
value = , NA, SA, AT
time = 6

[State 3050, 1]
type = PlaySnd
trigger1 = AnimElem = 4
value = 0, 2

[State 3050, 2]
type = HitDef
trigger1 = Time = 0
attr = S, HA
animtype  = Up               ;Make p2 use "Up" type animation on hit
damage    = 155, 12
getpower  = 0
priority  = 5
guardflag = MA
pausetime = 30,30
sparkno = 3
sparkxy = 0,-110
hitsound   = 5,4
guardsound = 6,0
ground.type = Low
ground.slidetime = 26
ground.hittime  = 28
ground.velocity = -1.3,-25
guard.velocity = -11
air.velocity = -1.3,-25
airguard.velocity = -4.5,-5
envshake.time = 25           ;Parameters for shaking the screen on hit
envshake.ampl = 7
envshake.freq = 176
p2facing = 1                 ;Force p2 to face p1 on hit
fall = 1
fall.recover = 0             ;Prevent p2 from recovering
fall.damage = 70             ;p2 will take 70 damage on hitting the ground
fall.envshake.ampl = 6       ;Parameters for shaking the screen on fall
fall.envshake.freq = 178
fall.envshake.time = 15
mindist = 50,-100            ;Keep p2 a minimum of 50 pixels away from p1, and no higher than 100 pixels up
maxdist = 100,-10            ;Keep p2 a maximum of 100 pixels away from p1, and no lower than 10 pixels below
yaccel = .8                  ;Accelerate p2 downwards rapidly

;This controller below makes Kung Fu man change to a success state if he
;successfully hits the Smash Kung Fu Upper.
[State 3050, 4]
type = ChangeState
trigger1 = MoveHit
value = 3051

[State 3050, 5]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

;------------------
; Smash Kung Fu Upper (success)
; Description: This is the state that KFM changes to if he successfully hits
;     with Smash Kung Fu Upper. KFM holds his arm high for a short while
;     longer, then changes back to his idle stand state.
[Statedef 3051]
type    = S
movetype= A
physics = S
anim = 3051

[State 3051, 1]
type = AfterImageTime
trigger1 = AnimTime < -2
time = 2

[State 3051, 2]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1


;---------------------------------------------------------------------------
; Override common states (use same number to override) :
;---------------------------------------------------------------------------

;---------------------------------------------------------------------------
; States that are always executed (use statedef -2)
;---------------------------------------------------------------------------

;---------------------------------------------------------------------------
; States that are executed when in self's state file (use statedef -3)
;---------------------------------------------------------------------------

[Statedef -3]

;This controller plays a sound everytime KFM lands from a jump, or
;from his back-dash.
[State -3, Landing Sound]
type = PlaySnd
triggerall = Time = 1
trigger1 = stateno = 52 ;Jump land
trigger2 = stateno = 106 ;Run-back land
value = 40, 0

}