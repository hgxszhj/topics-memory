# Coding Standards and Best Practices

*   **StrongDM Attractor Principles:** Adopt non-interactive development principles where specifications and scenarios drive agents to write code automatically without human review.
*   **Scenario-Driven Validation:** Use end-to-end "user stories" (scenarios) stored outside the codebase for more intuitive and flexible validation by LLMs, rather than traditional unit tests.
*   **Satisfaction Metrics:** Quantify validation success probabilistically - measure what fraction of observed trajectories through scenarios likely satisfy the user, instead of boolean pass/fail tests.
*   **Digital Twin Universe (DTU):** Create behavioral clones of third-party services for safe, high-volume, high-rate validation without hitting production limits or API costs.
*   **Test Evolution:** Move from simple unit tests to comprehensive integration tests, regression tests, end-to-end tests, and behavior tests to prevent reward hacking by AI agents.
