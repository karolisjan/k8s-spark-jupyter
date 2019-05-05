# Configuration file for ipython-notebook.

c = get_config()

# ------------------------------------------------------------------------------
# NotebookApp configuration
# ------------------------------------------------------------------------------

c.NotebookApp.ip = '0.0.0.0'
c.NotebookApp.open_browser = False
c.NotebookApp.trust_xheaders = True
c.NotebookApp.tornado_settings = {'static_url_prefix': '/static/'}
c.NotebookApp.notebook_dir = '/notebooks'
c.NotebookApp.token = ''
c.NotebookApp.password = ''
