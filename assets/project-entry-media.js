const MOBILE_MEDIA_QUERY = "(max-width: 760px)";
const MAX_MEDIA_WIDTH_RATIO = 0.42;
const MAX_MEDIA_WIDTH_REM = 32;

function setProjectEntryMediaLoading(video, isLoading) {
    const media = video.closest(".project-entry-media");
    if (!media) {
        return;
    }

    media.classList.toggle("is-loading", isLoading);
    media.classList.toggle("is-ready", !isLoading);
}

function updateProjectEntryMedia(video) {
    const media = video.closest(".project-entry-media");
    const layout = video.closest(".project-entry-layout");
    const text = layout?.querySelector(".project-entry-text");

    if (!media || !layout || !text || !video.videoWidth || !video.videoHeight) {
        return;
    }

    if (window.matchMedia(MOBILE_MEDIA_QUERY).matches) {
        media.style.removeProperty("--project-entry-media-width");
        return;
    }

    const layoutWidth = layout.getBoundingClientRect().width;
    const textHeight = text.getBoundingClientRect().height;
    const rootFontSize = parseFloat(
        getComputedStyle(document.documentElement).fontSize,
    );
    const maxWidth = Math.min(
        layoutWidth * MAX_MEDIA_WIDTH_RATIO,
        rootFontSize * MAX_MEDIA_WIDTH_REM,
    );
    const naturalWidth = textHeight * (video.videoWidth / video.videoHeight);
    const width = Math.min(naturalWidth, maxWidth);

    media.style.setProperty("--project-entry-media-width", `${width}px`);
}

function updateAllProjectEntryMedia() {
    const videos = document.querySelectorAll(".project-entry-media video");

    for (const video of videos) {
        updateProjectEntryMedia(video);
    }
}

function initProjectEntryMedia() {
    const videos = document.querySelectorAll(".project-entry-media video");

    for (const video of videos) {
        setProjectEntryMediaLoading(video, video.readyState < 2);

        if (video.readyState >= 1) {
            updateProjectEntryMedia(video);
        } else {
            video.addEventListener(
                "loadedmetadata",
                () => updateProjectEntryMedia(video),
                { once: true },
            );
        }

        if (video.readyState >= 2) {
            setProjectEntryMediaLoading(video, false);
        } else {
            video.addEventListener(
                "loadeddata",
                () => setProjectEntryMediaLoading(video, false),
                { once: true },
            );

            video.addEventListener(
                "error",
                () => setProjectEntryMediaLoading(video, false),
                { once: true },
            );
        }
    }

    window.addEventListener("load", updateAllProjectEntryMedia, { once: true });
    window.addEventListener("resize", updateAllProjectEntryMedia);
}

if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", initProjectEntryMedia, {
        once: true,
    });
} else {
    initProjectEntryMedia();
}
