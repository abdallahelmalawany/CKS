# Question:
# Harden Docker by removing risky group access and securing the socket.

#Task
# 1. Remove the "developer" user from the docker group (root-equivalent access).
# 2. Fix ownership of /var/run/docker.sock to root:root.
# 3. Ensure Docker only listens on the local unix socket -- no TCP exposure.

#Documentation Reference
# https://docs.docker.com/engine/security/#docker-daemon-attack-surface
