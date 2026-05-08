LegalRabbit DOCX Claude plugin
===============================

A Claude Cowork plugin that creates and modifies DOCX files locally. It saves tons of time by enabling your Cowork to work on the docx files directly.

We are using this plugin at [LegalRabbit](https://legalrabbit.ai) to speed up our legal services. Now we want to share it with the world.

The plugin works offline, ensuring data privacy and security of your DOCX files.

Capabilities:
- Read the content and the comments.
- Create a new docx file. Optionally, you can use an existing docx file as the template. The styles will be copied from the template.
- Add tracked changes to an existing docx file.
- Add comments and reply to comments.

Example prompts
----------------

- _Create a NDA docx file based on NDA-template.docx. My company is LegalRabbit. The other party is John Austin._
- _Review and flag issues in 'Data Processing Agreement.docx'. You can redline and add comments on the doc directly._
- _I've made comments in 'BPO referral agreement.docx'. Please address them._
- _Delete all comments and provide customer-facing comments_ 

How to install
---------------

1. Go to the release page and pick the latest version from the [releases page](https://github.com/LegalRabbit/LegalRabbit-Claude-Plugin/releases)
2. Download `Source code (zip)`
3. Open your Cowork and go to `Customize`
4. Click on the `+` on the right side of `Personal Plugins`.
5. Choose `+ Create Plugin >` and `Upload Plugin`
6. Upload the downloaded `Source code (zip)` and click `Upload`
7. There will be a warning about our local MCP server named `docx`. Please click `Continue`.

Now you can test it using the example prompt above.


Support
---------

Contact: tanin(at)legalrabbit.ai

Learn more about us: [LegalRabbit](https://legalrabbit.ai/)
