# AutoFigure

**AI-powered Scientific Figure Generation**

AutoFigure is an intelligent system that automatically generates high-quality scientific figures from text descriptions or research papers. It uses large language models (LLMs) with iterative refinement to create publication-ready diagrams.

## Features

- **Text-to-Figure**: Generate figures from natural language descriptions
- **Paper-to-Figure**: Extract methodology from PDFs and create visual diagrams
- **Iterative Refinement**: Two-agent system (Improvement + Evaluation) for quality optimization
- **Multiple Formats**: Output as SVG or mxGraph XML (draw.io compatible)
- **Image Enhancement**: Optional AI-powered image beautification
- **Web Interface**: Interactive frontend for figure generation and editing

## Project Structure

```
AutoFigure/
├── autofigure/              # Python SDK (pip installable)
│   ├── agent.py                   # AutoFigureAgent class
│   ├── config.py                  # Configuration
│   ├── generator.py               # Core generation pipeline
│   ├── enhancer.py                # Image enhancement
│   ├── extractor.py               # Methodology extraction
│   ├── references/                # Reference figures for style
│   └── utils/                     # Utility modules
├── frontend/                # Web interface (Next.js)
├── backend/                 # API server (Flask)
├── scripts/                 # Utility scripts
├── pyproject.toml           # Package configuration
└── requirements.txt         # Dependencies
```

## Quick Start

### Option 1: Python SDK (Recommended)

```bash
# Clone the repository
git clone https://github.com/ResearAI/AutoFigure.git
cd AutoFigure

# Install dependencies
pip install -r requirements.txt

# Install AutoFigure in development mode
pip install -e .

# Install Playwright browser (required for mxGraph XML to PNG conversion)
playwright install chromium
```

**Verify Installation:**

```python
from autofigure import AutoFigureAgent, Config
print("AutoFigure installed successfully!")
```

**Basic Usage:**

```python
from autofigure import AutoFigureAgent, Config

# Configure
config = Config(
    generation_api_key="your-api-key",
    generation_provider="openrouter",  # or 'gemini', 'bianxie'
)

# Generate
agent = AutoFigureAgent(config)
result = agent.generate(
    description="A flowchart showing transformer training pipeline",
    max_iterations=5,
    output_format="svg",  # 'svg' or 'mxgraphxml'
)

print(f"Generated: {result.svg_path}")
print(f"Score: {result.final_score}/10")
```

### Option 2: Web Interface

```bash
# Clone the repository
git clone https://github.com/ResearAI/AutoFigure.git
cd AutoFigure

# Install backend dependencies
cd backend
pip install -r requirements.txt
playwright install chromium
cd ..

# Install frontend dependencies
cd frontend
npm install
cd ..

# Start both servers (Linux/macOS)
./start.sh

# Or start manually (Windows)
# Terminal 1: cd backend && python app.py
# Terminal 2: cd frontend && npm run dev
```

Open http://localhost:6002 in your browser.

## Configuration

### LLM Providers

AutoFigure supports multiple LLM providers:

| Provider | Base URL | Models |
|----------|----------|--------|
| OpenRouter | `https://openrouter.ai/api/v1` | claude-sonnet-4, gpt-4o, etc. |
| Bianxie | `https://api.bianxie.ai/v1` | gemini-2.5-pro |
| Google Gemini | `https://generativelanguage.googleapis.com/v1beta/openai/` | gemini-2.5-pro |

### Environment Variables

```bash
export AUTOFIGURE_API_KEY="your-api-key"
export AUTOFIGURE_PROVIDER="openrouter"
export AUTOFIGURE_MODEL="anthropic/claude-sonnet-4"
export AUTOFIGURE_MAX_ITERATIONS="5"
```

## FigureBench Dataset

AutoFigure includes **FigureBench**, the first large-scale benchmark for generating scientific illustrations from long-form scientific texts.

### Dataset Highlights

| Category | Samples | Avg. Text Tokens | Text Density (%) | Components | Colors | Shapes |
|----------|---------|------------------|------------------|------------|--------|--------|
| Paper | 3,200 | 12,732 | 42.1 | 5.4 | 6.4 | 6.7 |
| Blog | 20 | 4,047 | 46.0 | 4.2 | 5.5 | 5.3 |
| Survey | 40 | 2,179 | 43.8 | 5.8 | 7.0 | 6.7 |
| Textbook | 40 | 352 | 25.0 | 4.5 | 4.2 | 3.4 |
| **Total/Avg** | **3,300** | **10,300** | **41.2** | **5.3** | **6.2** | **6.4** |

### Key Challenges

- **Long-context reasoning**: Text tokens vary from 352 (textbooks) to 12,732 (papers)
- **High text density**: Average 41.2% of image area occupied by text
- **Structural complexity**: Average 5.3 components and 6.4 shapes per illustration

### Download Dataset

The dataset is hosted on HuggingFace. Download using one of these methods:

**Option 1: Download Script**

```bash
python scripts/download_figurebench.py
```

**Option 2: HuggingFace Datasets**

```python
from datasets import load_dataset

dataset = load_dataset("WestlakeNLP/FigureBench")
sample = dataset["train"][0]
```

**Option 3: HuggingFace CLI**

```bash
huggingface-cli download WestlakeNLP/FigureBench --repo-type dataset --local-dir figurebench
```

For detailed documentation, visit [HuggingFace](https://huggingface.co/datasets/WestlakeNLP/FigureBench).

## How It Works

AutoFigure uses a two-agent iterative refinement process:

1. **Generation Agent**: Creates initial figure code (SVG/mxGraph XML) based on the description and reference figures

2. **Evaluation Agent**: Scores the figure quality (0-10) and provides improvement suggestions

3. **Iteration**: The generation agent refines the figure based on feedback until the quality threshold is met or max iterations reached

```
Description → Generate → Evaluate → Improve → Evaluate → ... → Final Figure
                ↑                      |
                +----------------------+
```

## License

MIT License - see [LICENSE](LICENSE) for details.

## Citation

If you use AutoFigure or FigureBench in your research, please cite:

```bibtex
@software{autofigure2025,
  title = {AutoFigure: Generating and Refining Publication-Ready Scientific Illustrations},
  author={Minjun Zhu, Zhen Lin, Yixuan Weng, Panzhong Lu, Qiujie Xie, Yifan Wei, Yifan_Wei, Sifan Liu, QiYao Sun, Yue Zhang}
  year = {2025},
  url = {https://github.com/ResearAI/AutoFigure}
}

@dataset{figurebench2025,
  title = {FigureBench: A Benchmark for Automated Scientific Illustration Generation},
  author = {WestlakeNLP},
  year = {2025},
  url = {https://huggingface.co/datasets/WestlakeNLP/FigureBench}
}
```

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.
