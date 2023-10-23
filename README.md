# Terraform Workspace Repository

## Description

This repository contains a Visual Studio Code workspace which can be added to other projects via a git clone command.

The workspace setup contains a developer container which is built by Visual Studio Code with tools to lint files and upload code.

The container also loads VS Code extensions to manage and lint Dockerfiles, YAML, and Markdown.

## Setting Up The Workspace

In order to setup the workspace to work with the other projects in this repository group, perform the following actions:

1. Create a new blank directory for a new repository. ``` mkdir new-repo ```

2. Switch into the new top-level directory. ``` cd new-repo ```

3. Clone the workspace repository into the top-level directory. ``` git clone <REPO> .workspace ```

4. While in the top-level directory execute ``` ln -s .workspace/devcontainer ```

5. (Optional) Copy the default config files for the extensions from defaults if you want to use them. `` cp .workspace/defaults/.* . ``

If working correctly, Visual code should open the project directories and try to build the development container.
