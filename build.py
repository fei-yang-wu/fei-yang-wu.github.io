#!/usr/bin/env python3

"""English documentation."""

import argparse
import importlib.util
import os
import re
import shutil
import subprocess
import sys
import threading
import time
from dataclasses import dataclass
from datetime import datetime, timezone
from html.parser import HTMLParser
from pathlib import Path
from typing import Literal

# ============================================================================
# NOTE: translated to English
# ============================================================================

CONTENT_DIR = Path("content")  # Source content directory
SITE_DIR = Path("_site")  # Output directory
ASSETS_DIR = Path("assets")  # Static assets directory
CONFIG_FILE = Path("config.typ")  # Global config file


@dataclass
class BuildStats:
    """English documentation."""

    success: int = 0
    skipped: int = 0
    failed: int = 0

    def format_summary(self) -> str:
        """English documentation."""
        parts = []
        if self.success > 0:
            parts.append(f"compiled: {self.success}")
        if self.skipped > 0:
            parts.append(f"skipped: {self.skipped}")
        if self.failed > 0:
            parts.append(f"failed: {self.failed}")
        return ", ".join(parts) if parts else "no files to process"

    @property
    def has_failures(self) -> bool:
        """English documentation."""
        return self.failed > 0


class HTMLMetadataParser(HTMLParser):
    """English documentation."""

    def __init__(self):
        super().__init__()
        self.metadata = {"title": ""}
        self._in_title = False

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]):
        attrs_dict = {k: v for k, v in attrs if v}

        match tag:
            case "html":
                self.metadata["lang"] = attrs_dict.get("lang", "")
            case "title":
                self._in_title = True
            case "meta":
                name = attrs_dict.get("name", "")
                if name in {"description", "date"}:
                    self.metadata[name] = attrs_dict.get("content", "")
            case "link":
                if attrs_dict.get("rel") == "canonical":
                    self.metadata["link"] = attrs_dict.get("href", "")

    def handle_endtag(self, tag: str):
        if tag == "title":
            self._in_title = False

    def handle_data(self, data: str):
        if self._in_title:
            self.metadata["title"] += data


# ============================================================================
# NOTE: translated to English
# ============================================================================


def get_file_mtime(path: Path) -> float:
    """English documentation."""
    try:
        return path.stat().st_mtime
    except (OSError, FileNotFoundError):
        return 0.0


def is_dep_file(path: Path) -> bool:
    """English documentation."""
    try:
        resolved_path = path.resolve()
        project_root = Path(__file__).parent.resolve()
        content_dir = (project_root / CONTENT_DIR).resolve()

        # NOTE: translated to English
        if resolved_path == (project_root / CONFIG_FILE).resolve():
            return True

        # NOTE: translated to English
        try:
            relative_to_content = resolved_path.relative_to(content_dir)
            # NOTE: translated to English
            parts = relative_to_content.parts
            if len(parts) > 0 and parts[0].startswith("_"):
                return True
            # NOTE: translated to English
            return False
        except ValueError:
            # NOTE: translated to English
            return True

    except Exception:
        return True


def find_typ_dependencies(typ_file: Path) -> set[Path]:
    """English documentation."""
    dependencies: set[Path] = set()

    try:
        content = typ_file.read_text(encoding="utf-8")
    except Exception:
        return dependencies

    # NOTE: translated to English
    base_dir = typ_file.parent

    patterns = [
        r'#import\s+"([^"]+)"',
        r"#import\s+'([^']+)'",
        r'#include\s+"([^"]+)"',
        r"#include\s+'([^']+)'",
    ]

    for pattern in patterns:
        for match in re.finditer(pattern, content):
            dep_path_str = match.group(1)

            # NOTE: translated to English
            if dep_path_str.startswith("@"):
                continue

            # NOTE: translated to English
            if dep_path_str.startswith("/"):
                # NOTE: translated to English
                dep_path = Path(dep_path_str.lstrip("/"))
            else:
                # NOTE: translated to English
                dep_path = base_dir / dep_path_str

            # NOTE: translated to English
            try:
                dep_path = dep_path.resolve()
                if dep_path.exists() and dep_path.suffix == ".typ" and is_dep_file(dep_path):
                    dependencies.add(dep_path)
            except Exception:
                pass

    return dependencies


