require("chai").should();

const { expectRevert } = require("@openzeppelin/test-helpers");

const ZombieFactory = artifacts.require("ZombieFactory");

contract("ZombieFactory", function ([user0]) {
	beforeEach(async () => {
		this.ZombieFactory = await ZombieFactory.new();
	});

	describe("Creating Zombie", () => {
		it("should create a new zombie from a name", async () => {
			await this.ZombieFactory.createRandomZombie("Michel");

			firstZombie = await this.ZombieFactory.zombies.call([0]);
			firstZombie.name.should.equal("Michel");
		});

		it("should revert when a user tries to create 2 zombies", async () => {
			await this.ZombieFactory.createRandomZombie("Michel", { from: user0 });

			await expectRevert(
				this.ZombieFactory.createRandomZombie("Jacques", { from: user0 }),
				"A user can only call this function once."
			);
		});
	});
});
