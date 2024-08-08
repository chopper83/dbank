import { dbank } from "../../declarations/dbank";

window.addEventListener("load", async function() {
  // console.log("finished loading");
    update();
  });

    //const form = document.getElementsByTagName("form")[0];
    //Yes, you can use document.getElementsByTagName("form") instead of document.querySelector("form"). However, there are a few differences to be aware of:

//document.querySelector("form") selects the first <form> element it finds in the document.
//document.getElementsByTagName("form") returns a live HTMLCollection of all <form> elements in the document.
//Since document.getElementsByTagName("form") returns a collection, you need to access the specific form element you want to add the event listener to. If there's only one form, you can access it using [0]

    document.querySelector("form").addEventListener("submit",async function(event){
      event.preventDefault();
      //alternate const button=document.getElementById("submit-btn");
      const button=event.target.querySelector("#submit-btn");
      

      const inputAmount=parseFloat(document.getElementById("input-amount").value);
      const withdrawAmount=parseFloat(document.getElementById("withdrawal-amount").value);

      button.setAttribute("disabled",true);

      if(document.getElementById("input-amount").value.length!=0){
        await dbank.topUp(inputAmount);
      }
      if(document.getElementById("withdrawal-amount").value.length!=0){
        await dbank.withDraw(withdrawAmount);
      }

      await dbank.compound();

      update();

    document.getElementById("input-amount").value="";
    document.getElementById("withdrawal-amount").value="";

  

      button.removeAttribute("disabled");

    });

    async function update() {
      const currentAmount = await dbank.checkBalance(); //since the check balance function in main.mo is async we have to make event listener async and use await
    //on dbank.checkbalance
    document.getElementById("value").innerText = Math.round(currentAmount*100)/100;

      
    }

    

    
 

