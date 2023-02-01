!register.
+!register <- .df_register(initiator).

+!start_cnp(CNPId,Task,TimeOut)
    <-  .include("jar:file:/Users/jomi/tmp/cnp/build/libs/cnp-1.0.0.jar!/agt/initiator.asl", CNPId); // loads initiator.asl into namespace CNPId
        //.include("$cnp/agt/initiator.asl", Id); // loads initiator.asl into namespace Id
        !CNPId::cnp(Task,TimeOut).


// the following plans react to some evolution of the CNP

+CNPId::winner(Ag) : CNPId::propose(Offer)[source(Ag)]
    <- .print("Agent ",Ag," won the CNP ", CNPId, " with offer ",Offer).
+CNPId::done : CNPId::winner(Ag)
    <- .print(Ag," has finished the task").
       // TODO: remove the namespace
