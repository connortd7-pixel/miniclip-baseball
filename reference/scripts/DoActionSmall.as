fscommand("allowscale","false");
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
if(_parent.balls_left == 0)
{
   _parent._parent.points_total = _parent.points_total;
   _parent._parent.gotoAndStop("arcadeFinish");
}
setUpVariables = function()
{
   onScreen_ballsLeft.gotoAndStop(_parent.balls_left);
   ballAll._visible = false;
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
};
setUpVariables();
setUpColors = function()
{
   newSkinColor = new flash.geom.ColorTransform();
   newSkinColor = _parent.battingTeam_skin;
   savedSkinColor = newSkinColor;
   hitter.batsman.skinMovie.transform.colorTransform = savedSkinColor;
   newClothesColor = new flash.geom.ColorTransform();
   newClothesColor = _parent.battingTeam_clothes;
   savedClothesColor = newClothesColor;
   hitter.batsman.helmetMovie.transform.colorTransform = savedClothesColor;
   hitter.batsman.tShirtMovie.transform.colorTransform = savedClothesColor;
   savedBatLogo = _parent.savedBatLogo;
   hitter.batsman.batLogo.logo.gotoAndStop(savedBatLogo);
};
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
   var _loc2_;
   var _loc1_;
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
      hitterSwung = "yes";
      hitter.hitTester.gotoAndPlay(skillLevel);
      _loc2_ = new flash.geom.Point(aimCircle._x,aimCircle._y);
      _loc1_ = new flash.geom.Point(ballPassesBat_marker._x,ballPassesBat_marker._y);
      clickAccuracy = flash.geom.Point.distance(_loc2_,_loc1_);
      h = aimCircle._x - ballPassesBat_marker._x;
      v = aimCircle._y - ballPassesBat_marker._y;
      v_acc = v;
      if(v < 0)
      {
         v_acc = - v;
      }
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
   ballAll.ball.gotoAndPlay(2);
   _parent.balls_pitched++;
   _parent.balls_left--;
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
      trace("this is the frame the ball is on = " + b);
      if(b == i)
      {
         trace("it\'s a STRRRRRRRRRRRIIIIKE " + eval("strike" + _parent.strikes));
         trace("adding a strike here - ");
         _parent.strikes++;
         strikeAnim.gotoAndStop(["strike" + _parent.strikes]);
         delete ballPitch_functionHolder.onEnterFrame;
         btn_nextBall.gotoAndStop(2);
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
            _root.crowd_smallClap_sound.start();
         }
         if(hitQuality == "medium")
         {
            _root.batHit_medium_sound.start();
            _root.crowd_smallCheer_sound.start();
            _root.crowd_smallCheer_sound.start();
         }
         if(hitQuality == "good")
         {
            _root.batHit_good_sound.start();
            _root.crowd_smallCheer_sound.start();
         }
         delete ballPitch_functionHolder.onEnterFrame;
         fieldTimer.gotoAndPlay(2);
         hitYet = "yes";
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
         closest_distance = fielder_distance;
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
            if(scoreDistance2 <= 42 and scoreDistance2 > 11)
            {
               field.landMarker.ring3.gotoAndStop(2);
            }
            if(scoreDistance2 <= 10)
            {
               field.landMarker.ring4.gotoAndStop(2);
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
         }
         else if(hit_distance >= 820 and reachedTheWall != "yes" and ballInPlay != "foulHit" and field.ballFly.ball._y < -25)
         {
            trace("it\'s a home run!");
            _parent.wasTheLastBallHit = "homeRun";
            eval("field.fielder" + activeFielder).gotoAndStop("waiting");
            delete fielder_functionHolder.onEnterFrame;
            reachedTheWall = "yes";
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
stop();
