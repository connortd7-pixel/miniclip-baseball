batOrderChecker = function()
{
   trace("--------------------------------------bat order checker--------------------------");
   trace("batOrder checker - batsmanOnStrike now is: " + batsmanOnStrike);
   if(batsmanOnStrike == 10)
   {
      batsmanOnStrike = 1;
      batsman1Out = "no";
   }
   if(batmanOnStrike == 11)
   {
      batsmanOnStrike = 2;
      batsman2Out = "no";
   }
   if(batmanOnStrike == 12)
   {
      batsmanOnStrike = 3;
      batsman3Out = "no";
   }
};
_root.batSwing_sound = new Sound(_root.sound0);
_root.batSwing_sound.attachSound("batSwing_fast");
_root.batSwing_sound.setVolume(20);
_root.batHit_good_sound = new Sound(_root.sound1);
_root.batHit_good_sound.attachSound("batHit_good");
_root.batHit_medium_sound = new Sound(_root.sound1);
_root.batHit_medium_sound.attachSound("batHit_medium");
_root.batHit_mediumPoor_sound = new Sound(_root.sound1);
_root.batHit_mediumPoor_sound.attachSound("batHit_mediumPoor");
_root.batHit_poorly_sound = new Sound(_root.sound1);
_root.batHit_poorly_sound.attachSound("batHit_poorly");
_root.ballCatch_1_sound = new Sound(_root.sound2);
_root.ballCatch_1_sound.attachSound("ballCatch_1");
_root.ballCatch_3_sound = new Sound(_root.sound2);
_root.ballCatch_3_sound.attachSound("ballCatch_3");
_root.organ_sound = new Sound(_root.sound3);
_root.organ_sound.attachSound("baseball_organ_FX");
_root.organ_sound.setVolume(30);
_root.organ_tense_sound = new Sound(_root.sound3);
_root.organ_tense_sound.attachSound("baseball_organ_tense_FX");
_root.crowd_bigClap_sound = new Sound(_root.sound5);
_root.crowd_bigClap_sound.attachSound("crowd_bigClap");
_root.crowd_smallCheer_sound = new Sound(_root.sound5);
_root.crowd_smallCheer_sound.attachSound("crowd_smallCheer");
_root.crowd_smallClap_sound = new Sound(_root.sound5);
_root.crowd_smallClap_sound.attachSound("crowd_smallClap");
_root.crowd_unhappy_sound = new Sound(_root.sound5);
_root.crowd_unhappy_sound.attachSound("crowd_unhappy");
_root.umpire_out_1_sound = new Sound(_root.sound6);
_root.umpire_out_1_sound.attachSound("umpire_out_1");
_root.umpire_out_1_sound.setVolume(30);
_root.umpire_out_2_sound = new Sound(_root.sound6);
_root.umpire_out_2_sound.attachSound("umpire_out_2");
_root.umpire_safe_sound = new Sound(_root.sound6);
_root.umpire_safe_sound.attachSound("umpire_safe");
_root.umpire_Strike_grunt_sound = new Sound(_root.sound6);
_root.umpire_Strike_grunt_sound.attachSound("umpire_Strike_grunt");
_root.umpire_yourOuttaHere_1_sound = new Sound(_root.sound7);
_root.umpire_yourOuttaHere_1_sound.attachSound("umpire_yourOuttaHere_1");
_root.umpire_yourOuttaHere_1_sound.setVolume(60);
_root.umpire_yourOuttaHere_2_sound = new Sound(_root.sound7);
_root.umpire_yourOuttaHere_2_sound.attachSound("umpire_yourOuttaHere_2");
_root.umpire_yourOuttaHere_3_sound = new Sound(_root.sound7);
_root.umpire_yourOuttaHere_3_sound.attachSound("umpire_yourOuttaHere_3");
_root.ballCatch_1_field_sound = new Sound(_root.sound8);
_root.ballCatch_1_field_sound.attachSound("ballCatch_1");
_root.ballCatch_1_field_sound.setVolume(18);
_root.ballCatch_3_field_sound = new Sound(_root.sound8);
_root.ballCatch_3_field_sound.attachSound("ballCatch_3");
overall_score = 0;
ballAll._visible = false;
ballShadow._visible = false;
sendTheFinalScores = function()
{
   _parent._parent.batsman1_score = _parent.batsman1_score;
   _parent._parent.batsman2_score = _parent.batsman2_score;
   _parent._parent.batsman3_score = _parent.batsman3_score;
   _parent._parent.batsman4_score = _parent.batsman4_score;
   _parent._parent.batsman5_score = _parent.batsman5_score;
   _parent._parent.batsman6_score = _parent.batsman6_score;
   _parent._parent.batsman7_score = _parent.batsman7_score;
   _parent._parent.batsman8_score = _parent.batsman8_score;
   _parent._parent.batsman9_score = _parent.batsman9_score;
   _parent._parent.score = _parent.score;
   _parent._parent.out = _parent.out;
   _parent._parent.ballsPitched = _parent.ballsPitched;
};
checkTheScores = function()
{
   if(_parent.out >= _parent.maximumOuts and _parent.score < _parent.scoreTarget - 1)
   {
      sendTheFinalScores();
      _parent._parent.gotoAndStop("matchLost");
   }
   if(_parent.score >= _parent.scoreTarget)
   {
      sendTheFinalScores();
      _parent._parent.gotoAndStop("matchWon");
   }
   if(_parent.out >= _parent.maximumOuts and _parent.score == _parent.scoreTarget - 1)
   {
      if(_parent._parent.scoreTarget > 1)
      {
         _parent._parent.scoreTarget -= 1;
      }
      sendTheFinalScores();
      _parent._parent.gotoAndStop("inningsTied");
   }
};
checkTheScores();
runOut = function()
{
   batOrderChecker();
   _parent.runnersMoving--;
   if(_parent.runnersMoving == 0)
   {
      btn_nextBall._visible = true;
      btn_nextBall.gotoAndStop(2);
   }
   trace("they\'re outta here == " + o);
   _parent.out++;
   eval("field.runnerHolder.runner" + o).stop();
   field["runnerHolder.runner" + o + ".outText"]._x = eval("field.runnerHolder.runner" + o + ".position");
   field["runnerHolder.runner" + o + ".outText"]._y = eval("field.runnerHolder.runner" + o + ".position");
   eval("field.runnerHolder.runner" + o + ".outText").gotoAndPlay(2);
   eval("field.runnerHolder.runner" + o + ".outWalk").gotoAndPlay(2);
   eval("field.runnerHolder.runner" + o + ".runner")._visible = false;
   eval("field.runnerHolder.runner" + o + ".btn_slide")._visible = false;
   _parent["batsman" + o + "_out"] = "yes";
   if(_parent["potential_out" + o + "_runningTo"] == "base1")
   {
      _parent.base1_potential = "no";
      _parent.whosOnBase1 = "none";
      field.umpire1.gotoAndPlay("out");
   }
   if(_parent["potential_out" + o + "_runningTo"] == "base2")
   {
      _parent.base2_potential = "no";
      _parent.whosOnBase2 = "none";
      field.umpire2.gotoAndPlay("out");
   }
   if(_parent["potential_out" + o + "_runningTo"] == "base3")
   {
      _parent.base3_potential = "no";
      _parent.whosOnBase3 = "none";
      field.umpire3.gotoAndPlay("out");
   }
   if(_parent["potential_out" + o + "_runningTo"] == "base4")
   {
      _parent.base4_potential = "no";
      _parent.whosOnBase4 = "none";
   }
   _parent["potential_out" + o + "_runningTo"] = "none";
   _parent["runner" + o + "_inPlay"] = "no";
   trace("RESETTING STRIKES _________ Code A");
   _parent.strikes = 0;
   _parent.noBalls = 0;
   _parent.wasTheLastBallHit = "runOut";
   _root.umpire_out_2_sound.start();
   _root.crowd_unhappy_sound.start();
   batOrderChecker();
};
caughtOut = function()
{
   batOrderChecker();
   ballCaught = "yes";
   _parent.out++;
   _root.ballCatch_3_field_sound.start();
   eval("field.runnerHolder.runner" + batsmanOnStrike).stop();
   eval("field.runnerHolder.runner" + batsmanOnStrike + ".outText").gotoAndPlay(2);
   eval("field.runnerHolder.runner" + batsmanOnStrike + ".outWalk").gotoAndPlay(2);
   eval("field.runnerHolder.runner" + batsmanOnStrike + ".runner")._visible = false;
   eval("field.runnerHolder.runner" + batsmanOnStrike + ".btn_slide")._visible = false;
   eval("field.runnerHolder.runner" + batsmanOnStrike + ".runBtn")._visible = false;
   trace("they\'re outta here == " + batsmanOnStrike);
   _parent["batsman" + batsmanOnStrike + "_out"] = "yes";
   if(_parent["potential_out" + batsmanOnStrike + "_runningTo"] == "waiting")
   {
      trace("this is where the batman\'s running " + _parent["potential_out" + batsmanOnStrike + "_runningTo"]);
      _parent.newRunnerNumber++;
   }
   if(_parent["potential_out" + batsmanOnStrike + "_runningTo"] != "waiting" and _parent["potential_out" + batsmanOnStrike + "_runningTo"] != "none")
   {
      _parent.runnersMoving--;
   }
   if(_parent["potential_out" + batsmanOnStrike + "_runningTo"] == "base1")
   {
      _parent.base1_potential = "no";
   }
   if(_parent["potential_out" + batsmanOnStrike + "_runningTo"] == "base2")
   {
      _parent.base2_potential = "no";
   }
   if(_parent["potential_out" + batsmanOnStrike + "_runningTo"] == "base3")
   {
      _parent.base3_potential = "no";
   }
   if(_parent["potential_out" + batsmanOnStrike + "_runningTo"] == "base4")
   {
      _parent.base4_potential = "no";
   }
   _parent["potential_out" + batsmanOnStrike + "_runningTo"] = "none";
   _parent["runner" + batsmanOnStrike + "_inPlay"] = "no";
   if(_parent["runner" + batsmanOnStrike + "_state"] == "base1")
   {
      _parent.base1_state = "empty";
   }
   if(_parent["runner" + batsmanOnStrike + "_state"] == "base2")
   {
      _parent.base2_state = "empty";
   }
   if(_parent["runner" + batsmanOnStrike + "_state"] == "base3")
   {
      _parent.base3_state = "empty";
   }
   if(_parent["runner" + batsmanOnStrike + "_state"] == "base4")
   {
      _parent.base4_state = "empty";
   }
   if(_parent.runnersMoving == 0)
   {
      btn_nextBall.gotoAndStop(2);
      trace("should play the movie now");
   }
   trace("RESETTING STRIKES _________ Code B");
   _parent.strikes = 0;
   _parent.noBalls = 0;
   _parent.wasTheLastBallHit = "caughtOut";
   _root.umpire_out_1_sound.start();
   _root.crowd_unhappy_sound.start();
   batOrderChecker();
};
struckOut = function()
{
   batOrderChecker();
   trace("they\'re STRUCK outta here == " + batsmanOnStrike);
   _parent.wasTheLastBallHit = "struckOut";
   _parent.out++;
   eval("field.runnerHolder.runner" + batsmanOnStrike).gotoAndStop("empty");
   _parent["batsman" + batsmanOnStrike + "_out"] = "yes";
   _parent.lastHitter = batsmanOnStrike;
   _parent.newRunnerNumber++;
   batsmanOnStrike = _parent.newRunnerNumber;
   field.runnerHolder.attachMovie("runner","runner" + batsmanOnStrike,batsmanOnStrike);
   eval("field.runnerHolder.runner" + batsmanOnStrike).runnerNumber = batsmanOnStrike;
   eval("field.runnerHolder.runner" + batsmanOnStrike).gotoAndStop(eval("_parent.runner" + batsmanOnStrike + "_state"));
   trace("RESETTING STRIKES _________ Code C");
   _parent.strikes = 0;
   _parent.noBalls = 0;
   trace("should play the scoreboard now");
   scoreboard.gotoAndPlay("runsToGet");
   batOrderChecker();
};
startTheRunners = function()
{
   if(field.shadowFlyMarker._x < field.foulMarkerRight._x and field.shadowFlyMarker._x > field.foulMarkerLeft._x)
   {
      if(_parent.base1_state == "empty")
      {
         _parent.newRunnerNumber++;
         _parent.runnersMoving++;
         _parent["potential_out" + batsmanOnStrike] = "yes";
         _parent["potential_out" + batsmanOnStrike + "_runningTo"] = "base1";
         eval("field.runnerHolder.runner" + batsmanOnStrike).gotoAndPlay("runToFirst");
         _parent.base1_potential = "yes";
      }
      if(_parent.base1_state == "full")
      {
         btn_nextBall.gotoAndStop(1);
         _parent.newRunnerNumber++;
         eval("field.runnerHolder.runner" + _parent.whosOnBase1).gotoAndPlay("runToSecond");
         _parent.runnersMoving++;
         _parent.base1_state = "empty";
         _parent["potential_out" + _parent.whosOnBase1] = "yes";
         _parent["potential_out" + _parent.whosOnBase1 + "_runningTo"] = "base2";
         _parent.base2_potential = "yes";
         eval("field.runnerHolder.runner" + batsmanOnStrike).gotoAndPlay("runToFirst");
         _parent.runnersMoving++;
         _parent["potential_out" + batsmanOnStrike] = "yes";
         _parent["potential_out" + batsmanOnStrike + "_runningTo"] = "base1";
         _parent.base1_potential = "yes";
         if(_parent.base2_state == "full")
         {
            eval("field.runnerHolder.runner" + _parent.whosOnBase2).gotoAndPlay("runToThird");
            _parent.runnersMoving++;
            _parent.base2_state = "empty";
            _parent["potential_out" + _parent.whosOnBase2] = "yes";
            _parent["potential_out" + _parent.whosOnBase2 + "_runningTo"] = "base3";
            _parent.base3_potential = "yes";
            if(_parent.base3_state == "full")
            {
               eval("field.runnerHolder.runner" + _parent.whosOnBase3).gotoAndPlay("runToFourth");
               _parent.runnersMoving++;
               _parent.base3_state = "empty";
               _parent["potential_out" + _parent.whosOnBase3] = "yes";
               _parent["potential_out" + _parent.whosOnBase3 + "_runningTo"] = "base4";
               _parent.base4_potential = "yes";
            }
         }
      }
   }
};
buttonController = function()
{
   buttonController_functionHolder.onEnterFrame = function()
   {
      if(_parent.base2_state == "full")
      {
         eval("field.runnerHolder.runner" + _parent.whosOnBase1 + ".runBtn")._visible = false;
      }
      else
      {
         eval("field.runnerHolder.runner" + _parent.whosOnBase1 + ".runBtn")._visible = true;
      }
      if(_parent.base3_state == "full")
      {
         trace("base 3 is full, so make sure who\'s on base 2 (" + _parent.whosOnBase2 + ") can\'t run there");
         eval("field.runnerHolder.runner" + _parent.whosOnBase2 + ".runBtn")._visible = false;
      }
      else
      {
         eval("field.runnerHolder.runner" + _parent.whosOnBase2 + ".runBtn")._visible = true;
      }
      if(ballInPlay == "no" or ballInPlay == "foulHit" or ballInPlay == "foulWalk")
      {
         h = 1;
         while(h <= 18)
         {
            eval("field.runnerHolder.runner" + h + ".runBtn")._visible = false;
            h++;
         }
      }
   };
};
buttonController();
setUpColors = function()
{
   newSkinColor = new flash.geom.ColorTransform();
   newSkinColor.rgb = eval("_parent.batsman" + batsmanOnStrike + "_skin");
   savedSkinColor = newSkinColor;
   hitter.batsman.skinMovie.transform.colorTransform = savedSkinColor;
   newClothesColor = new flash.geom.ColorTransform();
   newClothesColor = _parent.battingTeam_clothes;
   savedClothesColor = newClothesColor;
   hitter.batsman.helmetMovie.transform.colorTransform = savedClothesColor;
   hitter.batsman.tShirtMovie.transform.colorTransform = savedClothesColor;
   savedBatLogo = eval("_parent.batsman" + batsmanOnStrike + "_batLogo");
   hitter.batsman.batLogo.logo.gotoAndStop(savedBatLogo);
};
setUpVariables = function()
{
   batOrderChecker();
   _parent.runsToGet = _parent.scoreTarget - _parent.score;
   if(_parent.wasTheLastBallHit == "runOut" or _parent.wasTheLastBallHit == "caughtOut" or _parent.wasTheLastBallHit == "struckOut" or _parent.wasTheLastBallHit == "homeRun")
   {
      trace("should play the scoreboard now");
      scoreboard.gotoAndPlay("runsToGet");
   }
   hitterSwung = "no";
   ballIsPitched = "no";
   skillLevel = _parent._parent.skillLevel;
   if(skillLevel == "hard")
   {
      hitAreaTop = hitArea_hard._y;
      hitAreaBot = hitArea_hard._y + hitArea_hard._height;
      mouseDifficulty = 20;
      fielderSpeed = 0.49;
      strikeZone._visible = false;
      speed = 35 + random(15);
      trace("THE SPEED IS = " + speed);
      swing = -1.5 + 3 / (random(5) + 1);
      trace("THE SWING IS = " + swing);
      dip = 0 + 1 / (random(5) + 1);
      trace("THE DIP IS = " + dip);
   }
   if(skillLevel == "med")
   {
      hitAreaTop = hitArea_med._y;
      hitAreaBot = hitArea_med._y + hitArea_med._height;
      mouseDifficulty = 10;
      fielderSpeed = 0.45;
      strikeZone._visible = false;
      speed = 60;
      trace("THE SPEED IS = " + speed);
      swing = -0.5 + 2 / (random(5) + 1);
      trace("THE SWING IS = " + swing);
      dip = 0 + 1 / (random(10) + 1);
      trace("THE DIP IS = " + dip);
   }
   if(skillLevel == "easy")
   {
      hitAreaTop = hitArea_easy._y;
      hitAreaBot = hitArea_easy._y + hitArea_easy._height;
      mouseDifficulty = 5;
      fielderSpeed = 0.4;
      speed = 70;
      swing = 0;
      dip = 0;
   }
   ballAll.ball.stop();
   field.landMarker._x = 90 + random(350);
   field.landMarker._y = 140 + random(80);
   landMarker_distance_y = field.landMarker._y - field.bMarker._y;
   landMarker_distance_x = field.landMarker._x - field.centreMarker._x;
   landMarker._x = centreMarker._x + landMarker_distance_x * 1.3;
   landMarker._y = hMarker._y + landMarker_distance_y * 0.3;
   landMarker._xscale = 50 + landMarker_distance_y;
   landMarker._yscale = 10 + landMarker_distance_y / 5;
   r = 1;
   while(r <= _parent.newRunnerNumber)
   {
      if(eval("_parent.batsman" + r + "_out") == "no")
      {
         field.runnerHolder.attachMovie("runner","runner" + r,r);
         trace("attaching batsman number " + r);
         eval("field.runnerHolder.runner" + r).runnerNumber = r;
         eval("field.runnerHolder.runner" + r).gotoAndStop(eval("_parent.runner" + r + "_state"));
         if(_parent["runner" + r + "_state"] == "waiting")
         {
            batsmanOnStrike = r;
         }
      }
      r++;
   }
   if(_parent.lastHitter != _parent.newRunnerNumber)
   {
      trace("RESETTING STRIKES _________ Code D");
      _parent.strikes = 0;
      _parent.noBalls = 0;
   }
   _parent.lastHitter = _parent.newRunnerNumber;
   if(_parent.strikes == 3)
   {
      trace("struck out like a fool");
      struckOut();
   }
   field.fielder6.gotoAndStop("baseWaiting");
   field.fielder7.gotoAndStop("baseWaiting");
   field.fielder8.gotoAndStop("baseWaiting");
   field.fielder9.gotoAndStop("baseWaiting");
};
setUpVariables();
setUpColors();
onMouseMove = function()
{
   if(hitYet != "yes" and _xmouse > acl._x and _xmouse < acl._x + acl._width and _ymouse > acl._y and _ymouse < acl._y + acl._height and _parent.quitBoxPresent != "yes")
   {
      Mouse.hide();
   }
   else
   {
      Mouse.show();
   }
};
attachAimCircle = function()
{
   aimCircle_functionHolder.onEnterFrame = function()
   {
      if(aimCircle._x > acl._x and aimCircle._x < acl._x + acl._width and aimCircle._y > acl._y and aimCircle._y < acl._y + acl._height)
      {
         mouseDistance_x = _xmouse - aimCircle._x;
         mouseDistance_y = _ymouse - aimCircle._y;
         aimCircle._x += mouseDistance_x / mouseDifficulty;
         aimCircle._y += mouseDistance_y / mouseDifficulty;
         aimCircleShadow._x = aimCircle._x;
         if(aimCircle._x <= acl._x)
         {
            aimCircle._x = acl._x + 1;
            aimCircleShadow._x = aimCircle._x;
         }
         if(aimCircle._x >= acl._x + acl._width)
         {
            aimCircle._x = acl._x + acl._width - 1;
            aimCircleShadow._x = aimCircle._x;
         }
         if(aimCircle._y <= acl._y)
         {
            aimCircle._y = acl._y + 1;
            aimCircleShadow._x = aimCircle._x;
         }
         if(aimCircle._y >= acl._y + acl._height)
         {
            aimCircle._y = acl._y + acl._height - 1;
            aimCircleShadow._x = aimCircle._x;
         }
         if(hitYet != "yes")
         {
            fm = ballPassesBat_marker._x - aimCircle._x;
            sm = ballPassesBat_marker._x - centreMarker._x;
            aimArea._x = Math.ceil(ballPassesBat_marker._x + (fm + sm) * 3);
            shadowFlyDistance_x = aimArea._x - centreMarker._x;
            shadowFlyDistance_field = shadowFlyDistance_x;
            aimArea.gotoAndStop(aimArea._x);
         }
      }
   };
};
attachAimCircle();
swing_functionHolder.onMouseDown = function()
{
   var _loc3_;
   var _loc2_;
   if(hitterSwung == "no" and ballIsPitched == "yes")
   {
      if(_ymouse <= 200)
      {
         hitter.gotoAndPlay("hitHigh");
      }
      else if(_ymouse > 200 and _ymouse <= 280)
      {
         hitter.gotoAndPlay("hitMed");
      }
      else if(_ymouse > 280)
      {
         hitter.gotoAndPlay("hitLow");
      }
      hitter.hitTester.gotoAndPlay(skillLevel);
      hitterSwung = "yes";
      _loc3_ = new flash.geom.Point(aimCircle._x,aimCircle._y);
      _loc2_ = new flash.geom.Point(ballPassesBat_marker._x,ballPassesBat_marker._y);
      clickAccuracy = flash.geom.Point.distance(_loc3_,_loc2_);
      h = aimCircle._x - ballPassesBat_marker._x;
      v = aimCircle._y - ballPassesBat_marker._y;
      v_acc = v;
      if(v < 0)
      {
         v_acc = - v;
      }
      _root.batSwing_sound.start();
   }
};
test.ballAll.ball.stop();
calculateDistances = function()
{
   x_distance = test.aimMarker._x - test.startpointMarker._x;
   y_distance = test.aimMarker._y - test.startpointMarker._y;
   x_distanceShadow = test.shadowMarker._x - test.startpointShadowMarker._x;
   y_distanceShadow = test.shadowMarker._y - test.startpointShadowMarker._y;
   testTheBall();
};
testTheBall = function()
{
   test.ballAll.ball.play();
   i = 1;
   ballTest_functionHolder.onEnterFrame = function()
   {
      distanceFromStart = test.ballShadow._y - test.startpointShadowMarker._y;
      test.ballAll._x += x_distance / speed * (distanceFromStart / 30) + swing;
      test.ballAll._y += y_distance / speed * (distanceFromStart / 30) - dip;
      test.ballShadow._x += x_distanceShadow / speed * (distanceFromStart / 30) + swing;
      test.ballShadow._y += y_distanceShadow / speed * (distanceFromStart / 30);
      test.ballAll._xscale = distanceFromStart * 2 + 105;
      test.ballAll._yscale = distanceFromStart * 2 + 105;
      test.ballShadow._xscale = test.ballAll._xscale;
      test.ballShadow._yscale = test.ballAll._yscale;
      if(test.ballShadow._y >= test.shadowMarker._y)
      {
         test.ballAll._alpha -= 10;
         test.ballShadow._alpha -= 10;
         if(markerPlaced != "yes")
         {
            test.ballPassesBat_marker._x = test.ballAll._x;
            test.ballPassesBat_marker._y = test.ballAll._y;
            markerPlaced = "yes";
            trace("ballpassesbatmarker x = " + test.ballPassesBat_marker._x);
            trace("strikeZone x = " + strikeZone._x);
            if(test.ballPassesBat_marker._x < strikeZone._x or test.ballPassesBat_marker._x > strikeZone._x + strikeZone._width or test.ballPassesBat_marker._y < strikeZone._y or test.ballPassesBat_marker._y > strikeZone._y + strikeZone._height)
            {
               trace("THAT WILL BE A NO BALL");
               itsANoBall = "true";
            }
         }
      }
      if(test.ballAll._alpha <= 0)
      {
         delete ballTest_functionHolder.onEnterFrame;
         pitcher.gotoAndPlay("pitch");
      }
      recordDataHolder["x_ballScale" + i] = test.ballAll._xscale;
      recordDataHolder["y_ballScale" + i] = test.ballAll._yscale;
      recordDataHolder["x_ballPosition" + i] = test.ballAll._x;
      recordDataHolder["y_ballPosition" + i] = test.ballAll._y;
      recordDataHolder["alpha_ball" + i] = test.ballAll._alpha;
      recordDataHolder["x_ballShadowScale" + i] = test.ballShadow._xscale;
      recordDataHolder["y_ballShadowScale" + i] = test.ballShadow._yscale;
      recordDataHolder["x_ballShadowPosition" + i] = test.ballShadow._x;
      recordDataHolder["y_ballShadowPosition" + i] = test.ballShadow._y;
      recordDataHolder["alpha_ballShadow" + i] = test.ballShadow._alpha;
      i++;
   };
};
pitchTheBall = function()
{
   ballIsPitched = "yes";
   ballAll._visible = true;
   ballShadow._visible = true;
   ballAll.ball.gotoAndPlay(2);
   _parent.ballsPitched++;
   b = 1;
   ballPitch_functionHolder.onEnterFrame = function()
   {
      ballAll._xscale = recordDataHolder["x_ballScale" + b];
      ballAll._yscale = recordDataHolder["y_ballScale" + b];
      ballAll._x = recordDataHolder["x_ballPosition" + b];
      ballAll._y = recordDataHolder["y_ballPosition" + b];
      ballAll._alpha = recordDataHolder["alpha_ball" + b];
      ballShadow._xscale = recordDataHolder["x_ballShadowScale" + b];
      ballShadow._yscale = recordDataHolder["y_ballShadowScale" + b];
      ballShadow._x = recordDataHolder["x_ballShadowPosition" + b];
      ballShadow._y = recordDataHolder["y_ballShadowPosition" + b];
      ballShadow._alpha = recordDataHolder["alpha_ballShadow" + b];
      b++;
      if(b == i)
      {
         _root.ballCatch_1_sound.start();
         if(itsANoBall == "true" and hitterSwung != "yes")
         {
            _parent.noBalls++;
            scoreboard.gotoAndPlay("noBall");
            delete swing_functionHolder.onMouseDown;
            if(_parent.noBalls < 4)
            {
               btn_nextBall.gotoAndStop(2);
            }
            if(_parent.noBalls == 4)
            {
               ballInPlay = "foulWalk";
               foulWalkTimer.gotoAndPlay(4);
               eval("field.fielder" + activeFielder).gotoAndStop("waiting");
               delete fielder_functionHolder.onEnterFrame;
            }
         }
         else
         {
            trace("it\'s a STRRRRRRRRRRRIIIIKE " + eval("strike" + _parent.strikes));
            trace("adding a strike here. Original number of Strikes = " + _parent.strikes);
            _parent.wasTheLastBallHit = "no";
            _parent.strikes++;
            strikeAnim.gotoAndStop(["strike" + _parent.strikes]);
            scoreboard.gotoAndPlay("strike");
            _parent.lastHitter = batsmanOnStrike;
            trace("the bastsmanonStrike is:  " + batsmanOnStrike);
            trace("the lastHitter is:        " + _parent.lastHitter);
            trace("the newRunnerNumber is :  " + _parent.newRunnerNumber);
            if(_parent.strikes == 3)
            {
               randomUmpNumber = random(3);
               if(randomUmpNumber == 0)
               {
                  _root.umpire_yourOuttaHere_1_sound.start();
               }
               if(randomUmpNumber == 1)
               {
                  _root.umpire_yourOuttaHere_2_sound.start();
               }
               if(randomUmpNumber == 2)
               {
                  _root.umpire_yourOuttaHere_3_sound.start();
               }
               _root.crowd_unhappy_sound.start();
            }
            delete swing_functionHolder.onMouseDown;
            delete ballPitch_functionHolder.onEnterFrame;
         }
      }
      if(ballShadow._y > hitAreaTop and ballShadow._y < hitAreaBot)
      {
         hittable = "yes";
      }
      else
      {
         hittable = "no";
      }
      if(hittable == "yes" and hitting == "yes")
      {
         if(hitQuality == "poor")
         {
            _root.batHit_poorly_sound.start();
            _root.crowd_smallClap_sound.start();
         }
         if(hitQuality == "mediumPoor")
         {
            _root.batHit_mediumPoor_sound.start();
            _root.crowd_smallCheer_sound.start();
         }
         if(hitQuality == "medium")
         {
            _root.batHit_medium_sound.start();
            _root.crowd_smallCheer_sound.start();
            _root.crowd_smallClap_sound.start();
         }
         if(hitQuality == "good")
         {
            _root.batHit_good_sound.start();
            _root.crowd_bigClap_sound.start();
         }
         delete ballPitch_functionHolder.onEnterFrame;
         fieldTimer.gotoAndPlay(2);
         hitYet = "yes";
         _parent.lastBatsmanOnStrike = batsmanOnStrike;
         _parent.wasTheLastBallHit = "yes";
         delete swing_functionHolder.onMouseDown;
         ballFlyAway();
      }
   };
};
ballLandTester = function()
{
   test_x_speed = saved_x_speed;
   test_y_speed = saved_y_speed;
   test_fieldUpStrength = saved_fieldUpStrength;
   field.test_ballFly._x = field.startPointMarker._x;
   field.test_ballFly._y = field.startPointMarker._y;
   t = 1;
   while(t < 600)
   {
      field.test_ballFly._x += test_x_speed;
      field.test_ballFly._y += test_y_speed;
      var test_point_1 = new flash.geom.Point(field.startPointMarker._x,field.startPointMarker._y);
      var test_point_2 = new flash.geom.Point(field.test_ballFly._x,field.test_ballFly._y);
      test_u_distance = flash.geom.Point.distance(test_point_1,test_point_2);
      test_x_speed -= test_x_speed * 0.002 * (v_acc / 40) * (test_u_distance * test_u_distance / 1500);
      test_y_speed -= test_y_speed * 0.002 * (v_acc / 40) * (test_u_distance * test_u_distance / 1500);
      field.test_ballFly.ball._y -= test_fieldUpStrength;
      test_fieldUpStrength -= 0.03;
      if(field.test_ballFly.ball._y < 0)
      {
         field.landSpot._x = field.test_ballFly._x;
         field.landSpot._y = field.test_ballFly._y;
         unloadMovie(field.test_ballFly);
      }
      t++;
   }
   var fielder1_point_1 = new flash.geom.Point(field.fielder1._x,field.fielder1._y);
   var fielder1_point_2 = new flash.geom.Point(field.landSpot._x,field.landSpot._y);
   fielder1_distance = flash.geom.Point.distance(fielder1_point_1,fielder1_point_2);
   activeFielder = 1;
   closest_distance = fielder1_distance;
   f = 2;
   while(f <= 5)
   {
      var fielder_point_1 = new flash.geom.Point(eval("field.fielder" + f)._x,eval("field.fielder" + f)._y);
      var fielder_point_2 = new flash.geom.Point(field.landSpot._x,field.landSpot._y);
      fielder_distance = flash.geom.Point.distance(fielder_point_1,fielder_point_2);
      if(fielder_distance < closest_distance)
      {
         trace("the distance to fielder " + f + " = " + fielder_distance);
         closest_distance = fielder_distance;
         trace("the closest fielder is fielder " + f);
         activeFielder = f;
      }
      f++;
   }
   activateFielder();
};
ballFlyAway = function()
{
   ballFly.ball._xscale = ballAll._xscale;
   ballFly.ball._yscale = ballAll._yscale;
   ballFly.ballShadow._xscale = ballShadow._xscale;
   ballFly.ballShadow._yscale = ballShadow._yscale;
   d = ballShadow._y - ballAll._y;
   ballFly._x = ballShadow._x;
   ballFly._y = ballShadow._y;
   ballFly.ball._y -= d;
   ballAll.unloadMovie();
   ballShadow.unloadMovie();
   savedPower = power;
   upStrength = 25 + v / 8 - savedPower / 3;
   gravity = 0.4;
   shadowFlyMarker._x = aimArea._x;
   shadowFlyMarker._y += savedPower + v_acc / 2;
   fieldUpStrength = upStrength / 7 * 0.9;
   fieldGravity = gravity;
   field.shadowFlyMarker._x += shadowFlyDistance_field / 1.3;
   h_dist = shadowMarker._x - centreMarker._x;
   field.shadowFlyMarker._y += h_dist;
   field_x_distance = field.shadowFlyMarker._x - field.startPointMarker._x;
   field_y_distance = field.shadowFlyMarker._y - field.startPointMarker._y;
   x_speed = field_x_distance / (savedPower * 8);
   y_speed = field_y_distance / (savedPower * 8);
   saved_x_speed = x_speed;
   saved_y_speed = y_speed;
   saved_fieldUpStrength = fieldUpStrength;
   ballFlyAway_functionHolder.onEnterFrame = function()
   {
      x_distance = ballFly._x - shadowFlyMarker._x;
      y_distance = ballFly._y - shadowFlyMarker._y;
      y_distanceFromBase = ballFly._y - uMarker._y;
      ballFly._x -= x_distance / savedPower;
      ballFly._y -= y_distance / savedPower;
      ballFly._xscale = 100 + y_distanceFromBase / 1.9;
      ballFly._yscale = 100 + y_distanceFromBase / 1.9;
      ballFly.ball._y -= upStrength;
      if(upStrength >= -5)
      {
         upStrength -= gravity;
      }
      if(ballFly.ball._y > 0)
      {
         upStrength = upStrength * -1 / 1.25;
      }
   };
   ballFlyAwayField = function()
   {
      ballFlyAwayField_functionHolder.onEnterFrame = function()
      {
         field.ballFly._x += x_speed;
         field.ballFly._y += y_speed;
         y_distanceFromBase_field = field.ballFly._y - field.startPointMarker._y;
         field.ballFly._xscale = 60 + y_distanceFromBase_field / 10;
         field.ballFly._yscale = 60 + y_distanceFromBase_field / 10;
         var point_1 = new flash.geom.Point(field.startPointMarker._x,field.startPointMarker._y);
         var point_2 = new flash.geom.Point(field.ballFly._x,field.ballFly._y);
         u_distance = flash.geom.Point.distance(point_1,point_2);
         toSubtract = (field.ballFly._y - field.startPointMarker._y) * 3 + field.ballFly._x / 5.6;
         hit_distance = u_distance - toSubtract;
         x_speed -= x_speed * 0.002 * (v_acc / 40) * (u_distance * u_distance / 1500);
         y_speed -= y_speed * 0.002 * (v_acc / 40) * (u_distance * u_distance / 1500);
         field.ballFly.ball._y -= fieldUpStrength;
         fieldUpStrength -= 0.03;
         if(field.ballFly.ball._y > 0)
         {
            if(scoreDistance2 <= 85 and scoreDistance2 > 63)
            {
               field.landMarker.ring1.gotoAndStop(2);
            }
            if(scoreDistance2 <= 62 and scoreDistance2 > 43)
            {
               field.landMarker.ring2.gotoAndStop(2);
            }
            if(scoreDistance2 <= 42)
            {
               field.landMarker.ring3.gotoAndStop(2);
            }
            field.ballFly.ball._y = - field.ballFly.ball._y;
            fieldUpStrength = (- fieldUpStrength) / 2.5;
            if(fieldUpStrength > 1)
            {
               fieldUpStrength = 1;
            }
            fieldUpStrength -= 0.05;
            x_speed *= 0.5;
            y_speed *= 0.5;
            ballBounced = "yes";
            if(_parent.wasTheLastBallHit == "homeRun")
            {
               field.ballFly._visible = false;
            }
         }
         if(hit_distance >= 820 and reachedTheWall != "yes" and field.ballFly.ball._y > -25)
         {
            x_speed *= 0.3;
            y_speed *= 0.3;
            x_speed = - x_speed;
            y_speed = - y_speed;
            reachedTheWall = "yes";
            if(ballInPlay != "foulHit" and ballInPlay != "foulWalk")
            {
               activateFielder();
               trace("activating FIELDER THE SECOND TIME***************!!!!");
            }
         }
         else if(hit_distance >= 820 and reachedTheWall != "yes" and ballInPlay != "foulHit" and field.ballFly.ball._y < -25)
         {
            trace("it\'s a home run!");
            ballInPlay = "no";
            _parent.runnersMoving = 0;
            _parent.wasTheLastBallHit = "homeRun";
            eval("field.fielder" + activeFielder).gotoAndStop("waiting");
            delete fielder_functionHolder.onEnterFrame;
            transitions.gotoAndPlay("homeRun");
            reachedTheWall = "yes";
            _parent["potential_out" + batsmanOnStrike + "_runningTo"] = "none";
            trace("THIS IS THE BATSMAN " + batsmanOnStrike + " WHO HIT THE HOME RUN\'S POTENTIAL OUT = " + _parent["potential_out" + r + "_runningTo"]);
            _parent.base1_potential = "no";
            _parent.base2_potential = "no";
            _parent.base3_potential = "no";
            _parent.base4_potential = "no";
            r = 1;
            while(r <= 18)
            {
               if(_parent["runner" + r + "_inPlay"] == "yes" and _parent["runner" + r + "_inPlay"] != _parent["runner" + batsmanOnStrike + "_inPlay"])
               {
                  _parent["batsman" + r + "_score"] += 1;
                  _parent.score++;
                  _parent["batsman" + r + "_out"] = "yes";
                  _parent["runner" + r + "_inPlay"] = "no";
                  eval("field.runnerHolder.runner" + r).gotoAndStop("empty");
                  if(_parent["potential_out" + r + "_runningTo"] != "waiting" and _parent["potential_out" + r + "_runningTo"] != "none")
                  {
                     _parent.runnersMoving--;
                     _parent["potential_out" + r + "_runningTo"] = "none";
                  }
               }
               r++;
            }
            _parent["batsman" + batsmanOnStrike + "_score"] += 1;
            _parent.score++;
            eval("field.runnerHolder.runner" + batsmanOnStrike).gotoAndStop("empty");
            _parent["batsman" + batsmanOnStrike + "_out"] = "yes";
            if(_parent["potential_out" + batsmanOnStrike + "_runningTo"] == "waiting")
            {
               trace("this is where the batman\'s running " + _parent["potential_out" + r + "_runningTo"]);
               _parent.newRunnerNumber++;
               if(_parent.runnersMoving == 0)
               {
                  btn_nextBall.gotoAndStop(2);
                  trace("should play the movie now");
               }
            }
            if(_parent["potential_out" + batsmanOnStrike + "_runningTo"] != "waiting" and _parent["potential_out" + batsmanOnStrike + "_runningTo"] != "none")
            {
               _parent.runnersMoving--;
               if(_parent.runnersMoving == 0)
               {
                  btn_nextBall.gotoAndStop(2);
                  trace("should play the movie now");
               }
            }
            e = 1;
            while(e <= 4)
            {
               _parent["base" + e + "_state"] = "empty";
               e++;
            }
            ballInPlay = "yes";
         }
         var point_a = new flash.geom.Point(field.landMarker._x,field.landMarker._y);
         var point_b = new flash.geom.Point(field.ballFly._x,field.ballFly._y);
         scoreDistance1 = flash.geom.Point.distance(point_a,point_b);
         if(field.ballFly._y >= field.landMarker._y)
         {
            toSub = (field.ballFly._y - field.landMarker._y) * -1.1;
         }
         if(field.ballFly._y < field.landMarker._y)
         {
            toSub = (field.ballFly._y - field.landMarker._y) * 1.1;
         }
         scoreDistance2 = scoreDistance1 - toSub;
      };
   };
   ballFlyAwayField();
};
activateFielder = function()
{
   if(ballBounced == "yes")
   {
      runToTarget_x = field.ballFly._x;
      runToTarget_y = field.ballFly._y;
   }
   else
   {
      runToTarget_x = field.landSpot._x;
      runToTarget_y = field.landSpot._y;
   }
   fielder_functionHolder.onEnterFrame = function()
   {
      if(ballBounced == "yes")
      {
         runToTarget_x = field.ballFly._x;
         runToTarget_y = field.ballFly._y;
      }
      else
      {
         runToTarget_x = field.landSpot._x;
         runToTarget_y = field.landSpot._y;
      }
      field.runToMarker._x = runToTarget_x;
      field.runToMarker._y = runToTarget_y;
      fielderDistance_x = eval("field.fielder" + activeFielder)._x - runToTarget_x;
      fielderDistance_y = eval("field.fielder" + activeFielder)._y - runToTarget_y;
      theSum = fielderDistance_x * fielderDistance_x + fielderDistance_y * fielderDistance_y;
      hypotenuse = Math.sqrt(theSum);
      segments = hypotenuse / fielderSpeed;
      xStep = fielderDistance_x / segments;
      yStep = fielderDistance_y / segments;
      eval("field.fielder" + activeFielder)._x -= xStep;
      eval("field.fielder" + activeFielder)._y -= yStep;
      firstCalc = fielderDistance_x / fielderDistance_y;
      fielderAngle = Math.atan(firstCalc) / 0.017453292519943295;
      if(runToTarget_x > eval("field.fielder" + activeFielder)._x)
      {
         if(fielderAngle <= -1 and fielderAngle > -22)
         {
            fielderDirection = "goingUP";
         }
         if(fielderAngle <= -23 and fielderAngle > -67)
         {
            fielderDirection = "goingUPRIGHT";
         }
         if(fielderAngle <= -68 and fielderAngle > -90)
         {
            fielderDirection = "goingRIGHT";
         }
         if(fielderAngle <= 89 and fielderAngle > 68)
         {
            fielderDirection = "goingRIGHT";
         }
         if(fielderAngle <= 67 and fielderAngle > 23)
         {
            fielderDirection = "goingDOWNRIGHT";
         }
         if(fielderAngle <= 23 and fielderAngle > 1)
         {
            fielderDirection = "goingDOWN";
         }
      }
      if(runToTarget_x < eval("field.fielder" + activeFielder)._x)
      {
         if(fielderAngle <= -1 and fielderAngle > -22)
         {
            fielderDirection = "goingDOWN";
         }
         if(fielderAngle <= -23 and fielderAngle > -67)
         {
            fielderDirection = "goingDOWNLEFT";
         }
         if(fielderAngle <= -68 and fielderAngle > -90)
         {
            fielderDirection = "goingLEFT";
         }
         if(fielderAngle <= 89 and fielderAngle > 68)
         {
            fielderDirection = "goingLEFT";
         }
         if(fielderAngle <= 67 and fielderAngle > 23)
         {
            fielderDirection = "goingUPLEFT";
         }
         if(fielderAngle <= 23 and fielderAngle > 1)
         {
            fielderDirection = "goingUP";
         }
      }
      if(fielderDirection == "goingLEFT")
      {
         eval("field.fielder" + activeFielder).gotoAndStop("left");
      }
      if(fielderDirection == "goingRIGHT")
      {
         eval("field.fielder" + activeFielder).gotoAndStop("right");
      }
      if(fielderDirection == "goingUP")
      {
         eval("field.fielder" + activeFielder).gotoAndStop("up");
      }
      if(fielderDirection == "goingDOWN")
      {
         eval("field.fielder" + activeFielder).gotoAndStop("down");
      }
      if(fielderDirection == "goingUPRIGHT")
      {
         eval("field.fielder" + activeFielder).gotoAndStop("upRight");
      }
      if(fielderDirection == "goingUPLEFT")
      {
         eval("field.fielder" + activeFielder).gotoAndStop("upLeft");
      }
      if(fielderDirection == "goingDOWNRIGHT")
      {
         eval("field.fielder" + activeFielder).gotoAndStop("downRight");
      }
      if(fielderDirection == "goingDOWNLEFT")
      {
         eval("field.fielder" + activeFielder).gotoAndStop("downLeft");
      }
      var point_fielder = new flash.geom.Point(eval("field.fielder" + activeFielder)._x,eval("field.fielder" + activeFielder)._y);
      var point_ball = new flash.geom.Point(field.runToMarker._x,field.runToMarker._y);
      fielderDistance = flash.geom.Point.distance(point_fielder,point_ball);
      if(fielderDistance <= 2 and ballBounced == "yes")
      {
         trace("stop the fielder");
         delete fielder_functionHolder.onEnterFrame;
         workOutFielderAngles();
      }
      if(fielderDistance <= 2 and ballBounced != "yes")
      {
         trace("catching position");
         delete fielder_functionHolder.onEnterFrame;
         eval("field.fielder" + activeFielder).gotoAndStop("waitingToCatch");
         fielderCatchChecker();
      }
      var point_start = new flash.geom.Point(field.startPointMarker._x,field.startPointMarker._y);
      var point_field = new flash.geom.Point(eval("field.fielder" + activeFielder)._x,eval("field.fielder" + activeFielder)._y);
      u_distance2 = flash.geom.Point.distance(point_start,point_field);
      toSubtract2 = (eval("field.fielder" + activeFielder)._y - field.startPointMarker._y) * 3 + eval("field.fielder" + activeFielder)._x / 5.6;
      fld_distance = u_distance2 - toSubtract2;
      trace(fld_distance);
      if(fld_distance >= 845)
      {
         eval("field.fielder" + activeFielder).gotoAndStop("waiting");
         delete fielder_functionHolder.onEnterFrame;
      }
      if(field.shadowFlyMarker._x > field.foulMarkerRight._x or field.shadowFlyMarker._x < field.foulMarkerLeft._x)
      {
         trace("it\'s a foul hit!");
         if(_parent.strikes < 2)
         {
            _parent.strikes++;
         }
         transitions.gotoAndPlay("foulHit");
         trace("PLAYING FOUL HIT******************************************************");
         ballInPlay = "foulHit";
         _parent.foulBeenHit = "yes";
         eval("field.fielder" + activeFielder).gotoAndStop("waiting");
         delete fielder_functionHolder.onEnterFrame;
      }
      eval("field.fielder" + activeFielder)._xscale = 60 - fld_distance / 50;
      eval("field.fielder" + activeFielder)._yscale = 60 - fld_distance / 50;
   };
};
fielderCatchChecker = function()
{
   fielder_functionHolder.onEnterFrame = function()
   {
      if(field.ballFly.ball._y >= -20)
      {
         trace("caughtIt");
         field.ballFly._visible = false;
         delete fielder_functionHolder.onEnterFrame;
         caughtOut();
         workOutFielderAngles();
         workOutThrowAngle();
         eval("field.fielder" + activeFielder).gotoAndStop(throwDirection);
      }
   };
};
workOutWhosOut = function()
{
   o = 1;
   while(o <= 18)
   {
      if(eval("_parent.batsman" + o + "_out") == "no")
      {
         if(throwTarget == "base1" and eval("_parent.potential_out" + o + "_runningTo") == "base1" and eval("_parent.potential_out" + o) == "yes")
         {
            runOut();
            activeFielder = 6;
         }
         if(throwTarget == "base2" and eval("_parent.potential_out" + o + "_runningTo") == "base2" and eval("_parent.potential_out" + o) == "yes")
         {
            runOut();
            activeFielder = 7;
         }
         if(throwTarget == "base3" and eval("_parent.potential_out" + o + "_runningTo") == "base3" and eval("_parent.potential_out" + o) == "yes")
         {
            runOut();
            activeFielder = 8;
         }
         if(throwTarget == "base4" and eval("_parent.potential_out" + o + "_runningTo") == "base4" and eval("_parent.potential_out" + o) == "yes")
         {
            runOut();
            activeFielder = 9;
         }
      }
      o++;
   }
   batsmanOutOfPlay = 0;
   c = 1;
   while(c <= 18)
   {
      trace("THIS IS THE POTENTIAL OUT = " + _parent["potential_out" + c + "_runningTo"]);
      if(_parent["potential_out" + c + "_runningTo"] == "none" or _parent["potential_out" + c + "_runningTo"] == "waiting")
      {
         batsmanOutOfPlay++;
         if(batsmanOutOfPlay == 18)
         {
            trace("the ball is out of play");
            ballInPlay = "no";
            trace("the ball is out of play" + ballInPlay);
            runToTarget_x = field.pitcherMoundMarker._x;
            runToTarget_y = field.pitcherMoundMarker._y;
            field.landSpot._x = field.pitcherMoundMarker._x;
            field.landSpot._y = field.pitcherMoundMarker._y;
            savedActiveFielder = activeFielder;
            activeFielder = 3;
            ballBounced = "no";
            btn_nextBall.gotoAndStop(2);
         }
      }
      c++;
   }
   checkBasesForOuts();
   if(_parent.base1_potential == "yes" or _parent.base2_potential == "yes" or _parent.base3_potential == "yes" or _parent.base4_potential == "yes")
   {
      workOutThrowAngle();
      eval("field.fielder" + activeFielder).gotoAndStop(throwDirection);
      trace("THERE\'S A POTENTIAL OUT - THROW THE BALL ON TO THIS BASE!----------" + closestBase);
   }
};
throwTheBall = function()
{
   throwSpeed = 2;
   throwDistance_x = eval("field.fielder" + activeFielder)._x - field.shadowFlyMarker._x;
   throwDistance_y = eval("field.fielder" + activeFielder)._y - field.shadowFlyMarker._y;
   theSum = throwDistance_x * throwDistance_x + throwDistance_y * throwDistance_y;
   hypotenuse = Math.sqrt(theSum);
   segments = hypotenuse / throwSpeed;
   xStep = throwDistance_x / segments;
   yStep = throwDistance_y / segments;
   delete ballFlyAwayField_functionHolder.onEnterFrame;
   field.ballFly._x = eval("field.fielder" + activeFielder)._x;
   field.ballFly._y = eval("field.fielder" + activeFielder)._y;
   field.ballFly.ball._y = -20;
   throw_functionHolder.onEnterFrame = function()
   {
      field.ballFly._x -= throwDistance_x / segments;
      field.ballFly._y -= throwDistance_y / segments;
      y_distanceFromBase = field.ballFly._y - field.startPointMarker._y;
      field.ballFly._xscale = 60 + y_distanceFromBase / 10;
      field.ballFly._yscale = 60 + y_distanceFromBase / 10;
      var _loc2_ = new flash.geom.Point(throwTarget_x,throwTarget_y);
      var _loc3_ = new flash.geom.Point(field.ballFly._x,field.ballFly._y);
      throwDistance = flash.geom.Point.distance(_loc2_,_loc3_);
      if(throwDistance < 10)
      {
         trace("reached its target");
         _root.ballCatch_1_field_sound.start();
         field.ballFly._visible = false;
         delete throw_functionHolder.onEnterFrame;
         ballReachedABase = "yes";
         if(throwTarget == "base1")
         {
            activeFielder = 6;
         }
         if(throwTarget == "base2")
         {
            activeFielder = 7;
         }
         if(throwTarget == "base3")
         {
            activeFielder = 8;
         }
         if(throwTarget == "base4")
         {
            activeFielder = 9;
         }
         workOutWhosOut();
      }
   };
};
checkBasesForOuts = function()
{
   trace("CHECKING BASES FOR POTENTIAL OUTS");
   p = 1;
   while(p <= 18)
   {
      p++;
   }
   i = 1;
   while(i <= 4)
   {
      var point_fielder = new flash.geom.Point(eval("field.fielder" + activeFielder)._x,eval("field.fielder" + activeFielder)._y);
      var point_base = new flash.geom.Point(eval("field.base" + i)._x,eval("field.base" + i)._y);
      field["distanceToBase" + i] = flash.geom.Point.distance(point_fielder,point_base);
      i++;
   }
   if(_parent.base1_potential != "yes")
   {
      field.distanceToBase1 += 5000;
      trace("should be taking base 1 out of the game now");
   }
   if(_parent.base2_potential != "yes")
   {
      field.distanceToBase2 += 5000;
      trace("should be taking base 2 out of the game now");
   }
   if(_parent.base3_potential != "yes")
   {
      field.distanceToBase3 += 5000;
      trace("should be taking base 3 out of the game now");
   }
   if(_parent.base4_potential != "yes")
   {
      field.distanceToBase4 += 5000;
      trace("should be taking base 4 out of the game now");
   }
   if(field.distanceToBase1 < field.distanceToBase2 and field.distanceToBase1 < field.distanceToBase3 and field.distanceToBase1 < field.distanceToBase4)
   {
      closestBase = "base1";
      throwTarget = "base1";
      throwTarget_x = field.base1._x;
      throwTarget_y = field.base1._y;
      trace("BASE 1 is the closes potential out");
   }
   if(field.distanceToBase2 < field.distanceToBase1 and field.distanceToBase2 < field.distanceToBase3 and field.distanceToBase2 < field.distanceToBase4)
   {
      closestBase = "base2";
      throwTarget = "base2";
      throwTarget_x = field.base2._x;
      throwTarget_y = field.base2._y;
      trace("BASE 2 is the closes potential out");
   }
   if(field.distanceToBase3 < field.distanceToBase1 and field.distanceToBase3 < field.distanceToBase2 and field.distanceToBase3 < field.distanceToBase4)
   {
      closestBase = "base3";
      throwTarget = "base3";
      throwTarget_x = field.base3._x;
      throwTarget_y = field.base3._y;
      trace("BASE 3 is the closes potential out");
   }
   if(field.distanceToBase4 < field.distanceToBase1 and field.distanceToBase4 < field.distanceToBase2 and field.distanceToBase4 < field.distanceToBase3)
   {
      closestBase = "base4";
      throwTarget = "base4";
      throwTarget_x = field.base4._x;
      throwTarget_y = field.base4._y;
      trace("BASE 4 is the closes potential out");
   }
   field.shadowFlyMarker._x = throwTarget_x;
   field.shadowFlyMarker._y = throwTarget_y;
};
workOutThrowAngle = function()
{
   throwDistance_x = eval("field.fielder" + activeFielder)._x - field.shadowFlyMarker._x;
   throwDistance_y = eval("field.fielder" + activeFielder)._y - field.shadowFlyMarker._y;
   firstCalc = throwDistance_x / throwDistance_y;
   throwAngle = Math.atan(firstCalc) / 0.017453292519943295;
   trace("this is the feckin throwAngle" + throwAngle);
   trace("now it\'s throwing, this is the shadowFlyMarker._x = " + field.shadowFlyMarker._x);
   trace("now it\'s throwing, this is the shadowFlyMarker._y = " + field.shadowFlyMarker._y);
   if(field.shadowFlyMarker._y > eval("field.fielder" + activeFielder)._y)
   {
      if(throwAngle >= -45 and throwAngle < 45)
      {
         throwDirection = "throwDown";
      }
      if(throwAngle >= 45 and throwAngle <= 90)
      {
         throwDirection = "throwRight";
      }
      if(throwAngle >= -90 and throwAngle <= -45)
      {
         throwDirection = "throwLeft";
      }
   }
   if(field.shadowFlyMarker._y < eval("field.fielder" + activeFielder)._y)
   {
      if(throwAngle >= -45 and throwAngle < 45)
      {
         throwDirection = "throwUp";
      }
      if(throwAngle >= 45 and throwAngle <= 90)
      {
         throwDirection = "throwLeft";
      }
      if(throwAngle >= -90 and throwAngle <= -45)
      {
         throwDirection = "throwRight";
      }
   }
   trace("throwDirection = " + throwDirection);
};
workOutFielderAngles = function()
{
   i = 1;
   while(i <= 4)
   {
      var point_fielder = new flash.geom.Point(eval("field.fielder" + activeFielder)._x,eval("field.fielder" + activeFielder)._y);
      var point_base = new flash.geom.Point(eval("field.base" + i)._x,eval("field.base" + i)._y);
      field["distanceToBase" + i] = flash.geom.Point.distance(point_fielder,point_base);
      if(_parent["base" + i + "_state"] != "empty")
      {
         field["distanceToBase" + i] += 5000;
      }
      i++;
   }
   if(field.distanceToBase1 < field.distanceToBase2 and field.distanceToBase1 < field.distanceToBase3 and field.distanceToBase1 < field.distanceToBase4)
   {
      closestBase = "base1";
      throwTarget = "base1";
      throwTarget_x = field.base1._x;
      throwTarget_y = field.base1._y;
   }
   if(field.distanceToBase2 < field.distanceToBase1 and field.distanceToBase2 < field.distanceToBase3 and field.distanceToBase2 < field.distanceToBase4)
   {
      closestBase = "base2";
      throwTarget = "base2";
      throwTarget_x = field.base2._x;
      throwTarget_y = field.base2._y;
   }
   if(field.distanceToBase3 < field.distanceToBase1 and field.distanceToBase3 < field.distanceToBase2 and field.distanceToBase3 < field.distanceToBase4)
   {
      closestBase = "base3";
      throwTarget = "base3";
      throwTarget_x = field.base3._x;
      throwTarget_y = field.base3._y;
   }
   if(field.distanceToBase4 < field.distanceToBase1 and field.distanceToBase4 < field.distanceToBase2 and field.distanceToBase4 < field.distanceToBase3)
   {
      closestBase = "base4";
      throwTarget = "base4";
      throwTarget_x = field.base4._x;
      throwTarget_y = field.base4._y;
   }
   checkBasesForOuts();
   trace("throwTarget = " + throwTarget);
   field.shadowFlyMarker._x = throwTarget_x;
   field.shadowFlyMarker._y = throwTarget_y;
   workOutThrowAngle();
   if(ballBounced == "yes")
   {
      field.ballFly._visible = false;
      trace("this is the fielderDirection == " + fielderDirection);
      if(fielderDirection == "goingLEFT" or fielderDirection == "goingUPLEFT" or fielderDirection == "goingDOWNLEFT")
      {
         eval("field.fielder" + activeFielder).gotoAndStop("pickLEFT");
      }
      if(fielderDirection == "goingRIGHT" or fielderDirection == "goingUPRIGHT" or fielderDirection == "goingDOWNRIGHT")
      {
         eval("field.fielder" + activeFielder).gotoAndStop("pickRIGHT");
      }
      if(fielderDirection == "goingUP")
      {
         eval("field.fielder" + activeFielder).gotoAndStop("pickUP");
      }
      if(fielderDirection == "goingDOWN")
      {
         eval("field.fielder" + activeFielder).gotoAndStop("pickDown");
      }
   }
};
stop();
