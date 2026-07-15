# CKS Practice (Simple Edition)

Straightforward CKS (Certified Kubernetes Security Specialist) practice labs,
built from a personal exam-prep dump. Every question lives in its own folder
with bash files:

**Note:** This is a living repo and may still contain bugs or rough edges.
Some LabSetUp scripts simulate the scenario locally since the real exam gives
you a pre-broken cluster you never get to see the setup script for.

**Exam prep note:** These questions are designed to be similar to the CKS
exam, but they are not meant to be exact matches. Learn the underlying
concepts in depth and try different scenarios so you can solve variations
under exam conditions.

- `LabSetUp.bash` — set up the environment for the question (misconfigures
  something on purpose so you have a real problem to fix). Not every question
  has one — some rely on a ready-made Killercoda scenario instead (linked in
  `Questions.bash`).
- `Questions.bash` — the scenario text, task, and any reference links.
- `SolutionNotes.bash` — a step-by-step solution when you need a hint.
- `validate.bash` — automatic validation checks to confirm your solution is correct.
- `cleanup.bash` — clean up and remove resources created during the question.

---

## How to Use

1. Launch the [Killercoda CKS playground](https://killercoda.com/killer-shell-cks)
   or your own kubeadm cluster.
2. Clone this repo inside the environment:
   ```bash
   git clone <this-repo-url> ~/CKS-PREP-2025
   cd ~/CKS-PREP-2025
   ```
3. Run a question setup by number:
   ```bash
   scripts/run-question.sh 5
   ```
4. Work through the task, then consult `SolutionNotes.bash` if you need help.
5. Validate your solution:
   ```bash
   scripts/validate-question.sh 5
   ```
6. Clean up resources when done:
   ```bash
   scripts/cleanup-question.sh 5
   ```

---

## Validating Your Solutions

Each question has a `validate.bash` script that runs automated checks against
your cluster to confirm the solution is correct.

### Validate a single question
```bash
# By question number
scripts/validate-question.sh 5

# By directory name
scripts/validate-question.sh Question-5-Container-SecurityContext
```

### Validate all questions
```bash
scripts/validate-question.sh all
```

The script outputs `PASS` or `FAIL` for each check, with a final score
summary. Exit code is `0` if all checks pass, non-zero otherwise.

---

## Available Questions

| # | Topic | Killercoda scenario ready? |
|---|-------|------------------------------|
| 1 | Kubelet Hardening (anonymous-auth, authorization-mode, etcd client-cert-auth) | No — custom LabSetUp |
| 2 | TLS Secret for a Deployment | Yes |
| 3 | Dockerfile & Deployment security best practices | No — custom LabSetUp |
| 4 | Falco: detect pod accessing /dev/mem | No — custom LabSetUp |
| 5 | Container SecurityContext / Pod immutability | No — custom LabSetUp |
| 6 | Ingress TLS termination + HTTP→HTTPS redirect | Yes |
| 7 | ImagePolicyWebhook admission controller | Yes |
| 8 | kubeadm node upgrade | No — manual walkthrough only |
| 9 | Projected volume + ServiceAccount token | No — custom LabSetUp |
| 10 | API server audit logging | Yes |
| 11 | Docker daemon hardening | No — custom LabSetUp |
| 12 | SBOM generation with `bom` | No — custom LabSetUp |
| 13 | NetworkPolicy (deny-all + allow-from-namespace) | Partial — deny-all only |
| 14 | Istio mTLS (PeerAuthentication) | No — requires Istio installed |
| 15 | CIS Benchmark remediation (kube-bench) | No — custom LabSetUp |
| 16 | Seccomp profile on a Pod | No — custom LabSetUp |

---

## Notes to self

- Always confirm you're on the correct host before touching anything
  (`ssh cks0000XX` style exam warnings are real — wrong host = zero score).
- Static control-plane components (API server, etcd, controller-manager,
  scheduler) are **static pods** → edit the manifest in
  `/etc/kubernetes/manifests/`, save, and the kubelet restarts it automatically.
  Never `kubectl edit`/`kubectl patch` these.
- After any kubelet config change: `systemctl daemon-reload && systemctl restart kubelet`,
  then verify with `ps -ef | grep kubelet` (CLI flags can override config.yaml).
- Don't over-engineer NetworkPolicies — deny-all then allow exactly what's asked.