def get_all_dependencies(typ_file: Path, visited: set[Path] | None = None) -> set[Path]:
    """English documentation."""
    if visited is None:
        visited = set()

    # NOTE: translated to English
    abs_path = typ_file.resolve()
    if abs_path in visited:
        return set()
    visited.add(abs_path)

    all_deps: set[Path] = set()
    direct_deps = find_typ_dependencies(typ_file)

    for dep in direct_deps:
        all_deps.add(dep)
        # NOTE: translated to English
        if dep.suffix == ".typ":
            all_deps.update(get_all_dependencies(dep, visited))

    return all_deps


def needs_rebuild(source: Path, target: Path, extra_deps: list[Path] | None = None) -> bool:
    """English documentation."""
    # NOTE: translated to English
    if not target.exists():
        return True

    target_mtime = get_file_mtime(target)

    # NOTE: translated to English
    if get_file_mtime(source) > target_mtime:
        return True

    # NOTE: translated to English
    if extra_deps:
        for dep in extra_deps:
            if dep.exists() and get_file_mtime(dep) > target_mtime:
                return True

    # NOTE: translated to English
    for dep in get_all_dependencies(source):
        if get_file_mtime(dep) > target_mtime:
            return True

    # NOTE: translated to English
    # NOTE: translated to English
    source_dir = source.parent
    for item in source_dir.iterdir():
        if item.is_file() and item.suffix != ".typ":
            if get_file_mtime(item) > target_mtime:
                return True

    return False


def find_common_dependencies() -> list[Path]:
    """English documentation."""
    common_deps = []

    # NOTE: translated to English
    if CONFIG_FILE.exists():
        common_deps.append(CONFIG_FILE)

    # NOTE: translated to English
    # NOTE: translated to English
    if CONTENT_DIR.exists():
        for item in CONTENT_DIR.iterdir():
            if item.is_dir() and item.name.startswith("_"):
                for typ_file in item.rglob("*.typ"):
                    common_deps.append(typ_file)

    return common_deps


# ============================================================================
# NOTE: translated to English
# ============================================================================


def find_typ_files() -> list[Path]:
    """English documentation."""
    typ_files = []
    for typ_file in CONTENT_DIR.rglob("*.typ"):
        # NOTE: translated to English
        parts = typ_file.relative_to(CONTENT_DIR).parts
        if not any(part.startswith("_") for part in parts):
            typ_files.append(typ_file)
    return typ_files


def get_file_output_path(typ_file: Path, type: Literal["pdf", "html"]) -> Path:
    """English documentation."""
    relative_path = typ_file.relative_to(CONTENT_DIR)
    return SITE_DIR / relative_path.with_suffix(f".{type}")


def run_typst_command(args: list[str]) -> bool:
    """English documentation."""
    try:
        result = subprocess.run(["typst"] + args, capture_output=True, text=True, encoding="utf-8")
        if result.returncode != 0:
            print(f"  ERROR: Typst failed: {result.stderr.strip()}")
            return False
        return True
    except FileNotFoundError:
        print("  ERROR: typst command not found. Install Typst and ensure it is in PATH.")
        print("  Install guide: https://typst.app/open-source/#download")
        return False
    except Exception as e:
        print(f"  ERROR: failed to execute typst: {e}")
        return False


# ============================================================================
# NOTE: translated to English
# ============================================================================


