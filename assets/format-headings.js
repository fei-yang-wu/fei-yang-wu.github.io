document.addEventListener('DOMContentLoaded', function() {
    // Select all heading levels
    const headings = document.querySelectorAll('h1, h2, h3, h4, h5, h6');

    headings.forEach(el => {
        processNode(el);
    });

    function processNode(node) {
        if (node.nodeType === 3) { // 3 means text node
            const text = node.nodeValue;

            // If text contains ASCII characters (English, numbers, half-width punctuation)
            if (/[\x00-\x7F]/.test(text)) {
                const fragment = document.createDocumentFragment();
                let lastIndex = 0;
                // Regex: match consecutive ASCII characters
                const regex = /[\x00-\x7F]+/g;
                let match;

                while ((match = regex.exec(text)) !== null) {
                    // 1. Add text before the ASCII match
                    if (match.index > lastIndex) {
                        fragment.appendChild(document.createTextNode(text.substring(lastIndex, match.index)));
                    }

                    // 2. Wrap matched ASCII text in a span
                    const span = document.createElement('span');
                    span.className = 'heading-en';
                    span.textContent = match[0];
                    fragment.appendChild(span);

                    lastIndex = regex.lastIndex;
                }

                // 3. Add remaining text
                if (lastIndex < text.length) {
                    fragment.appendChild(document.createTextNode(text.substring(lastIndex)));
                }

                // Replace original text node with processed fragment
                node.parentNode.replaceChild(fragment, node);
            }
        } else if (node.nodeType === 1) { // 1 means element node (for example, a link inside h2)
            // Recursively process child nodes
            Array.from(node.childNodes).forEach(processNode);
        }
    }
});
