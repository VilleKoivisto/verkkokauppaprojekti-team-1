import React from 'react'
import './App.css'

const App = () => (
  <div>
    <Main_page />
  </div>
)


const Main_page = () => {
  return (
    <div>
      <div id="mainWrapper">
  <header> 
    <div id="headerLinks"><a href="#" title="Login/Register">Kirjaudu/Rekisteröidy</a><a href="#" title="Cart">Ostoskori</a></div>
  </header>
  <section id="offer"> 
    <h2>Hannibalin Valinta - 100% kotimaista luomulihaa jalostuneeseen makuun</h2>
    <p>KAIKKI ALKOHOLISTIN TUOTTEET NYT -50%! Kampanja voimassa 30.12 asti!</p>
  </section>
  <div id="content">
    <section class="sidebar"> 
      <input type="text"  id="search" value="search" />
      <div id="menubar">
        <nav class="menu">
          <h2>Hannibalin Valinta </h2>
          <hr></hr>
          <ul>
          <li><a href="#" title="Link">Sisäelimet</a></li>
            <li><a href="#" title="Link">Ruumiinosat</a></li>
            <li><a href="#" title="Link">Oheistuotteet - viinit, kastikkeet jne</a></li>
            <li><a href="#" title="Link">Alelaari - alkoholistit, tupakoitsijat</a></li>
            <li><a href="#" title="Link">Premium tuotteet - urheilijat jne</a></li>
          </ul>
        </nav>
      </div>
    </section>
    <section class="mainContent">
      <div class="productRow">
        <article class="productInfo">
          <div><img alt="sample" src={require('./images/brain.jpg')} /></div> 
          <p class="price">349,99 €</p>
          <p class="productContent">Aivot</p>
          <input type="button" name="button" value="Buy" class="buyButton" />                
        </article>
        <div class="productinfo"><p>Hyvin koulutetut ja mehukkaat. Gluteeniton. </p></div>

        <article class="productInfo">
          <div><img alt="sample" src={require('./images/liver.jpg')} /></div>
          <p class="price">276,48 €</p>
          <p class="productContent">Maksa</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <div class="productinfo"><p>Sopii hyvin punaviinin kanssa </p></div>

        <article class="productInfo"> 
          <div><img alt="sample" src={require('./images/heart.jpg')} /></div>
          <p class="price">167 €</p>
          <p class="productContent">Sydän</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <div class="productinfo"><p>Vahingoittumaton, pumppaa erinomaisesti. Vähälaktoosinen. </p></div>
        </div>

<div class="productRow">
        <article class="productInfo"> 
          <div><img alt="sample" src={require('./images/lungs_h.jpg')} /></div>
          <p class="price">148 €</p>
          <p class="productContent">Keuhkot</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <div class="productinfo"><p>Henkeäsalpaava makuelämys! </p></div>

        <article class="productInfo">
          <div><img alt="sample" src={require('./images/lungs_b.jpg')} /></div>
          <p class="price">23 €</p>
          <p class="productContent">Tupakoijan keuhkot</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <div class="productinfo"><p>30 vuoden savustus. Paljon rapsakammat kuin terveet keuhkot </p></div>

        <article class="productInfo">
          <div><img alt="sample" src={require('./images/fingers.jpg')} /></div>
          <p class="price">5 €/kpl</p>
          <p class="productContent">Sormia</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <div class="productinfo"><p>Suosittelemme mukaan chili-dippiä. </p></div>
        </div>

        <div class="productRow">
        <article class="productInfo">
          <div><img alt="sample" src={require('./images/ribs.jpg')} /></div>
          <p class="price">$50</p>
          <p class="productContent">Ribsit</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <div class="productinfo"><p>Erittäin maukkaat. </p></div>
        
        <article class="productInfo">
          <div><img alt="sample" src={require('./images/leg.jpg')} /></div>
          <p class="price">$50</p>
          <p class="productContent">Jalka</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <div class="productinfo"><p>Tällä on kyykätty paljon. Yhtään jalkapäivää ei ole skipattu. </p></div>

        <article class="productInfo">
          <div><img alt="sample" src={require('./images/arm.jpg')} /></div>
          <p class="price">$50</p>
          <p class="productContent">Käsi</p>
          <input type="button" name="button" value="Buy" class="buyButton" />          
        </article>
        <div class="productinfo"><p>Kaikki sormet tallella </p></div>
      </div>

        <div class="productRow">
        <article class="productInfo">
          <div><img alt="sample" src={require('./images/tongue.jpg')} /></div>
          <p class="price">$50</p>
          <p class="productContent">Kieli</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <div class="productinfo"><p>Vie kielen mennessään. </p></div>
        
        <article class="productInfo">
        </article>
        

        <article class="productInfo">              
        </article>

      </div>
      </section>
    <section id="offer">
      <div class="alaboksi">
        <p>Ostettu usein yhdessä</p>
        <div>
        <img alt="sample" src={require('./images/liver.jpg')} />       
        <img alt="chianti" src={require('./images/chianti.jpg')} /></div>
      </div>        
    </section>

  </div>
  <footer> 
    <div>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam varius sem neque. Integer ornare.</p>
    </div>
    <div>
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam varius sem neque. Integer ornare.</p>
    </div>
    <div class="footerlinks">
      <p><a href="#" title="Link">Yhteydenotto</a>
      <a href="#" title="Link">Hae meille töihin!</a>
      <a href="#" title="Link">FAQ</a></p>
    </div>
  </footer>
</div>
    </div>   
  )
}

export default App