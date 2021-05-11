require("chai").should();

const ZombieFactory = artifacts.require("ZombieFactory");

contract("ZombieFactory", function ([admin, registeredUser, unregistered]) {
	beforeEach(async () => {
		this.ZombieFactory = await ZombieFactory.new();
	});

	describe("Creating Zombie", () => {
		it("should create a new zombie from a name", async () => {
			await this.ZombieFactory.createRandomZombie("Michel");

			firstZombie = await this.ZombieFactory.zombies.call([0]);
			firstZombie.name.should.equal("Michel");
		});
	});
});
