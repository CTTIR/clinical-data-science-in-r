#!/usr/bin/env python3
"""Require execution records for every teaching chapter after a cache-free render."""
from pathlib import Path
import hashlib
import json

root = Path(__file__).resolve().parents[1]
chapters = sorted((root / "chapters").glob("b[0-9][0-9]-*.qmd"))
if len(chapters) != 28:
    raise SystemExit("Expected all 28 numbered teaching chapters")
records = []
for chapter in chapters:
    result = root / "_freeze" / "chapters" / chapter.stem / "execute-results" / "html.json"
    if not result.is_file():
        raise SystemExit(f"Missing execution record: {chapter.name}")
    payload = json.loads(result.read_text())
    if payload.get("result", {}).get("engine") != "knitr":
        raise SystemExit(f"Unexpected execution engine: {chapter.name}")
    records.append({"chapter": chapter.name,
                    "source_sha256": hashlib.sha256(chapter.read_bytes()).hexdigest(),
                    "result_sha256": hashlib.sha256(result.read_bytes()).hexdigest()})
out = root / "lab-evidence"
out.mkdir(exist_ok=True)
(out / "chapter-execution.json").write_text(json.dumps(records, indent=2) + "\n")
print(f"Verified {len(records)} fresh chapter execution records.")
