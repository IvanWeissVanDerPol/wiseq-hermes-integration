# DEPRECATED — `IvanWeissVanDerPol/wiseq-hermes-integration`

**Deprecated and archived on 2026-11-02.** This repository is no longer the source of truth for the WiseQ work, and it was never a working deployment.

Nothing in this repository should be copied, deployed, or cited. This file is the permanent record of *why*, and of the file-by-file classification that was made before the repository was archived.

---

## 1. The plain version

**This repository is DEPRECATED. It is no longer the source of truth.**

**It was never a working deployment.** The CI/CD workflow, nginx config, database seed and Grafana provisioning it references were never present in it, and the endpoints it points at do not resolve:

| Claim in this repository | Reality (verified 2026-11-02) |
|---|---|
| `.github/workflows/ci-cd.yml` (README + `REPO_STRUCTURE.md`) | No `.github/` directory exists. The file has never existed in any commit. |
| `docker-compose.yml` mounts `./nginx/nginx.conf`, `./nginx/ssl`, `./init.sql`, `./monitoring/grafana/provisioning` | None of those paths exist. `docker compose up` cannot start. |
| `WQ_API_BASE_URL=https://api.wiseq.nl` | NXDOMAIN — the host does not resolve. |
| `HERMES_DASHBOARD_URL=https://dashboard.hermes.ai` | NXDOMAIN — the host does not resolve. |
| Quickstart clones `github.com/aiw-org/wiseq-hermes-integration` | HTTP 404. The org does not exist. |
| "Complete integration of Wise Q educational audio technology" | WiseQ sells children's electronics (headphones, earbuds, tablets, chargers). "Educational audio technology" is not what this client does. |
| "Production Ready", "99.9% uptime", "<100ms response time", "40%+ cost savings" | Marketing claims with no measurement, no implementation and no counterpart anywhere. |

**Where the real work lives:**

