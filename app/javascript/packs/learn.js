const initLearn = () => {


  $(document).ready(function () {


    const resultDiv = document.querySelector(".result")
    if (resultDiv) {
      console.log("learn activé")
    const cardsRecto = document.querySelectorAll('.flip-card')
    const cardsVerso = document.querySelectorAll('.flip-card-inner')
    const btnYes = document.querySelector('#yes')
    const btnNo = document.querySelector('#no')
    const btnShow = document.querySelector("#show-card")
    const btnNext = document.querySelector("#btn-next")
    const progressBar = document.querySelector(".progress-bar")
    const nbMaxCard = 7
    const score = document.querySelector(".score")

    let trueAnswer = 0
    let falseAnswer = 0

    progressBar.style.width = "0%"
    //const answer = $("#answer").value
    let i = -1;

    const hide = (card) => { //
      card.classList.add('hidden')
    }

    const show = (card) => { //nouveau recto
      card.classList.remove('hidden')
      btnYes.style.display = "none"
      btnNo.style.display = "none"
      btnNext.style.display = "none"
      btnShow.style.display = "block"
    }

    const reveal = (card) => { //quand on montre le verso
       card.style.transform = "rotateY(180deg)"
       btnYes.style.display = "block"
       btnNo.style.display = "block"
       btnShow.style.display = "none"
     }

    const result = () => {
      btnYes.style.display = "none"
      btnNo.style.display = "none"
      resultDiv.style.display = "block"
      resultDiv.innerHTML =
        `Fecilitation vous avez terminé !
        <div class = "score" > ${((trueAnswer / nbMaxCard) * 100).toFixed(1)}%</div>
        <hr>
        <a href="" class="btn center" id=btn-again>Recommencer ?</a>`
    }
    const next = () => {
      if (i >= 0) hide(cardsRecto[i])
      i++
      progressBar.style.width = `${((i / nbMaxCard) * 100).toFixed(1)}%`
      if (i < nbMaxCard) {
        show(cardsRecto[i])

        return [cardsRecto[i], cardsVerso[i]]
      } else result()
    }

    let card = next()

    btnNext.addEventListener('click', () => { card = next()})
    btnShow.addEventListener('click', () => { reveal(card[1]) })
    btnYes.addEventListener('click', () => {
      trueAnswer++
      card = next()
     })
    btnNo.addEventListener('click', () => {
      falseAnswer ++
      card = next()
     })
  }})

}







export {initLearn}
