# Dockerfile fix -- only change the USER line, nothing else:
#   USER nobody
# (If a UID line exists separately, set it to 65535.)

# Deployment fix -- pick the ONE misconfigured field under securityContext:
#   capabilities                        -> drop the dangerous one
#   privileged: true                    -> privileged: false
#   allowPrivilegeEscalation: true      -> allowPrivilegeEscalation: false
#   readOnlyRootFilesystem: false       -> readOnlyRootFilesystem: true
#   runAsUser: 0                        -> runAsUser: 65535
#   runAsNonRoot: false                 -> runAsNonRoot: true
#
# Most common real-exam answer: runAsUser: 0 -> 65535, or privileged: true -> false.
# Only touch the ONE field that's actually wrong.

# Do NOT build the Dockerfile (docker build) -- risk of filling exam disk = zero score.
