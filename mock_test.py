import spynnaker_mock as sim

sim.setup()

pop1 = sim.population()
pop2 = sim.population()
pro1 = sim.projection()

sim.run()

sim.end()