def _compile_files(
    files: list[Path],
    force: bool,
    common_deps: list[Path],
    get_output_path_func,
    build_args_func,
) -> BuildStats:
    """English documentation."""
    stats = BuildStats()

    for typ_file in files:
        output_path = get_output_path_func(typ_file)

        # NOTE: translated to English
        if not force and not needs_rebuild(typ_file, output_path, common_deps):
            stats.skipped += 1
            continue

        output_path.parent.mkdir(parents=True, exist_ok=True)

        # NOTE: translated to English
        args = build_args_func(typ_file, output_path)

        if run_typst_command(args):
            stats.success += 1
        else:
            print(f"  ERROR: failed to compile {typ_file}")
            stats.failed += 1

    return stats


def build_html(force: bool = False) -> bool:
    """English documentation."""
    SITE_DIR.mkdir(parents=True, exist_ok=True)

    typ_files = find_typ_files()

    # NOTE: translated to English
    html_files = [f for f in typ_files if "pdf" not in f.stem.lower()]

    if not html_files:
        print("  WARNING: no HTML source files found.")
        return True

    print("Building HTML files...")

    # NOTE: translated to English
    common_deps = find_common_dependencies()

    def build_html_args(typ_file: Path, output_path: Path) -> list[str]:
        """English documentation."""
        try:
            rel_path = typ_file.relative_to(CONTENT_DIR)

            if rel_path.name == "index.typ":
                # index.typ uses the parent directory name as the path
                # content/Blog/index.typ -> "Blog"
                # content/index.typ -> "" (Homepage)
                page_path = rel_path.parent.as_posix()
                if page_path == ".":
                    page_path = ""
            else:
                # Common files use the filename as the path
                # content/about.typ -> "about"
                page_path = rel_path.with_suffix("").as_posix()
        except ValueError:
            page_path = ""

        return [
            "compile",
            "--root",
            ".",
            "--font-path",
            str(ASSETS_DIR),
            "--features",
            "html",
            "--format",
            "html",
            "--input",
            f"page-path={page_path}",
            str(typ_file),
            str(output_path),
        ]

    stats = _compile_files(
        html_files,
        force,
        common_deps,
        lambda typ_file: get_file_output_path(typ_file, "html"),
        build_html_args,
    )

    print(f"HTML build complete. {stats.format_summary()}")
    return not stats.has_failures


def build_pdf(force: bool = False) -> bool:
    """English documentation."""
    SITE_DIR.mkdir(parents=True, exist_ok=True)

    typ_files = find_typ_files()
    pdf_files = [f for f in typ_files if "pdf" in f.stem.lower()]

    if not pdf_files:
        return True

    print("Building PDF files...")

    # NOTE: translated to English
    common_deps = find_common_dependencies()

    def build_pdf_args(typ_file: Path, output_path: Path) -> list[str]:
        """English documentation."""
        return [
            "compile",
            "--root",
            ".",
            "--font-path",
            str(ASSETS_DIR),
            str(typ_file),
            str(output_path),
        ]

    stats = _compile_files(
        pdf_files,
        force,
        common_deps,
        lambda typ_file: get_file_output_path(typ_file, "pdf"),
        build_pdf_args,
    )

    print(f"PDF build complete. {stats.format_summary()}")
    return not stats.has_failures


def copy_assets() -> bool:
    """English documentation."""
    if not ASSETS_DIR.exists():
        print(f"  WARNING: assets directory {ASSETS_DIR} does not exist.")
        return True

    SITE_DIR.mkdir(parents=True, exist_ok=True)
    target_dir = SITE_DIR / "assets"

    try:
        if target_dir.exists():
            shutil.rmtree(target_dir)
        shutil.copytree(ASSETS_DIR, target_dir)
        return True
    except Exception as e:
        print(f"  ERROR: failed to copy static assets: {e}")
        return False


