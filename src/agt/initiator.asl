
/* rules for CNP */

all_proposals_received
  :- nb_participants(NP) &                  // NP: number of participants
     .count(::propose(_)[source(_)], NO) &  // NO: number of proposes received
     .count(::refuse[source(_)], NR) &      // NR: number of refusals received
     NP = NO + NR.


+!cnp(Task,TimeOut)
    <: state(end) // condition for this intention finish
    <- !call; !bids; !winner(LO); !result(LO). {

    // the plans below are !cnp sub-plans and
    // are relevant only while !cnp is being pursued

    +!call
       <- -+state(call);
          +task(Task); // remember the task of this CNP
          .df_search("participant",LP);
          .print("Sending CFP to ",LP);
          +nb_participants(.length(LP));
          .send(LP,tell,::cfp(Task)).

    +!bids : all_proposals_received. // all proposals received already! bids is thus achieved
    +!bids  // wait either for all proposals/refuses or a timeout
       <: false // this intention is finished only by the internal action .done, since the goal condition ('false') will never hold
       <- -+state(bidding);
          .wait(TimeOut);
          .done. // wait for TimeOut seconds and then finish the intention

       {  // the two plans below are relevant only while !bids is being pursued
          +propose(_) : all_proposals_received <- .done. // if a propose is received, test if all are, if so, finish the intention
          +refuse     : all_proposals_received <- .done.
       }

    +!winner(LO)
        : .findall(offer(O,A),::propose(O)[source(A)],LO) & LO \== []
       <- //.print("Offers are for ",Task," are ",LO);
          .min(LO,offer(WOf,WAg)); // sort offers, the first is the best
          +winner(WAg).
          //.print("Winner for ",Task," is ",WAg," with ",WOf).
    +!winner([])
       <- //.print("CNP ",Id," with no offer!").
          +winner(nowinner).

    +!result(LO)
        : winner(WAg)
       <- -+state(result);
          for( .member( offer(_,WAg), LO) ) {
             .send(WAg,tell,::accept_proposal);
          }
          for( .member( offer(_,Ag), LO) & Ag \== WAg) {
             .send(Ag, tell,::reject_proposal);
          }.

   +done 
       <- -+state(finished);
          -+state(end).
}
