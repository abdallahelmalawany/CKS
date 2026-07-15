# Question:
# WARNING: You must connect to the correct host. Failure to do so may result
# in zero points. ssh cks000035
#
# Context: A Deployment "alpine" in namespace "alpine" has 3 containers
# running different Alpine image versions. One of them ships a vulnerable
# libcrypto3 version (3.1.4-r5).

#Task
# 1. Identify which of the 3 containers uses the vulnerable image.
# 2. Generate an SPDX SBOM report for that specific image using `bom`.
# 3. Remove ONLY that one container from the Deployment manifest and re-apply.

#Documentation Reference
# https://github.com/kubernetes-sigs/bom