def copy_content_assets(force: bool = False) -> bool:
    """English documentation."""
    SITE_DIR.mkdir(parents=True, exist_ok=True)

    if not CONTENT_DIR.exists():
        print(f"  WARNING: content directory {CONTENT_DIR} does not exist, skipping.")
        return True

    try:
        copy_count = 0
        skip_count = 0

        for item in CONTENT_DIR.rglob("*"):
            # NOTE: translated to English
            if item.is_dir() or item.suffix == ".typ":
                continue

            # NOTE: translated to English
            relative_path = item.relative_to(CONTENT_DIR)
            if any(part.startswith("_") for part in relative_path.parts):
                continue

            # NOTE: translated to English
            target_path = SITE_DIR / relative_path

            # NOTE: translated to English
            if not force and target_path.exists():
                if get_file_mtime(item) <= get_file_mtime(target_path):
                    skip_count += 1
                    continue

            # NOTE: translated to English
            target_path.parent.mkdir(parents=True, exist_ok=True)

            # NOTE: translated to English
            shutil.copy2(item, target_path)
            copy_count += 1

        return True
    except Exception as e:
        print(f"  ERROR: failed to copy content assets: {e}")
        return False


def clean() -> bool:
    """English documentation."""
    print("Cleaning generated files...")

    if not SITE_DIR.exists():
        print(f"  Output directory {SITE_DIR} does not exist. Nothing to clean.")
        return True

    try:
        # NOTE: translated to English
        for item in SITE_DIR.iterdir():
            if item.is_dir():
                shutil.rmtree(item)
            else:
                item.unlink()

        print(f"  Cleaned {SITE_DIR}/.")
        return True
    except Exception as e:
        print(f"  ERROR: clean failed: {e}")
        return False


def preview(port: int = 8000, open_browser_flag: bool = True) -> bool:
    """English documentation."""
    import webbrowser

    if not SITE_DIR.exists():
        print(f"  WARNING: output directory {SITE_DIR} does not exist. Run build first.")
        return False

    print("Starting local preview server (Ctrl+C to stop)...")
    print()

    if open_browser_flag:

        def open_browser():
            time.sleep(1.5)  # Wait for the server to start
            url = f"http://localhost:{port}"
            print(f"  Opening browser: {url}")
            webbrowser.open(url)

        # NOTE: translated to English
        threading.Thread(target=open_browser, daemon=True).start()

    # NOTE: translated to English
    if importlib.util.find_spec("livereload") is not None:
        try:
            from livereload import Server

            print("Using livereload server...")
            server = Server()
            # Rebuild site when source files change.
            server.watch(str(CONTENT_DIR / "**/*"), lambda: build(force=False))
            server.watch(str(ASSETS_DIR / "**/*"), lambda: build(force=False))
            server.watch(str(CONFIG_FILE), lambda: build(force=False))
            if Path("tufted-lib").exists():
                server.watch("tufted-lib/**/*", lambda: build(force=False))

            server.serve(root=str(SITE_DIR), port=port, host="127.0.0.1", open_url_delay=None)
            return True
        except KeyboardInterrupt:
            print("\nServer stopped.")
            return True
        except Exception as e:
            print(f"  WARNING: livereload failed to start: {e}")
            print("  Falling back to Python http.server.")
    else:
        print("  livereload is not installed. Falling back to Python http.server.")
        print("  For live reload, run in the active env: uv pip install livereload")

    # NOTE: translated to English
    try:
        print("Using Python built-in http.server...")
        result = subprocess.run(
            [sys.executable, "-m", "http.server", str(port), "--directory", str(SITE_DIR)],
            check=False,
        )
        return result.returncode == 0
    except KeyboardInterrupt:
        print("\nServer stopped.")
        return True
    except Exception as e:
        print(f"  ERROR: failed to start preview server: {e}")
        return False


def parse_html_metadata(html_path: Path) -> dict[str, str]:
    """English documentation."""
    parser = HTMLMetadataParser()
    parser.feed(html_path.read_text(encoding="utf-8"))
    return parser.metadata


