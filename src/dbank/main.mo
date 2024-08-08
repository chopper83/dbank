import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Time "mo:base/Time";
import Float "mo:base/Float";
//we create this project first on ubuntu by typing dfx new DBANK where DBANK is the name of the project we want to create
//Then we open it on vscode by clicking WSL in the bottom and clicking connect to wsl and only then we can open the created project
//**if u get a error while doing dfx deploy or npm start then paste this on terminal npm install webpack-cli@4.10.0 --save-dev
//creating a canister called DBank and keyword for creating is actor with a variable currentValue=300
//to reassign we use := instead of just = in java and js
//we import Debug module to use print functions
//print function expects a text in "" so to print other variables we use debug_show(variable) to display the variable value
//let keyword unlike var is used to store constants
//we write functions  with func keyword and close it with a ; after the end of the closing curly bracket
//by default functions inside the canisters are private and cannot be accessed from outside so we need to add
//a keyword public before func to make it accessible from outside(from terminal) like in java but once public it cannot be called inside the canister
//we call it outside in the terminal by saying dfx canister call dbank topup where dbank is the canister name and topup is the function name 

//candid is an interface description language used to interact with the canisters so that we can call the function by just simply clicking a button
//we use dfx canister id __Candid_UI in the terminal to get the id which is r7inp-6aaaa-aaaaa-aaabq-cai
//then we paste this on the browser to access the interface http://127.0.0.1:8000/?canisterId=r7inp-6aaaa-aaaaa-aaabq-cai
//in the interface the id it asks can be obtained by typing dfx canister id dbank in the terminal where dbank is the canister name

//while creating parameters in a function we have to specify the datatype and Nat means natural number that starts from 0 and and only positive
//after every change we have to deploy it again to save the changes and after every deploy the variables get reset to their initial value

//there r two types of calls in motoko callled update and query and update usually takes time as we r changing the state of the canister and then persisting it
//query calls r faster as we r not changing anything and they r synchronous 
//withdraw and topUp functions mentioned here r update methods hence they take time
//query methods r declared as public query func functionName(){} and they r read only methods
//if u want the function to return a value then at the end we have say :async Nat where Nat is the return type and it has to be returned 
//asynchronously hence the async keyword before the return type eg:public query func functionName():async Nat{}

//orthogonal persistence is the process of holding on to the state of the variables even after deploying it again
//usually when we deploy after some changes its like refreshing a page and all variables go to their original value
//when u add stable keyword before a variable its state is persisted even after deploying 
//for eg:the current value when topped up by lets say 100 its value increases but that increased value is reset when u deploy aagain 
//when u use stable before currentvalue then the increased value is persisted across cycles 

//compound interest is ,the interest we get every year is invested back with the original invested amount and it accumalates over a 
//specified amount of time and the total amount in the end is the compound interest amount
//the formula is A=P(1+r/n)^t where p is the principal,r is the rate of interest,n is the number of times we get interest in a year like once a year
//or twice a year and t is the total number of years u want to continue this investment.

// let startTime=Time.now(); shows how much time has elapsed since 1970 january 1st

//index.js is the bridge that connects the backend motoko file main.mo with the front end html and css
//we have to import the dbank module and we import the dbank in the declaration folder which contains all the functions in way java script understands and not the main.mo in the dbank folder

//**u need icp tokens for computations when u deploy it in the live internet computer network,u burn the tokens to keep the canisters running
//theres a free way to do it,dfinity provides 20$ worth free cycles to build on the internet computer and a github account that is atleast  90 days old is required
//


actor dbank{
   stable var currentValue:Float=300;
  currentValue:=300;
  //let now :()->Time;
  stable var startTime=Time.now();
  startTime:=Time.now();

   Debug.print(debug_show(startTime));

  let id=23456677;

  //Debug.print(debug_show(id));

  public func topUp(amount:Float){
    currentValue+=amount;
    Debug.print(debug_show(currentValue));
  };
  public func withDraw(amount:Float){
    let temp:Float=currentValue-amount;//we use this instead of currentvalue-amount in if statement because it throws a warning saying 
    //it does not know what the output data type is and might throw an error so we use a temp as int variable to store the value
    if(temp>=0){
    currentValue-=amount;
    Debug.print(debug_show(currentValue));
    }else{
      Debug.print("Withdrawal amount exceeded the current balance");
    }
  };
  public query func checkBalance():async Float{
    return currentValue;
  };
  public func compound(){
    let currentTime=Time.now();//calculate interest for every second ie ^second
    let timeElapsedNS=currentTime-startTime;
    let timeElapsedS=timeElapsedNS/1000000000;//converting nanosecond to second is nanosecond* 1 followed by 9 zeroes
    currentValue:=currentValue*(1.01**Float.fromInt(timeElapsedS));//** is ^ in mokoto and 1.01 is 1+.01 in formula
    startTime:=currentTime;//to update the compound interest, every time we call the time should start from previous value

  };
  
}