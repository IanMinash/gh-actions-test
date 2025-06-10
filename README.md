# CI/CD with Github Actions Test Project

This project is designed to serve as a testbed for implementing Continuous Integration and Continuous Deployment (CI/CD) pipelines using Github Actions.

It contains two distinct sub-projects:

1.  **`python/`**: This directory contains a simple Flask web application.
    *   The main application code is in `main.py`.
    *   Tests for the application are located in the `tests/` subdirectory.
    *   Dependencies are listed in `requirements.txt`.

2.  **`javascript/`**: This directory contains a basic TypeScript script.
    *   The main script code is in `index.ts`.
    *   Tests for the script are located in the `tests/` subdirectory and are run using Jest.
    *   Dependencies and scripts are managed via `package.json`.

**Task for Students:**

Your task is to create Github Actions workflows (`.github/workflows/`) for each of these sub-projects. Each workflow should, at a minimum:

*   Checkout the code.
*   Set up the appropriate environment (Python for the Flask app, Node.js/TypeScript for the JavaScript script).
*   Install dependencies.
*   Run the tests for that specific sub-project.

You can expand upon this by adding linting, formatting checks, or even simple deployment steps if desired.