def get_site_url() -> str | None:
    """English documentation."""
    index_html = SITE_DIR / "index.html"
    parser = parse_html_metadata(index_html)

    if parser.get("link"):
        return parser["link"].rstrip("/")

    return None


def get_feed_dirs() -> set[str]:
    """English documentation."""
    if not CONFIG_FILE.exists():
        return set()

    try:
        content = CONFIG_FILE.read_text(encoding="utf-8")

        # NOTE: translated to English
        content = re.sub(r"//.*", "", content)
        content = re.sub(r"/\*[\s\S]*?\*/", "", content)

        match = re.search(r"feed-dir\s*:\s*\((.*?)\)", content, re.DOTALL)
        if match:
            return set(
                c.strip("/") for c in re.findall(r'"([^"]*)"', match.group(1)) if c and c.strip("/")
            )
    except Exception as e:
        print(f"WARNING: failed to parse feed-dir: {e}")

    return set()


def extract_post_metadata(index_html: Path) -> tuple[str, str, str, datetime | None]:
    """English documentation."""
    parser = parse_html_metadata(index_html)

    title = parser["title"].strip()
    description = parser.get("description", "").strip()
    link = parser.get("link", "")
    date_obj = None

    # NOTE: translated to English
    if parser.get("date"):
        try:
            date_obj = datetime.strptime(parser["date"].split("T")[0], "%Y-%m-%d")
            date_obj = date_obj.replace(tzinfo=timezone.utc)
        except Exception:
            pass

    # NOTE: translated to English
    if not date_obj:
        date_match = re.search(r"(\d{4}-\d{2}-\d{2})", index_html.parent.name)
        if date_match:
            try:
                date_obj = datetime.strptime(date_match.group(1), "%Y-%m-%d")
                date_obj = date_obj.replace(tzinfo=timezone.utc)
            except ValueError:
                pass

    return title, description, link, date_obj


def collect_posts(dirs: set[str], site_url: str) -> list[dict]:
    """English documentation."""
    posts = []

    for d in dirs:
        dir_path = SITE_DIR / d

        for item in dir_path.iterdir():
            if not item.is_dir():
                continue

            index_html = item / "index.html"
            if not index_html.exists():
                continue

            title, description, link, date_obj = extract_post_metadata(index_html)

            if not date_obj:
                print(f"WARNING: could not determine date for post '{item.name}', skipped.")
                continue

            posts.append(
                {
                    "title": title,
                    "description": description,
                    "dir": d,
                    "link": link,
                    "date": date_obj,
                }
            )

    return posts


def build_rss_xml(posts: list[dict], config: dict) -> str:
    """English documentation."""
    import xml.etree.ElementTree as ET
    from email.utils import format_datetime

    # NOTE: translated to English
    ATOM_NS = "http://www.w3.org/2005/Atom"
    ET.register_namespace("atom", ATOM_NS)

    # NOTE: translated to English
    rss = ET.Element("rss", version="2.0")

    # NOTE: translated to English
    channel = ET.SubElement(rss, "channel")
    ET.SubElement(channel, "title").text = config["site_title"]
    ET.SubElement(channel, "link").text = config["site_url"]
    ET.SubElement(channel, "description").text = config["site_description"]
    ET.SubElement(channel, "language").text = config["lang"]
    ET.SubElement(channel, "lastBuildDate").text = format_datetime(datetime.now(timezone.utc))

    # NOTE: translated to English
    atom_link = ET.SubElement(channel, f"{{{ATOM_NS}}}link")
    atom_link.set("href", f"{config['site_url']}/feed.xml")
    atom_link.set("rel", "self")
    atom_link.set("type", "application/rss+xml")

    # NOTE: translated to English
    for post in posts:
        item = ET.SubElement(channel, "item")

        ET.SubElement(item, "title").text = post["title"]
        ET.SubElement(item, "link").text = post["link"]
        ET.SubElement(item, "guid", isPermaLink="true").text = post["link"]
        ET.SubElement(item, "pubDate").text = format_datetime(post["date"])
        ET.SubElement(item, "category").text = post["dir"]

        # NOTE: translated to English
        if des := post["description"]:
            ET.SubElement(item, "description").text = des

    # NOTE: translated to English
    ET.indent(rss, space="  ")
    xml_str = ET.tostring(rss, encoding="unicode", xml_declaration=False)

    return f'<?xml version="1.0" encoding="UTF-8"?>\n{xml_str}'


