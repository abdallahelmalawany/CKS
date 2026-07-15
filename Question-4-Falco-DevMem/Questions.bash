# Question:
# WARNING: You must connect to the correct host. Failure to do so may result
# in zero points.
#
# Context: A misbehaving Pod is posing a security threat to the system.

#Task
# Identify the misbehaving Pod belonging to the "ollama" application that is
# directly accessing system memory by reading from the sensitive file
# /dev/mem.
# Scale down the Deployment of the identified misbehaving Pod to zero (0)
# replicas.
#
# Critical Constraints:
#   - Do NOT modify any other aspects of the Deployment.
#   - Do NOT alter any other Deployments.
#   - Do NOT delete any Deployments.
#
# Extended practice scenario: 3 pods (nvidia, cpu, ollama) are accessing
# /dev/mem. Detect this with Falco and scale down all offending Deployments
# to zero replicas.

#Documentation Reference
# https://falco.org/docs/rules/
