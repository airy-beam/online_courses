#!/usr/bin/env python

# **************************************************
# Set up initial conditions
# **************************************************

N0 = 1000.0     # Initial population size

rate_A = 1.2    # Growth rate allele "A"
rate_a = 1.2    # Growth rate allele "a"

fA = 0.3        # Frequency of allele "A"

max_gen = 20    # Number of generations to simulate


# **************************************************
# Calculate derived variables
# **************************************************

fa = 1.0 - fA    # Calculate frequency of allele "a"

NA_0 = N0 * fA   # Initial population size of allele "A"
Na_0 = N0 * fa   # Initial population size of allele "a" 


# **************************************************
# Run simulation
# **************************************************

print ("%4s %12s %12s %12s %12s %12s" % ("#t","Nt","A pop", "a pop", "A freq", "a freq"))

for t in range(max_gen+1):
        NA_t = NA_0 * (rate_A ** t) 
        Na_t = Na_0 * (rate_a ** t)
        Nt = NA_t + Na_t
        if Nt < 1:
                print ("#The organism is now extinct - how sad...")
                break
        fA_t = NA_t / Nt
        fa_t = Na_t / Nt
        
        # Output format - "%i" : integer (rounded) - "%f" : floating point  
        print ("%4i %12i %12i %12d %12f %12f" % (t,Nt,NA_t,Na_t,fA_t,fa_t))