| What | Where |
|---|---|
| The WiseQ implementation (executable, tested, Docker-verified) | **[`Ai-Whisperers/wiseq-hermes`](https://github.com/Ai-Whisperers/wiseq-hermes)** — the operational and code home |
| The consolidated public repo | **[`Ai-Whisperers/wiseq-ai-onboarding`](https://github.com/Ai-Whisperers/wiseq-ai-onboarding)** — as of 2026-11 the implementation is consolidated here under `ops/` (PR [#1](https://github.com/Ai-Whisperers/wiseq-ai-onboarding/pull/1)) |
| The private client corpus | **`Ai-Whisperers/sessions`** (private) — raw corpus, digests and internal analysis |

**Nothing was imported from this repository.** A file-by-file comparison against the authoritative repositories found **no unique content**: every file here is either a duplicate of functionality that already exists — and works — in `Ai-Whisperers/wiseq-hermes`, or it documents and configures infrastructure that never existed. See the classification table in §4.

**This repository was archived, not deleted.** Its full history stays readable at the same URL, so old links still resolve and now explain themselves.

---

## 2. What was actually checked

- Full tree read at `007bfcd` (the default branch `main`, 4 commits, 15 files, 86,377 bytes). Every file was read in full, not sampled.
- History walked (`git log --all --diff-filter=A`) to confirm no file was ever added and later deleted — the tree is exactly the 15 files above, and `.github/` and `.gitignore` never existed in any commit.
- Only branch, tag, release, PR and issue on the repository: `main`; no tags, no releases, no PRs, no issues. No hidden content.
- Every cross-reference checked against the working tree: `nginx/nginx.conf`, `nginx/ssl`, `init.sql`, `monitoring/grafana/provisioning`, `tests/`, `.pre-commit-config.yaml`, and the 21 documentation files linked from `README.md` (10) and `website/README.md` (11) — none exist.
- DNS: `api.wiseq.nl`, `dashboard.hermes.ai`, `docs.wiseq.nl`, `community.wiseq.nl` — all NXDOMAIN.
- HTTP: `github.com/aiw-org/wiseq-hermes-integration` — 404.
- Each claim compared against `Ai-Whisperers/wiseq-hermes` (now `Ai-Whisperers/wiseq-ai-onboarding` → `ops/`) and against the consolidated repo's docs, tests and validators.

---

## 3. Verdict

This repository is a **fabricated scaffold**, not a deployment. It was a plausible-looking FastAPI/Docker/Kubernetes/Prometheus/Grafana skeleton whose documentation, compose file and setup script all point at files and services that were never created, and whose business content (pricing tiers, market figures, model-routing table, support chatbot) is invented and, in the case of the pricing tiers, directly contradicts the authoritative business rules.

The one real implementation of the WiseQ operations model is `Ai-Whisperers/wiseq-hermes`, which is consolidated into `Ai-Whisperers/wiseq-ai-onboarding` under `ops/`. This repository adds nothing to it.

---

## 4. Per-file inventory and classification

15 files, 86,377 bytes total. Classification:

- **DUPLICATE** — the same functionality already exists in the authoritative repo (`Ai-Whisperers/wiseq-hermes`, consolidated under `ops/`).
- **UNIQUE** — content that exists nowhere else and would be lost. **Count: 0.**
- **FABRICATED** — documents or config for files/systems that do not exist.

| # | Path | Bytes | What it claims to be | Class | Reasoning |
|---|---|---|---|---|---|
| 1 | `README.md` | 12,503 | Project front door: architecture, features, quickstart, deployment, testing, roadmap | **FABRICATED** | Documents `.github/workflows/ci-cd.yml` and 10 documentation files that do not exist (`IMPLEMENTATION_GUIDE.md`, `COMPLETE_ENHANCEMENT_PLAN.md`, `EXECUTIVE_SUMMARY.md`, `docs/api-reference.md`, `docs/architecture.md`, `docs/security.md`, `docs/monitoring.md`, `docs/quick-start.md`, `docs/admin-guide.md`, `docs/troubleshooting.md`). Quickstart clones a 404 URL. Endpoints do not resolve. Misdescribes the client as "educational audio technology". Unmeasured success metrics. |
| 2 | `REPO_STRUCTURE.md` | 4,709 | "The complete structure" of the repository | **FABRICATED** | Claims `.github/workflows/ci-cd.yml` (7,445 chars) and `.gitignore` (1,958 chars). Neither has ever existed in any commit. Omits `index.html`, `requirements.txt` and the setup script while listing a `website/` that contains one README. |
| 3 | `wiseq-hermes-integration.py` | 26,449 | FastAPI orchestrator: auto-routing, B2B pricing, market research, support chatbot | **FABRICATED** | Same function is served authoritatively by `ops/src/wiseq/` (`api.py` with 32 routes, `api_auth.py`, `api_rbac.py`, `orchestrator.py`, 13 files under `agents/` (11 agent modules + `base.py` + `__init__.py`), `domain/shipping.py`, `agents/school_orders.py`, `agents/reviews.py`). Every piece of business content in it is invented: an 4-tier student pricing ladder with fabricated base prices and "Dutch market adjustments" (€50/€150/€300/€500, 1.2/1.1/1.0/0.9 multipliers, a 15% back-to-school multiplier) — the authoritative repo explicitly refuses to publish such tiers (`ops/.env.example` pins `WISEQ_SCHOOL_DISCOUNT_PCT=0` and `ops/tests/test_no_default_discount.py`, `test_school_discount_honesty.py`, `test_attrition_is_not_a_discount.py` guard it); hardcoded market data ("€2.5 billion", "12.5%", "MBO21 / ROC van Amsterdam / ROC Mondriaan" as key players) that appears in no authoritative findings document; a routing table (`glm-4.5-flash` / `hermes-4-70b` / `minimax-m3` with made-up cost-per-token) that contradicts the real Jev/OpenRouter grid documented in `docs/40-build/03-aiw-reuse.md`; a support chatbot that only ever returns canned template strings. It also cannot run: `execute_with_hooks(lambda: result, task, context)` passes 3 positional args to a 0-argument lambda (TypeError on every task), `uvicorn.run("wiseq-hermes-integration:app")` names a module that is not importable (hyphens), and `logging.FileHandler('/app/logs/…')` opens a directory the image never creates. |
| 4 | `setup-wiseq-hermes-integration.sh` | 7,545 | One-command automated setup and deployment | **FABRICATED** | Runs `python -m pytest tests/` but there is no `tests/` directory, and `set -e` aborts the script at that step before anything is deployed. `setup_database()` is a comment ("This would normally involve running database migrations"). Creates `monitoring/grafana/provisioning` for a Grafana that is never configured. The real equivalents are `ops/scripts/run_local.sh`, `ops/scripts/verify_all.sh` and `lab/setup.sh`. |
| 5 | `docker-compose.yml` | 2,613 | Six-service stack: app, Postgres, Redis, Prometheus, Grafana, nginx | **FABRICATED** | Binds `./init.sql`, `./nginx/nginx.conf`, `./nginx/ssl`, `./monitoring/grafana/provisioning` — none exist, so the stack cannot start. The authoritative, working equivalent is `ops/docker-compose.yml`. |
| 6 | `Dockerfile` | 855 | Container image for the app | **DUPLICATE** | Same function as `ops/Dockerfile` (Python slim, non-root user, `/health` check), which is the one that actually builds and runs. This variant is broken: it runs `python wiseq-hermes-integration.py`, which crashes on import because `logging.FileHandler('/app/logs/wiseq-hermes.log')` targets a directory the image never creates, and whose `uvicorn.run()` module string is not importable. |
| 7 | `requirements.txt` | 844 | Python dependencies | **FABRICATED** | 49 pins, of which the code imports roughly six (`fastapi`, `uvicorn`, `pydantic`, `requests`, `httpx` + stdlib). The rest configure systems that do not exist: `kubernetes`, `boto3`, `azure-storage-blob`, `google-cloud-storage`, `docker`, `celery`, `flask`, `gunicorn`, `redis`, `sqlalchemy`, `prometheus-client`, `sentry-sdk`, `slack-sdk`, `matplotlib`, `seaborn`, `plotly`, `pandas`, `numpy`, `scikit-learn`, `typer`, `click`, `rich`, `structlog`, `passlib`, `bcrypt`, `pyjwt`, `cryptography`, `jinja2`, `aiofiles`, `websockets`, `pre-commit`… The authoritative manifest is `ops/pyproject.toml`. |
| 8 | `.env.example` | 1,710 | Environment variable template | **FABRICATED** | Points at `https://api.wiseq.nl` and `https://dashboard.hermes.ai` (both NXDOMAIN) and configures services that were never deployed: Redis, Grafana, Prometheus, Jaeger, ELK, Sentry, Slack, an API gateway, SSL certs at `/etc/ssl/certs/wiseq.crt`, daily encrypted multi-cloud backups. No real credential values — all placeholders. The authoritative template is `ops/.env.example`. |
| 9 | `k8s/deployment.yaml` | 2,640 | Kubernetes Deployment + Service + Ingress + HPA | **FABRICATED** | Deploys image `wiseq-hermes-integration:latest`, which was never built or pushed to any registry; ingress host `wiseq-hermes.example.com` is an RFC 2606 placeholder; `cert-manager.io/cluster-issuer: letsencrypt-prod`, `imagePullSecrets: docker-registry-secret` and the `wiseq-production` namespace all describe infrastructure that does not exist. The authoritative repo has no Kubernetes manifests at all and deploys by Docker Compose. |
| 10 | `k8s/namespace-config.yaml` | 2,519 | Namespace, Secret, ConfigMap, ServiceAccount, RBAC, PVCs | **FABRICATED** | The Secret value `wq-api-key: eW91cl...cmU=` is not valid base64 — it is a truncated placeholder that `kubectl` would reject. The ConfigMap points at `dashboard.hermes.ai`. Four PVCs provision Postgres, Redis, logs and backups for a Kubernetes deployment that never existed. |
| 11 | `monitoring/prometheus.yml` | 598 | Prometheus scrape configuration | **FABRICATED** | Scrapes `wiseq-hermes:8000/metrics`, but that endpoint returns a JSON object, not Prometheus exposition format, so the scrape could never succeed. Also scrapes `node-exporter:9100` and `redis:6379`, neither of which exists in the compose file. The authoritative repo ships no Prometheus configuration. |
| 12 | `monitoring/alert_rules.yml` | 2,479 | Eight Prometheus alert rules | **FABRICATED** | Every rule fires on metrics no code in this repository ever emits (`http_requests_total`, `http_request_duration_seconds_bucket`, `sql_errors_total`, `redis_connections_errors_total`, `node_cpu_seconds_total`). The `/metrics` handler returns four hardcoded constants. |
| 13 | `website/README.md` | 4,293 | Documentation for a demo website | **FABRICATED** | Links 11 documentation pages that do not exist (`docs/authentication.md`, `docs/endpoints.md`, `docs/webhooks.md`, `docs/errors.md`, `docs/school-integration.md`, `docs/api-integration.md`, `docs/custom-development.md`, `docs/deployment/{docker,kubernetes,cloud}.md`, `docs/troubleshooting.md`) and describes a "React with TypeScript" frontend that does not exist in the repository. `website/` contains this README and nothing else. |
| 14 | `index.html` | 15,540 | Static landing page with a live demo | **FABRICATED** | A marketing page for a service that never ran: fake pricing calculator (`studentCount × 0.5/0.6/0.8`), a simulated "Processing Task…" progress bar with a fabricated €0.05 cost and a hardcoded `Hermes-4-70b` "model selected", a "Production Ready" badge, and unmeasured "99.9% uptime / <100ms / 40%+ cost savings" statistics. It contains no real WiseQ fact, and publishing it would put false claims into a repository that has a claims ledger and a validator check for retracted claims (`scripts/validate_repo.py` check 8). |
| 15 | `LICENSE` | 1,080 | MIT license | **DUPLICATE** | Same MIT grant as `ops/LICENSE`, which additionally records the engagement context and the no-warranty position. |

### Counts

| Class | Files | Bytes |
|---|---|---|
| DUPLICATE | 2 | 1,935 |
| UNIQUE | **0** | **0** |
| FABRICATED | 13 | 84,442 |

---

## 5. Why nothing was imported

Every file was matched against the authoritative repositories by function, not by filename:

| Claim here | Authoritative equivalent |
|---|---|
| FastAPI service + auth + RBAC | `ops/src/wiseq/api.py`, `ops/src/wiseq/api_auth.py`, `ops/src/wiseq/api_rbac.py` |
| Agent orchestration, approvals gate, audit log | `ops/src/wiseq/orchestrator.py`, `ops/src/wiseq/agents/base.py` (`request_approval`, `audit`) |
| B2B / school pricing | `ops/src/wiseq/agents/school_orders.py`, `ops/src/wiseq/agents/bundles.py`, `ops/docs/client-knowledge/13-pricing-and-roi-calculator.md` |
| Customer support / reviews | `ops/src/wiseq/agents/reviews.py`, `ops/src/wiseq/connectors/mail.py`, `ops/src/wiseq/agents/warranty_policy.py` |
| Market research | `ops/docs/MARKET-AND-PROCUREMENT-FINDINGS.md`, `ops/docs/PUBLIC-DATA-FINDINGS.md`, `ops/scripts/audit_public_site.py`, `ops/scripts/build_public_snapshot.py` |
| Auto-routing / model selection | the live Jev router, documented in `docs/40-build/03-aiw-reuse.md` |
| Docker / Compose deployment | `ops/Dockerfile`, `ops/docker-compose.yml`, `ops/docs/DOCKER-VERIFICATION.md` |
| Local setup + verification | `ops/scripts/run_local.sh`, `ops/scripts/verify_all.sh`, `lab/setup.sh` |
| Demo for the client | `ops/scripts/demo_for_rob.py`, `lab/` |
| Environment template | `ops/.env.example` |

There was nothing left over: no unique document, no unique configuration, no unique business rule, no unique data. The only content unique to this repository is content that describes systems which do not exist. Importing it — even as "archival reference" — would have added fake endpoints, fake pricing tiers, fake market figures and a non-functional Kubernetes/Prometheus/Grafana stack to the one repository that is meant to be the verified public record. So nothing was imported, and no `ops/docs/legacy-integration-repo/` directory was created.

The content is not lost: this repository is archived rather than deleted, so all 15 files and the full commit history remain readable at the same URL.

---

## 6. Related

- Migration plan: §G step 8 and §B5 of `09-repository-map.md` in the private `Ai-Whisperers/sessions` corpus.
- Consolidated public repo: `Ai-Whisperers/wiseq-ai-onboarding` — implementation under `ops/` (PR #1).
- Authoritative implementation: `Ai-Whisperers/wiseq-hermes`.
