// participate in the CNP (answer and do the task)

+!participate(A,Task)
   <: false // this intention is finished only by the internal action .done, since the goal condition ('false') will never hold
   <- !price(Task,Offer);
      +my_offer(Offer);
      .send(A,tell,::propose(Offer)).
   // the sub plans below are relevant only while the intention for +cfp is 'running'
   { +::accept_proposal
       <- //.print("My proposal '",Offer,"' won CNP ",CNPId, " for ",Task,"!");
          +i_am_winner;
          !do;
          .send(A,tell,::done);
          .done.
      +::reject_proposal
       <- //.print("I lost CNP ",CNPId, ".");
          .done.
   }
