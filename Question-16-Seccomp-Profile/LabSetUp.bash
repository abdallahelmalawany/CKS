#!/bin/bash
# Places a custom seccomp profile under the kubelet's seccomp root and
# deploys a pod WITHOUT it applied yet, so you can practice wiring it up.
set -e

SECCOMP_ROOT="/var/lib/kubelet/seccomp"
mkdir -p "${SECCOMP_ROOT}/profiles"

cat <<'JSON' > "${SECCOMP_ROOT}/profiles/restrictive.json"
{
  "defaultAction": "SCMP_ACT_ERRNO",
  "architectures": ["SCMP_ARCH_X86_64"],
  "syscalls": [
    {
      "names": [
        "accept4","access","arch_prctl","bind","brk","clone","close",
        "connect","dup2","epoll_create1","epoll_ctl","epoll_wait","execve",
        "exit","exit_group","fcntl","fstat","futex","getcwd","getdents64",
        "getpid","getppid","gettid","listen","mmap","mprotect","munmap",
        "nanosleep","openat","poll","read","recvfrom","rt_sigaction",
        "rt_sigprocmask","sendto","set_robust_list","set_tid_address",
        "setsockopt","socket","stat","write"
      ],
      "action": "SCMP_ACT_ALLOW"
    }
  ]
}
JSON

cat <<'PODYAML' > ~/seccomp-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: seccomp-demo
  namespace: default
spec:
  # securityContext with seccompProfile intentionally omitted -- add it yourself
  containers:
  - name: app
    image: nginx:alpine
PODYAML

echo "[OK] Profile written to ${SECCOMP_ROOT}/profiles/restrictive.json"
echo "Unsecured pod manifest at ~/seccomp-pod.yaml -- wire up seccompProfile."
