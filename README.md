A docker environment integrated with visual studio code designed to trace and test langchain scripts 

1. Install the vscode remote system for working with containers: https://code.visualstudio.com/docs/devcontainers/containers
1. Open this folder in vscode, it should build and launch your container
1. Open a terminal and run
   i. `jupyter notebook --allow-root`
1. Connect to the url provided by jupyter and go ham

To use langchain tracing:
1. Kill any already running jupyter notebook
1. Open a new terminal and run
   i. `./launch-with-tracing.sh`
1. The jupypter server link should appear in the terminal
1. The langchain trace link should be: http://127.0.0.1:4173/sessions
   i. Run some langchain stuff
   i. Navigate to the tracer and hit the button labled "Session: Default"
   i. You should see traces here, you may have to refresh the page for new traces to show up