def generate_rss(site_url: str) -> bool:
    """English documentation."""
    rss_file = SITE_DIR / "feed.xml"
    dirs = get_feed_dirs()

    if not dirs:
        print("WARNING: skipping RSS generation: no feed directories configured.")
        return True

    # NOTE: translated to English
    existing = {d for d in dirs if (SITE_DIR / d).exists()}
    missing = dirs - existing

    for d in missing:
        print(f"WARNING: configured feed directory '{d}' does not exist.")

    if not existing:
        print("WARNING: skipping RSS generation: none of the configured directories exist.")
        return True

    # NOTE: translated to English
    posts = collect_posts(existing, site_url)

    if not posts:
        print("WARNING: no posts found. RSS feed will be empty.")
        return True

    # NOTE: translated to English
    posts = sorted(posts, key=lambda x: x["date"], reverse=True)

    # NOTE: translated to English
    index_html = SITE_DIR / "index.html"
    parser = parse_html_metadata(index_html)

    lang = parser["lang"]
    site_title = parser["title"].strip()
    site_description = parser.get("description", "").strip()

    config = {
        "site_url": site_url,
        "site_title": site_title,
        "site_description": site_description,
        "lang": lang,
    }

    # NOTE: translated to English
    try:
        rss_content = build_rss_xml(posts, config)
        rss_file.write_text(rss_content, encoding="utf-8")
        print(f"RSS feed generated: {rss_file} ({len(posts)} posts)")
        return True
    except ValueError as e:
        print("ERROR: RSS generation failed")
        print(f"   Cause: feed generation error - {e}")
        print("   Fix: check required config.typ fields (title and description)")
        return False
    except Exception as e:
        print("ERROR: failed while generating RSS feed")
        print(f"   Exception: {type(e).__name__}: {e}")
        return False


def generate_sitemap(site_url: str) -> bool:
    """English documentation."""
    import xml.etree.ElementTree as ET

    sitemap_path = SITE_DIR / "sitemap.xml"
    sitemap_ns = "http://www.sitemaps.org/schemas/sitemap/0.9"

    # NOTE: translated to English
    ET.register_namespace("", sitemap_ns)

    # NOTE: translated to English
    urlset = ET.Element("urlset", xmlns=sitemap_ns)

    # NOTE: translated to English
    for file_path in sorted(SITE_DIR.rglob("*.html")):
        rel_path = file_path.relative_to(SITE_DIR).as_posix()

        # NOTE: translated to English
        if rel_path == "index.html":
            url_path = ""
        elif rel_path.endswith("/index.html"):
            url_path = rel_path.removesuffix("index.html")
        elif rel_path.endswith(".html"):
            url_path = rel_path.removesuffix(".html") + "/"
        else:
            url_path = rel_path

        full_url = f"{site_url}/{url_path}"

        # NOTE: translated to English
        mtime = file_path.stat().st_mtime
        lastmod = datetime.fromtimestamp(mtime).strftime("%Y-%m-%d")

        # NOTE: translated to English
        url_elem = ET.SubElement(urlset, "url")
        ET.SubElement(url_elem, "loc").text = full_url
        ET.SubElement(url_elem, "lastmod").text = lastmod

    # NOTE: translated to English
    ET.indent(urlset, space="  ")
    xml_str = ET.tostring(urlset, encoding="unicode", xml_declaration=False)
    sitemap_content = f'<?xml version="1.0" encoding="UTF-8"?>\n{xml_str}'

    try:
        sitemap_path.write_text(sitemap_content, encoding="utf-8")
        print(f"Sitemap generated: {len(urlset)} pages")
        return True
    except Exception as e:
        print(f"ERROR: sitemap generation failed: {e}")
        return False


