{%- extends 'lab/index.html.j2' -%}

{%- block header -%}
<nav>
    <ul>
        {%- set heading_counter = 0 -%}
        {%- for cell in nb.cells if cell.cell_type == 'markdown' -%}
            {%- for line in cell.source.splitlines() -%}
                {%- if line.startswith('# ') -%}
                    {%- set heading_counter = heading_counter + 1 -%}
                    <li style="margin-left: 0; font-size: 36px;"><a href="#heading-{{ heading_counter }}">{{ line[2:] }}</a></li>
                {%- elif line.startswith('## ') -%}
                    {%- set heading_counter = heading_counter + 1 -%}
                    <li style="margin-left: 20px; font-size: 24px;"><a href="#heading-{{ heading_counter }}">{{ line[3:] }}</a></li>
                {%- elif line.startswith('### ') -%}
                    {%- set heading_counter = heading_counter + 1 -%}
                    <li style="margin-left: 40px; font-size: 18px;"><a href="#heading-{{ heading_counter }}">○ {{ line[4:] }}</a></li>
                {%- elif line.startswith('#### ') -%}
                    {%- set heading_counter = heading_counter + 1 -%}
                    <li style="margin-left: 60px; font-size: 16px;"><a href="#heading-{{ heading_counter }}">● {{ line[5:] }}</a></li>
                {%- endif -%}
            {%- endfor -%}
        {%- endfor -%}
    </ul>
</nav>
{{ super() }}
{%- endblock header -%}

{%- block body -%}
    {%- set heading_counter = 0 -%}
    {{ super() }}
    <style>
        /* Fixed button for "Back to Table of Contents" */
        #back-to-toc {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background-color: lightblue;
            color: navy;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            font-size: 14px;
            cursor: pointer;
            z-index: 1000;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        #back-to-toc:hover {
            background-color: #0056b3;
            color: white;
        }
    </style>

    <style>
        /* Style the navigation container */
        nav {
            width: fit-content;
            background-color: lightblue; /* mediumpurple background for the nav bar */
            padding: 10px; /* Padding around the navigation */
            border-radius: 5px; /* Rounded corners */
        }
    
        /* Style the unordered list to remove default styles */
        nav ul {
            list-style-type: none; /* Remove bullet points */
            padding: 0; /* Remove padding */
            margin: 0; /* Remove margins */
        }
    
        /* Style each list item */
        nav ul li {
            margin-bottom: 5px; /* Add spacing between items */
        }
    
        /* Add indentation for different heading levels */
        nav ul li {
            margin-left: 0; /* Default margin for top-level items */
        }
    
        nav ul li:nth-child(n+2) {
            margin-left: 20px; /* Indentation for subheadings */
        }
    
        /* Style the links */
        nav ul li a {
            text-decoration: none; /* Remove underline */
            color: navy; /* White text color */
            display: block; /* Make links block-level for better spacing */
            padding: 5px 10px; /* Add padding around links */
            background-color: lightyellow; /* Darker blue for links */
            border-radius: 3px; /* Rounded corners for links */
        }
    
        /* Add hover effect for links */
        nav ul li a:hover {
            background-color: #004494; /* Even darker blue on hover */
            color: #fff; /* Ensure text remains readable */
        }
    
        /* Style nested lists (subheadings) */
        nav ul li ul {
            padding-left: 20px; /* Add extra indentation for nested lists */
        }
    </style>

    <style>
    h1, h2, h3, h4 {
    background-color: lightyellow;
    color: navy;
    padding: 10px;
    border: 10px solid lightblue;
    border-radius: 5px; /* Rounded corners */
    }
    </style>

    <button id="back-to-toc" onclick="window.scrollTo({top: 0, behavior: 'smooth'});">Back to Table of Contents</button>
    <script>
        // Dynamically assign IDs to headings based on the ToC
        const headings = document.querySelectorAll("h1, h2, h3, h4");
        const tocLinks = document.querySelectorAll("nav ul li a");
        tocLinks.forEach((link, index) => {
            if (headings[index]) {
                const heading = headings[index];
                const id = "heading-" + (index + 1);
                heading.id = id; // Assign unique ID to the heading
                link.href = "#" + id; // Update ToC link to match the heading ID
            }
        });
    </script>
{%- endblock body -%}