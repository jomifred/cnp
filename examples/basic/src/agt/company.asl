!register.
+!register <- .df_register("participant").

// receives the announce of a new CNP in namespace CNP_Id from A
+CNP_Id::cfp(Task)[source(A)]
  :  true // decides whether to participate
  <- .include("$cnp/agt/participant.asl",CNP_Id); // load plans participate into namespace CNPId

     +CNP_Id::price((10*math.random)+100); // TODO: remove

     !CNP_Id::participate(A,Task). // start participation

// the following plans customise the participation in the CNP
// (they are used by participant.asl and so placed in CNPId namespace

// plan to compute the price for Task
+!CNP_Id::price(Task,P) <- .print(aqui3); P = (10*math.random)+100.

// plan to perform the contracted Task (here just print to illustrate)
+!CNP_Id::do <- .print("Doing my task for ",CNP_Id," .....").
