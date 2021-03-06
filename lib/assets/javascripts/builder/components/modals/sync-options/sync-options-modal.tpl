<div class="u-flex u-justifyCenter">
  <div class="Modal-inner Modal-inner--full u-flex u-justifyCenter">
    <div class="Modal-icon">
      <svg width="24px" height="20px" viewBox="0 8 24 20" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
          <g id="Icon" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" transform="translate(0.000000, 8.000000)">
              <path d="M19.591513,9.26858726 C19.7142261,9.39218837 19.8745043,9.45462604 20.0347826,9.45462604 C20.1950609,9.45462604 20.3553391,9.39218837 20.4780522,9.26858726 C20.7222261,9.0201108 20.7222261,8.61617729 20.4780522,8.36770083 C20.1988174,8.08354571 19.908313,7.81468144 19.6065391,7.56365651 C19.5652174,7.52925208 19.5201391,7.4999446 19.4775652,7.46554017 C17.3914435,5.76952909 14.824487,4.84060942 12.1147826,4.84060942 L12.1122783,4.84060942 L12.1097739,4.84060942 C8.95053913,4.84060942 5.98038261,6.0931856 3.74775652,8.36770083 C3.50358261,8.61617729 3.50358261,9.0201108 3.74775652,9.26858726 C3.87046957,9.3934626 4.03074783,9.45462604 4.19102609,9.45462604 C4.35130435,9.45462604 4.51158261,9.39218837 4.63304348,9.26858726 C6.63151304,7.23490305 9.28737391,6.11484765 12.1122783,6.11484765 C14.9371826,6.11484765 17.5930435,7.23490305 19.591513,9.26858726 L19.591513,9.26858726 Z" id="Shape" fill="#2E3C43"></path>
              <path d="M22.7607652,5.95695291 C22.8834783,6.08182825 23.0437565,6.14299169 23.2040348,6.14299169 C23.364313,6.14299169 23.5245913,6.08055402 23.6473043,5.95695291 C23.8914783,5.70847645 23.8914783,5.30454294 23.6473043,5.05606648 C17.2862609,-1.41706371 6.93704348,-1.41451524 0.578504348,5.05606648 C0.334330435,5.30454294 0.334330435,5.70847645 0.578504348,5.95695291 C0.822678261,6.20542936 1.21961739,6.20542936 1.4637913,5.95695291 C7.33398261,-0.0179501385 16.8905739,-0.0166759003 22.7607652,5.95695291 L22.7607652,5.95695291 Z" id="Shape" fill="#2E3C43"></path>
              <path d="M9.58789565,9.966759 C8.61495652,10.3273684 7.69586087,10.8854848 6.91575652,11.6793352 C6.67158261,11.9278116 6.67158261,12.3317452 6.91575652,12.5802216 C7.03846957,12.705097 7.19874783,12.7662604 7.35902609,12.7662604 C7.51930435,12.7662604 7.67958261,12.7038227 7.80229565,12.5802216 C10.1789217,10.1642659 14.046887,10.1642659 16.4247652,12.5802216 C16.5474783,12.705097 16.7077565,12.7662604 16.8680348,12.7662604 C17.028313,12.7662604 17.1885913,12.7038227 17.3113043,12.5802216 C17.5554783,12.3317452 17.5554783,11.9278116 17.3113043,11.6793352 C15.2239304,9.55645429 12.1924174,8.99961219 9.58789565,9.966759 L9.58789565,9.966759 Z" id="Shape" fill="#2E3C43"></path>
              <path d="M12.1122783,14.1359557 C10.5307826,14.1359557 9.2448,15.4445983 9.2448,17.052687 C9.2448,18.6620499 10.5307826,19.9706925 12.1122783,19.9706925 C13.6925217,19.9706925 14.9785043,18.6620499 14.9785043,17.052687 C14.9785043,15.4458726 13.6925217,14.1359557 12.1122783,14.1359557 L12.1122783,14.1359557 Z M12.1122783,18.6977285 C11.2219826,18.6977285 10.4969739,17.9599446 10.4969739,17.0539612 C10.4969739,16.1479778 11.2219826,15.4114681 12.1122783,15.4114681 C13.0025739,15.4114681 13.7263304,16.1479778 13.7263304,17.0539612 C13.7263304,17.9599446 13.0025739,18.6977285 12.1122783,18.6977285 L12.1122783,18.6977285 Z" id="Shape" fill="#2E3C43"></path>
          </g>
      </svg>
    </div>
    <div>
      <h2 class="CDB-Text CDB-Size-huge is-light u-bSpace--m">
        <%- _t('dataset.sync.title') %>
      </h2>
      <p class="CDB-Text CDB-Size-medium u-altTextColor" style="white-space: pre-wrap;"><%= _t('dataset.sync.desc', {
        service: service,
        url: url
      }) %></p>
      <div class="Modal-listTextItem u-flex u-alignCenter">
        <h3 class="CDB-Text CDB-Size-small is-semibold u-upperCase"><%- _t('dataset.sync.label') %></h3>
        <ul class="Modal-listForm u-flex u-alignCenter CDB-Text CDB-Size-small js-intervals">
          <li class="Modal-listFormItem">
            <input class="CDB-Radio" type="radio" name="interval" value="3600"
              <% if (interval === 3600) { %>
                checked
              <% } %>

              <% if (isExternalSource) { %>
                disabled
              <% } %>
            >
            <span class="u-iBlock CDB-Radio-face"></span>
            <label class="u-iBlock u-lSpace u-upperCase">Every hour</label>
          </li>
          <li class="Modal-listFormItem">
            <input class="CDB-Radio" type="radio" name="interval" value="86400"
              <% if (interval === 86400) { %>
                checked
              <% } %>

              <% if (isExternalSource) { %>
                disabled
              <% } %>
            >
            <span class="u-iBlock CDB-Radio-face"></span>
            <label class="u-iBlock u-lSpace u-upperCase">Every day</label>
          </li>
          <li class="Modal-listFormItem">
            <input class="CDB-Radio" type="radio" name="interval" value="604800"
              <% if (interval === 604800) { %>
                checked
              <% } %>

              <% if (isExternalSource) { %>
                disabled
              <% } %>
            >
            <span class="u-iBlock CDB-Radio-face"></span>
            <label class="u-iBlock u-lSpace u-upperCase">Every week</label>
          </li>
          <li class="Modal-listFormItem">
            <input class="CDB-Radio" type="radio" name="interval" value="2592000"
              <% if (interval === 2592000) { %>
                checked
              <% } %>
            >
            <span class="u-iBlock CDB-Radio-face"></span>
            <label class="u-iBlock u-lSpace u-upperCase">Every month</label>
          </li>
          <li class="Modal-listFormItem">
            <input class="CDB-Radio" type="radio" name="interval" value="0"
              <% if (interval === 0) { %>
                checked
              <% } %>
            >
            <span class="u-iBlock CDB-Radio-face"></span>
            <label class="u-iBlock u-lSpace u-upperCase">Never</label>
          </li>
        </ul>
      </div>
      <ul class="Modal-listActions u-flex u-alignCenter">
        <li class="Modal-listActionsitem">
          <button class="CDB-Button CDB-Button--secondary CDB-Button--big js-cancel">
            <span class="CDB-Button-Text CDB-Text is-semibold CDB-Size-medium u-upperCase">
              <%- _t('dataset.sync.cancel') %>
            </span>
          </button>
        </li>
        <li class="Modal-listActionsitem">
          <button class="CDB-Button CDB-Button--primary CDB-Button--big js-confirm">
            <span class="CDB-Button-Text CDB-Text is-semibold CDB-Size-medium u-upperCase">
              <%- _t('dataset.sync.confirm') %>
            </span>
          </button>
        </li>
      </ul>
    </div>
  </div>
</div>


