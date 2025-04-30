##  Project Overview

This repository contains a complete optimization workflow that couples **MATLAB** with **Lumerical FDTD** to design and fine-tune nanophotonic structures. It uses a **multi-objective genetic algorithm** (`gamultiobj`) to optimize geometric parameters—such as silicon layer thickness, ring resonator dimensions, and periodicity—to **minimize propagation losses** in dual-polarized optical simulations.

---

### What This Project Does

The code interfaces directly with Lumerical using its MATLAB API to:

-  **Modify** simulation parameters dynamically (e.g. radii, gaps, heights)
- **Run** electromagnetic simulations using Lumerical FDTD
- **Extract** electric field data and compute a figure of merit based on **FWHM**
- **Store** optimized results into a text log for further analysis

---

### Ideal For

This setup is ideal for:

- **Silicon photonics research**
- **Metasurface or optical waveguide design**
- **Simulation-driven geometry optimization**
- Projects requiring **polarization-aware, multi-parameter tuning**

---
## Project Structure

- `optimizer_lum_mix.m` – Main optimization function using dual-polarization runs.
- `optimizer_lum.m` – Sub-function that modifies simulation parameters, runs Lumerical, and extracts figures of merit (FWHM-based loss).
- `results.txt` – Appended file storing results from successful optimization runs.
- `test1_b.fsp` – Lumerical FDTD project file containing the base simulation setup.
- `main_script.m` – Initializes the MATLAB-Lumerical API, retrieves initial parameters, and runs the optimizer.

---

##  Requirements

- **MATLAB** (Tested with R2021+)
- **Lumerical FDTD Solutions** (v202 or compatible)
- MATLAB API for Lumerical installed and path added:
---

##  How to Run

1. Clone this repository:
 ```bash
 git clone https://github.com/yourusername/lumerical-optimizer.git
 cd lumerical-optimizer
```

2. Open MATLAB, set your working directory to the repo folder.

3. Make sure your Lumerical FDTD file path is correctly set in main_script.m:
4. Run the main script
---
## Optimization Details
Variables Optimized:

- Silicon height, breadth

- Inner/outer radii of concentric rings

- Gap between features

- Rect width, periodicity, etc.
---
## Notes
This setup assumes you have a valid .fsp file with named structures/monitors (structure_group, monitor_2, etc.).

Lumerical must be installed and licensed on the same machine.

Consider parallelizing for speed: set `UseParallel` in `optimoptions`

## License
This project is licensed under the GNU General Public License v3.0 – see the `LICENSE` file for details.
You are free to use, modify, and distribute this code, but derivative works must remain open-source and patent use is restricted.
