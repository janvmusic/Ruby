require 'test/unit'
require_relative '../lib/controller/gothons'

class MyUnitTests < Test::Unit::TestCase

	def testRoom()
		gold = GothonRoom.new("GoldRoom",
                %q{
                	This room has gold in it you can grab.
                	There's a door to the north.
                })
		assert_equal(gold.name,"GoldRoom")
		assert_equal(gold.paths,{})
	end

	def testRoomPaths()
		center = GothonRoom.new("Center","Test room in the center")
		north = GothonRoom.new("North","Test room in the north")
		south = GothonRoom.new("South","Test room in the south")

		center.addPaths({:north => north,:south => south})
		assert_equal(center.go(:north),north)
		assert_equal(center.go(:south),south)
	end

	def testMap()
		start = GothonRoom.new("Start","You can go west and down a hole")
		west = GothonRoom.new("Trees","There're trees here, you can go east")
		down = GothonRoom.new("Dungeon","It's down right here, you can go up")

		start.addPaths({:west => west,:down => down})
		west.addPaths({:east => start})
		down.addPaths({:up => start})

		assert_equal(start.go(:west),west)
		assert_equal(start.go(:west).go(:east),start)
		assert_equal(start.go(:down).go(:up),start)
	end

	def testGothonGameMap()
		start = GOTHONSTART

		assert_equal(start.go('shoot'),start.getDeathRoom())
		assert_equal(start.go('dodge'),start.getDeathRoom())

		room = start.go('joke')
		assert_equal(room.name,"Laser Weapon Armory")
	end

	def testMessage()
		start = GothonRoom.new("Start","Test for this room")
		shoot = %q{
	Quick on the draw you yank out your blaster and fire it at the Gothon.
	His clown costume is flowing and moving around his body, which throws
	off your aim. Your laser hits his costume but misses him entirely. This
	completely ruins his brand new costume his mother bought him, which
	makes him fly into an insane rage and blast you repeatedly in the face until
	you are dead. Then he eats you.
}

		assert_equal(start.setMessage('shoot'),shoot)
	end

	def testGetRoomHint()
		start = GothonRoom.new("Central Corridor","Test for this room")
		centralCorridorHint = "Maybe you could say something funny!"
		laserWeaponHint = "I'm gonna give you one more number: " 
		theBridgeHint = " Don't move that bomb rapidly, be easy, it might explode in any second"
		escapePodHint = "Seems that the number 3 is broken! be careful"
		theEndHint = "You won! Congratulations!"
		wrongHint = "Woah! I won't give you a hint! You cheater!"

		assert_equal(start.getRoomHint(start.name),centralCorridorHint)
		assert_equal(start.getRoomHint("The Bridge"),theBridgeHint)
		assert_equal(start.getRoomHint("Escape Pod"),escapePodHint)
		assert_equal(start.getRoomHint("The End"),theEndHint)
		assert_equal(start.getRoomHint("wrongHint"),wrongHint)
	end

	def testGetStartRoom()
		start = GothonRoom.new("Central Corridor","Test for this room")
		assert_equal(start.getStartRoom(),GOTHONSTART)
	end

	def testGetDeathRoom()
		start = GothonRoom.new("Central Corridor","Test for this room")
		assert_equal(start.getDeathRoom(),DEATH)
	end

	def testGetEndRoom()
		start = GothonRoom.new("Central Corridor","Test for this room")
		assert_equal(start.getEndRoom(),"The End")
	end
end