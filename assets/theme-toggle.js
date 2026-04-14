/**
 * Theme toggling feature
 *
 * Behavior:
 * 1. On each new tab/window open, follow system theme by default.
 * 2. After manual toggle, keep selection within current tab session.
 * 3. On tab close and reopen, follow system theme again.
 *
 * Uses sessionStorage (not localStorage) to avoid cross-session persistence.
 */
(function () {
    const STORAGE_KEY = "theme-preference";

    // SVG icon constants
    const ICONS = {
        sun: `<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 256 256"><path d="M120,40V16a8,8,0,0,1,16,0V40a8,8,0,0,1-16,0Zm8,24a64,64,0,1,0,64,64A64.07,64.07,0,0,0,128,64ZM58.34,69.66A8,8,0,0,0,69.66,58.34l-16-16A8,8,0,0,0,42.34,53.66Zm0,116.68-16,16a8,8,0,0,0,11.32,11.32l16-16a8,8,0,0,0-11.32-11.32ZM192,72a8,8,0,0,0,5.66-2.34l16-16a8,8,0,0,0-11.32-11.32l-16,16A8,8,0,0,0,192,72Zm5.66,114.34a8,8,0,0,0-11.32,11.32l16,16a8,8,0,0,0,11.32-11.32ZM48,128a8,8,0,0,0-8-8H16a8,8,0,0,0,0,16H40A8,8,0,0,0,48,128Zm80,80a8,8,0,0,0-8,8v24a8,8,0,0,0,16,0V216A8,8,0,0,0,128,208Zm112-88H216a8,8,0,0,0,0,16h24a8,8,0,0,0,0-16Z"></path></svg>`,
        moon: `<svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 256 256"><path d="M235.54,150.21a104.84,104.84,0,0,1-37,52.91A104,104,0,0,1,32,120,103.09,103.09,0,0,1,52.88,57.48a104.84,104.84,0,0,1,52.91-37,8,8,0,0,1,10,10,88.08,88.08,0,0,0,109.8,109.8,8,8,0,0,1,10,10Z"></path></svg>`,
    };

    // Read saved theme preference (current session only)
    function getStoredTheme() {
        try {
            return sessionStorage.getItem(STORAGE_KEY);
        } catch (e) {
            return null;
        }
    }

    // Save theme preference (current session only)
    function setStoredTheme(theme) {
        try {
            sessionStorage.setItem(STORAGE_KEY, theme);
        } catch (e) {
            // sessionStorage not available
        }
    }

    // Detect system preferred theme
    function getSystemTheme() {
        return window.matchMedia("(prefers-color-scheme: dark)").matches
            ? "dark"
            : "light";
    }

    // Determine the active theme
    function getCurrentTheme() {
        const storedTheme = getStoredTheme();
        if (storedTheme) {
            return storedTheme;
        }
        return getSystemTheme();
    }

    // Apply theme to document
    function applyTheme(theme) {
        document.documentElement.setAttribute("data-theme", theme);
        updateToggleButton(theme);
    }

    // Update toggle button state
    function updateToggleButton(theme) {
        const button = document.getElementById("theme-toggle");
        if (!button) return;

        // In dark mode show sun (switch to light); in light mode show moon (switch to dark)
        if (theme === "dark") {
            button.classList.add("is-dark");
            button.setAttribute("aria-label", "Switch to light mode");
            button.innerHTML = ICONS.sun;
        } else {
            button.classList.remove("is-dark");
            button.setAttribute("aria-label", "Switch to dark mode");
            button.innerHTML = ICONS.moon;
        }
    }

    // Toggle theme
    function toggleTheme() {
        const currentTheme =
            document.documentElement.getAttribute("data-theme") || getSystemTheme();
        const newTheme = currentTheme === "dark" ? "light" : "dark";
        setStoredTheme(newTheme);
        applyTheme(newTheme);
    }

    // Create toggle button (DeepWiki style, single icon)
    function createToggleButton() {
        const button = document.createElement("button");
        button.id = "theme-toggle";
        button.className = "theme-toggle-btn";
        button.type = "button";
        button.setAttribute("aria-label", "Toggle theme");

        button.addEventListener("click", toggleTheme);

        return button;
    }

    // Initialize
    function init() {
        // Apply theme early to prevent flicker before DOM is ready
        const theme = getCurrentTheme();
        document.documentElement.setAttribute("data-theme", theme);

        // Add button when DOM is ready
        if (document.readyState === "loading") {
            document.addEventListener("DOMContentLoaded", onDOMReady);
        } else {
            onDOMReady();
        }
    }

    function onDOMReady() {
        const button = createToggleButton();

        // Find header nav and append button there
        const nav = document.querySelector("header nav");
        if (nav) {
            nav.appendChild(button);
        } else {
            // Fallback: append to body
            document.body.appendChild(button);
        }

        // Sync button state
        updateToggleButton(getCurrentTheme());

        // Listen to system theme changes
        window
            .matchMedia("(prefers-color-scheme: dark)")
            .addEventListener("change", function (e) {
                // Follow system only when user has not manually selected a theme
                if (!getStoredTheme()) {
                    applyTheme(e.matches ? "dark" : "light");
                }
            });
    }

    // Run immediately
    init();
})();