def generate_robots_txt(site_url: str) -> bool:
    """Generate robots.txt pointing to the sitemap."""
    robots_content = f"""User-agent: *
Allow: /

Sitemap: {site_url}/sitemap.xml
"""

    try:
        (SITE_DIR / "robots.txt").write_text(robots_content, encoding="utf-8")
        return True
    except Exception as e:
        print(f"ERROR: failed to generate robots.txt: {e}")
        return False


def build(force: bool = False) -> bool:
    """Run full build: HTML + PDF + assets."""
    print("-" * 60)
    if force:
        clean()
        print("Starting full rebuild...")
    else:
        print("Starting incremental build...")
    print("-" * 60)

    SITE_DIR.mkdir(parents=True, exist_ok=True)

    results = []

    print()
    results.append(build_html(force))
    results.append(build_pdf(force))
    print()

    results.append(copy_assets())
    results.append(copy_content_assets(force))

    if site_url := get_site_url():
        results.append(generate_sitemap(site_url))
        results.append(generate_robots_txt(site_url))
        results.append(generate_rss(site_url))

    print("-" * 60)
    if all(results):
        print("All build tasks completed.")
        print(f"  Output directory: {SITE_DIR.absolute()}")
    else:
        print("Build finished with partial failures.")
    print("-" * 60)

    return all(results)


def create_parser() -> argparse.ArgumentParser:
    """Create CLI argument parser."""
    parser = argparse.ArgumentParser(
        prog="build.py",
        description="Tufted Blog Template build script - compile Typst files in content to HTML and PDF",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
By default, the script rebuilds only changed files. Use -f/--force for a full rebuild:
    python build.py build --force
    python build.py build -f

Use preview to start a local server:
    python build.py preview
    python build.py preview -p 3000

See README.md for more details.
""",
    )

    subparsers = parser.add_subparsers(dest="command", title="available commands", metavar="<command>")

    build_parser = subparsers.add_parser("build", help="full build (HTML + PDF + assets)")
    build_parser.add_argument("-f", "--force", action="store_true", help="force full rebuild")

    html_parser = subparsers.add_parser("html", help="build HTML only")
    html_parser.add_argument("-f", "--force", action="store_true", help="force full rebuild")

    pdf_parser = subparsers.add_parser("pdf", help="build PDF only")
    pdf_parser.add_argument("-f", "--force", action="store_true", help="force full rebuild")

    subparsers.add_parser("assets", help="copy static assets only")
    subparsers.add_parser("clean", help="clean generated output")

    preview_parser = subparsers.add_parser("preview", help="start local preview server")
    preview_parser.add_argument("-p", "--port", type=int, default=8000, help="server port (default: 8000)")
    preview_parser.add_argument("--no-open", action="store_false", dest="open_browser", help="do not open browser automatically")
    preview_parser.set_defaults(open_browser=True)

    return parser


if __name__ == "__main__":
    parser = create_parser()
    args = parser.parse_args()

    if args.command is None:
        parser.print_help()
        sys.exit(0)

    script_dir = Path(__file__).parent.absolute()
    os.chdir(script_dir)

    force = getattr(args, "force", False)

    match args.command:
        case "build":
            success = build(force)
        case "html":
            success = build_html(force)
        case "pdf":
            success = build_pdf(force)
        case "assets":
            success = copy_assets()
        case "clean":
            success = clean()
        case "preview":
            success = preview(getattr(args, "port", 8000), getattr(args, "open_browser", True))
        case _:
            print(f"ERROR: unknown command: {args.command}")
            success = False

    sys.exit(0 if success else 1)
