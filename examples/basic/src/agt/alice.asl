!register.
+!register <- .df_register(initiator).

+!start_cnp(CNP_Id,Task,TimeOut)
    <-  .include("$cnp/agt/initiator.asl", CNP_Id); // loads initiator.asl into namespace CNP_Id
        //.include("../../src/agt/initiator.asl", CNP_Id); // loads initiator.asl into namespace CNP_Id
        !CNP_Id::cnp(Task,TimeOut).

// the following plans react to some evolution of the CNP

+CNP_Id::winner(Ag) : CNP_Id::propose(Offer)[source(Ag)]
    <- .print("Agent ",Ag," won the CNP ", CNP_Id, " with offer ",Offer).
+CNP_Id::done : CNP_Id::winner(Ag)
    <- .print(Ag," has finished the task").
       // TODO: remove the namespace
