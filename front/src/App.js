import React from 'react'
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
    <div id="logo"> <img src="logoImage.png" alt="sample logo" />  
       Company Logo text  
      LOGO </div>
    <div id="headerLinks"><a href="#" title="Login/Register">Login/Register</a><a href="#" title="Cart">Cart</a></div>
  </header>
  <section id="offer"> 
    <h2>JOPA 50% ALENNUSTA</h2>
    <p>ALKOHOLIHARRASTAJAN MAKSA -50%</p>
  </section>
  <div id="content">
    <section class="sidebar"> 
      <input type="text"  id="search" value="search" />
      <div id="menubar">
        <nav class="menu">
          <h2>Sisäelimet </h2>
          <hr></hr>
          <ul>
            <li><a href="#" title="Link">Link 1</a></li>
            <li><a href="#" title="Link">Link 2</a></li>
            <li><a href="#" title="Link">Link 3</a></li>
            <li class="notimp"><a href="#"  title="Link">Link 4</a></li>
          </ul>
        </nav>
        <nav class="menu">
          <h2>Oheistuotteet </h2>
          <hr></hr>
          <ul>
            <li><a href="#" title="Link">Fava Beans</a></li>
            <li><a href="#" title="Link">Chianti</a></li>
            <li><a href="#" title="Link"></a></li>
            <li class="notimp"><a href="#" title="Link">Link 4</a></li>
          </ul>
        </nav>
      </div>
    </section>
    <section class="mainContent">
      <div class="productRow">
        <article class="productInfo">
          <div><img alt="sample" src="eCommerceAssets/images/200x200.png" /></div>
          <p class="price">$50</p>
          <p class="productContent">Aivot</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <article class="productInfo">
          <div><img alt="sample" src="eCommerceAssets/images/200x200.png" /></div>
          <p class="price">$50</p>
          <p class="productContent">Maksa</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <article class="productInfo"> 
          <div><img alt="sample" src="eCommerceAssets/images/200x200.png" /></div>
          <p class="price">$50</p>
          <p class="productContent">Keuhkot</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
      </div>
      <div class="productRow"> 
        <article class="productInfo"> 
          <div><img alt="sample" src="eCommerceAssets/images/200x200.png" /></div>
          <p class="price">$50</p>
          <p class="productContent">Sormi</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <article class="productInfo">
          <div><img alt="sample" src="eCommerceAssets/images/200x200.png" /></div>
          <p class="price">$50</p>
          <p class="productContent">Content holder</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <article class="productInfo">
          <div><img alt="sample" src="eCommerceAssets/images/200x200.png" /></div>
          <p class="price">$50</p>
          <p class="productContent">Content holder</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
      </div>
      <div class="productRow">
        <article class="productInfo">
          <div><img alt="sample" src="eCommerceAssets/images/200x200.png" /></div>
          <p class="price">$50</p>
          <p class="productContent">Content holder</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <article class="productInfo">
          <div><img alt="sample" src="eCommerceAssets/images/200x200.png" /></div>
          <p class="price">$50</p>
          <p class="productContent">Content holder</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
        <article class="productInfo">
          <div><img alt="sample" src="eCommerceAssets/images/200x200.png" /></div>
          <p class="price">$50</p>
          <p class="productContent">Content holder</p>
          <input type="button" name="button" value="Buy" class="buyButton" />
        </article>
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
      <p><a href="#" title="Link">Link 1 </a></p>
      <p><a href="#" title="Link">Link 2</a></p>
      <p><a href="#" title="Link">Link 3</a></p>
    </div>
  </footer>
</div>
    </div>
  )
}


export default App