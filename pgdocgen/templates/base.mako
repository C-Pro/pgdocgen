<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <link rel="stylesheet" href="styles/documentation_functions.css" />
        <title>${title}</title>
    </head>
    <body class="d-page">
        <div class="d-page__wrapper">
            ${next.body()}        
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
