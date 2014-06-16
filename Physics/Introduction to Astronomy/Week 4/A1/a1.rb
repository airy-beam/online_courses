luminositySun = 3.83e26
massCore = 0.4 * 1.9891e30
burnTimeSeconds = 4.5e9 * 365.2564 * 24 * 60 * 60
heFusionEnergy = 4.3e-12
alphaParticleMass = 6.64e-27
heAtomsCreated = luminositySun / heFusionEnergy * burnTimeSeconds

print "He Atoms Created = ", heAtomsCreated, "\n"

heMassCreated = heAtomsCreated * alphaParticleMass

print "He Mass Created = ", heMassCreated, "\n"

newHeRatio = heMassCreated / massCore

print "Fraction of New He = ", newHeRatio, "\n"

print "Total Helium in Core = ", (0.27 + newHeRatio), "\n"