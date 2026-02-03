<div align="center">

<img src="img/logo.png" alt="AutoFigure Logo" width="100%"/>


# AutoFigure: Generating and Refining Publication-Ready Scientific Illustrations [ICLR 2026]

[![ICLR 2026](https://img.shields.io/badge/ICLR-2026-blue?style=for-the-badge&logo=openreview)](https://openreview.net/forum?id=5N3z9JQJKq)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Python](https://img.shields.io/badge/Python-3.8%2B-blue?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![HuggingFace](https://img.shields.io/badge/%F0%9F%A4%97%20HuggingFace-FigureBench-orange?style=for-the-badge)](https://huggingface.co/datasets/WestlakeNLP/FigureBench)

<p align="center">
  <strong>From Text to Publication-Ready Diagrams</strong><br>
  AutoFigure is an intelligent system that leverages Large Language Models (LLMs) with iterative refinement to generate high-quality scientific figures from text descriptions or research papers.
</p>

[Quick Start](#-quick-start) • [Web Interface](#-web-interface) • [FigureBench](#-figurebench-dataset) • [Citation](#-citation)

</div>

---

## ✨ Features

| Feature | Description |
| :--- | :--- |
| 📝 **Text-to-Figure** | Generate figures directly from natural language descriptions. |
| 📄 **Paper-to-Figure** | Extract methodology from PDFs and create visual diagrams automatically. |
| 🔄 **Iterative Refinement** | Dual-agent system (Generation + Evaluation) for continuous quality optimization. |
| 🎨 **Multiple Formats** | Output as **SVG** or **mxGraph XML** (fully compatible with draw.io). |
| 💅 **Image Enhancement** | Optional AI-powered post-processing for aesthetic beautification. |
| 🖥️ **Web Interface** | Interactive Next.js frontend for easy generation and editing. |

---

## 🚀 How It Works

AutoFigure employs a **Review-Refine** loop to ensure high accuracy and aesthetic quality.

<div align="center">
<img src="img/method.png" alt="AutoFigure method" width="1000"/>
</div>

> **Process:**
> 1. **Generate:** The agent creates initial SVG/XML based on description & references.
> 2. **Evaluate:** The critic scores quality (0-10) and provides specific feedback.
> 3. **Refine:** The loop continues until the figure meets publication standards.

---

## ⚡ Quick Start

### Option 1: Python SDK (Recommended)

<details>
<summary><strong>Click to view Installation Steps</strong></summary>

```bash
# 1. Clone the repository
git clone https://github.com/ResearAI/AutoFigure.git
cd AutoFigure

# 2. Install dependencies & package
pip install -r requirements.txt
pip install -e .

# 3. Install Playwright (required for rendering)
playwright install chromium
```
</details>

**Basic Usage:**

```python
from autofigure import AutoFigureAgent, Config

# 1. Configure
config = Config(
    generation_api_key="your-api-key",
    generation_provider="openrouter",  # options: 'openrouter', 'gemini', 'bianxie'
)

# 2. Generate
agent = AutoFigureAgent(config)
result = agent.generate(
    description="A flowchart showing transformer training pipeline",
    max_iterations=5,
    output_format="svg"
)

print(f"✅ Generated: {result.svg_path} (Score: {result.final_score}/10)")
```

### Option 2: Web Interface

Ideally suited for visual interaction and editing.

```bash
./start.sh
# Then open http://localhost:6002 in your browser
```

---

## 📊 FigureBench Dataset

We introduce **FigureBench**, the first large-scale benchmark for generating scientific illustrations from long-form text.

<div align="center">
<img src="img/figurebench.png" alt="figurebench" width="1000"/>
</div>

### Dataset Overview

| Category | Samples | Avg. Tokens | Text Density | Complexity |
|:---|:---:|:---:|:---:|:---:|
| 📄 **Paper** | 3,200 | 12,732 | 42.1% | High |
| 📝 **Blog** | 20 | 4,047 | 46.0% | Med |
| 📊 **Survey** | 40 | 2,179 | 43.8% | High |
| 📘 **Textbook** | 40 | 352 | 25.0% | Low |
| **Total** | **3,300** | **10k+** | **41.2%** | **~5.3 Components** |

### Download
<div align="left">
  <a href="https://huggingface.co/datasets/WestlakeNLP/FigureBench">
    <img src="https://img.shields.io/badge/%F0%9F%A4%97%20Download%20on%20HuggingFace-FFD21E?style=for-the-badge&logoColor=black" alt="Download">
  </a>
</div>

```python
from datasets import load_dataset
dataset = load_dataset("WestlakeNLP/FigureBench")
```

---

## ⚙️ Configuration

### Supported LLM Providers

| Provider | Base URL | Recommended Models |
|----------|----------|--------------------|
| **OpenRouter** | `openrouter.ai/api/v1` | `claude-sonnet-4`, `gpt-4o` |
| **Bianxie** | `api.bianxie.ai/v1` | `gemini-2.5-pro` |
| **Google** | `generativelanguage...` | `gemini-2.5-pro` |

Set up your environment variables:

```bash
export AUTOFIGURE_API_KEY="your-api-key"
export AUTOFIGURE_PROVIDER="openrouter"
export AUTOFIGURE_MODEL="anthropic/claude-sonnet-4"
```
Recommend using gemini-2.5-pro/gemini-3-pro-preview

---

## 📁 Project Structure

<details>
<summary>Click to expand directory tree</summary>

```
AutoFigure/
├── autofigure/              # 📦 Python SDK
│   ├── agent.py             # Main Agent
│   ├── generator.py         # Generation Pipeline
│   ├── enhancer.py          # Image Enhancement
│   └── extractor.py         # PDF Method Extraction
├── frontend/                # 🖥️ Next.js Web UI
├── backend/                 # 🔌 Flask API Server
├── scripts/                 # 🛠️ Utility Scripts
└── pyproject.toml           # Config
```
</details>

---

## 🤝 Community & Support

**WeChat Discussion Group**  
Scan the QR code to join our community. If the code is expired, please contact `tuchuan@mail.hfut.edu.cn`.

<img src="img/wechat.jpg" width="200" alt="WeChat QR Code"/>

---

## 📜 Citation & License

If you use **AutoFigure** or **FigureBench** in your research, please cite:

```bibtex
@software{autofigure2025,
  title = {AutoFigure: Generating and Refining Publication-Ready Scientific Illustrations},
  author={Minjun Zhu and Zhen Lin and Yixuan Weng and Panzhong Lu and Qiujie Xie and Yifan Wei and Yifan_Wei and Sifan Liu and QiYao Sun and Yue Zhang},
  year = {2025},
  url = {https://github.com/ResearAI/AutoFigure}
}

@dataset{figurebench2025,
  title = {FigureBench: A Benchmark for Automated Scientific Illustration Generation},
  author = {WestlakeNLP},
  year = {2025},
  url = {https://huggingface.co/datasets/WestlakeNLP/FigureBench}
}