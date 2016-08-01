<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <link rel="stylesheet" href="styles/documentation_functions.css" />
        <title>${title}</title>
        <script>
         var isOpen = true;
         var content;
         var sidebar;
         var btn;

         function load() {
             content = document.getElementById("content");
             sidebar = document.getElementById("sidebar");
             btn = document.getElementById("btn");
             //If no sidebar on page - exit
             if (! sidebar) {
               return;
             }
             var sidebarStyle = getComputedStyle(sidebar);
             var fWidth = sidebar.offsetWidth;
             var leftMargin = fWidth + 10 + "px";
             content.style.marginLeft = fWidth + 10 + "px";
         }

         function toggle(e) {
             e.preventDefault();
             if (isOpen) {
                 hide();
                 isOpen = false;
             } else {
                 show();
                 isOpen = true;
             }
         }

         function hide() {
             sidebar.classList.add('d-function-list_minimized_state');
             sidebar.classList.remove('d-function-list_maximized_state');
             content.classList.add('d-content__wrapper_maximized');
             btn.classList.add('d-function-list__btn-uncover');
             btn.classList.remove('d-function-list__btn-cover');
         }

         function show() {
             sidebar.classList.add('d-function-list_maximized_state');
             sidebar.classList.remove('d-function-list_minimized_state');
             content.classList.remove('d-content__wrapper_maximized');
             btn.classList.add('d-function-list__btn-cover');
             btn.classList.remove('d-function-list__btn-uncover');
         }
     </script>

    </head>
    <body class="d-page" onload="load()">
        <div class="d-page__wrapper">
            <div class="d-content__wrapper" id="content">
              ${next.body()}
            </div>
        </div>
        <footer class="d-footer">
            <div class="d-footer__content">
                <div class="d-footer__info">
                    <p class="d-footer__info_page-title">
                        ${title}
                    </p>
                </div>
                <div class="d-footer__generation-time">
                    <p class="d-footer__generation-time_label">
                        Built:
                        <span class="d-footer__generation-time_value">
                          <%!
                            import time
                            gen_time = time.strftime('%Y-%m-%d %H:%M:%S')
                          %>
                          ${gen_time}
                        </span>
                    </p>
                </div>
            </div>
        </footer>
    </body>
</html>
<html>
