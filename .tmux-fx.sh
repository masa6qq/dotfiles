#!/usr/bin/env python3
"""Shows USD/JPY, EUR/JPY and CHF/JPY with a sparkline of the last few days'
rates (one point per day) so day-over-day change is visible."""
import json
import os
import time
import urllib.request

STATE_FILE = os.path.expanduser("~/.cache/tmux-fx-history.json")
HISTORY_LEN = 3  # days
BLOCKS = "▁▂▃▄▅▆▇"  # skip the full block (█) so the tallest bar leaves headroom
PAIRS = ["usd_jpy", "eur_jpy", "chf_jpy"]


def load_state():
    try:
        with open(STATE_FILE) as f:
            return json.load(f)
    except Exception:
        return {"last_date": "", **{p: [] for p in PAIRS}}


def save_state(state):
    os.makedirs(os.path.dirname(STATE_FILE), exist_ok=True)
    with open(STATE_FILE, "w") as f:
        json.dump(state, f)


def fetch_rates():
    url = "https://api.exchangerate-api.com/v4/latest/EUR"
    with urllib.request.urlopen(url, timeout=5) as resp:
        data = json.load(resp)
    rates = data["rates"]
    usd_jpy = rates["JPY"] / rates["USD"]
    eur_jpy = rates["JPY"]
    chf_jpy = rates["JPY"] / rates["CHF"]
    return usd_jpy, eur_jpy, chf_jpy


def sparkline(values):
    if not values:
        return ""
    lo, hi = min(values), max(values)
    if hi == lo:
        return BLOCKS[0] * len(values)
    span = hi - lo
    return "".join(BLOCKS[int((v - lo) / span * (len(BLOCKS) - 1))] for v in values)


def main():
    state = load_state()
    today = time.strftime("%Y-%m-%d")

    if state.get("last_date") != today or any(not state.get(p) for p in PAIRS):
        try:
            usd_jpy, eur_jpy, chf_jpy = fetch_rates()
            for pair, value in zip(PAIRS, (usd_jpy, eur_jpy, chf_jpy)):
                state[pair] = (state.get(pair, []) + [value])[-HISTORY_LEN:]
            state["last_date"] = today
            save_state(state)
        except Exception:
            pass  # fall back to whatever is cached

    hists = {p: state.get(p, []) for p in PAIRS}

    if any(not h for h in hists.values()):
        print("FX N/A")
        return

    labels = {"usd_jpy": "USD/JPY", "eur_jpy": "EUR/JPY", "chf_jpy": "CHF/JPY"}
    print(
        " | ".join(
            f"{labels[p]} {hists[p][-1]:.2f} {sparkline(hists[p])}" for p in PAIRS
        )
    )


if __name__ == "__main__":
    main()
